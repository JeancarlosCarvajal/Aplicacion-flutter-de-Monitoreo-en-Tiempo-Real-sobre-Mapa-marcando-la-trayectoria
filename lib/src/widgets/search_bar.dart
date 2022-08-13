import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/src/blocs/blocs.dart';
import 'package:maps_app/src/delegates/delegates.dart';
import 'package:maps_app/src/models/models.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker
          ? const SizedBox()
          : FadeInDown(
              duration: const Duration(milliseconds: 300),
              child: const _SearchBarBody()
            );
      },
    );
  }
}

class _SearchBarBody extends StatelessWidget {
   
  const _SearchBarBody({Key? key}) : super(key: key);

  //
  void onSearchResult( BuildContext context, SearchResult result) async{
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final MapBloc mapBloc = BlocProvider.of<MapBloc>(context);
    final LocationBloc locationBloc = BlocProvider.of<LocationBloc>(context);
    if(result.manual == true){
      searchBloc.add(OnActivateManualMarkerEvent());
      return;
    } 

    // evaluar si tenemos una posicion
    if(result.manual == false && locationBloc.state.lastKnowLocation != null && searchBloc.state.places != [] && result.position != null) {
      // searchBloc.add(OnActivateManualMarkerEvent());
      // crea la linea de la ruta seleccionada
      final destination = await searchBloc.getCoorsStartToEndBloc( locationBloc.state.lastKnowLocation!, result.position! );
      // si la distancia es cero 0 entonces no llego datos de la API cancela todo
      if(destination.distance == 0) {
        print('jean: No hubo respuesta de la API noRoute');
        return;
      } 
      // guardamos la informacion del la ultima busqueda en el eventoHistory
      searchBloc.add(AddToHistoryEvent(result.lastSearch!));
      await mapBloc.drawRoutesPolylines( destination: destination, endPointSearch: result.position!);
      return;
    } 
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        // color: Colors.red,
        width: double.infinity,
        height: 50,
        child: GestureDetector(
          onTap: () async {
            // print('jean: onTap');
            // regresa un T significa un dato tipo generico OJOJOJO
            final result = await showSearch(context: context, delegate: SearchDestinationDelegate());
            if(result == null) return; 
            print('jean: $result'); 
            onSearchResult(context, result);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 5)
                )
              ]
            ),
            child: const Text( 'Donde quieres ir ?', style: TextStyle(color: Colors.black87)),
          )
        ),
      ),
    );
  }
}