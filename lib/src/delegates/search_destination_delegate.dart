import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/src/blocs/blocs.dart';
import 'package:maps_app/src/models/models.dart';
import 'package:maps_app/src/services/services.dart';



// esta clase me va retornar un SearchResult siempre porque asi me lo va entregar el modelo junto con el resultadode la API
class SearchDestinationDelegate extends SearchDelegate<SearchResult> {

  // esto es propio del searchdelegate
  SearchDestinationDelegate():super(
    searchFieldLabel: 'Buscar...' 
  );

  @override
  List<Widget>? buildActions(BuildContext context) {
    // implement buildActions
    return [
      // Text( 'buildActions' ) // para pruebas
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: (){
          // el query es algo propio de SearchDelegate, limpia el buscador
          query = ''; 
        }, 
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // implement buildLeading
    // return Text( 'BuildLeading' ); // para pruebas
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: (){
        final SearchResult result = SearchResult(cancel: true)  ;
        // es propio del SearchDelegate para deviolverte y salir de alli
        close(context, result);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) { 
    //accedemos al search bloc para buscar el metodo que nos lleva  a la API
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    // obtnenemos la ultima ubicacion del ususario
    final proximity = BlocProvider.of<LocationBloc>(context).state.lastKnowLocation;
    // si la ultima localizacion no es null prosigue sino dame mensaje de no hay ubicacion inicial
    if(proximity == null) return const Text( 'No hay Ubicacion Inicial' );
    // llamando a la API pa que tenga la lista de lugares cercanos al proximity
    searchBloc.getPlacesByQueryBloc(proximity, query);
    // aqui va ir la respuesta de la api
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        // siempre vamos a tener un valor aunque sea vacio []
        final places = state.places;
        return  ListView.separated(
          separatorBuilder: (context, index) => const Divider(), // OJO al error, debe de contener el indes
          itemCount: places.length,
          itemBuilder: (context, index) {
            final place = places[index];
            return ListTile(
              title: Text( place.text ),
              subtitle: Text( place.placeName ),
              leading: const Icon(Icons.place_outlined, color: Colors.black),
              onTap: (){
                print('jean: Enviar a este lugar $place');
                final SearchResult result = SearchResult(
                  cancel: false, 
                  manual: false,
                  position: LatLng( place.center[1], place.center[0] ),
                  name: place.text,
                  description: place.placeName,
                  lastSearch: place
                );  
                // agregar el evento de guardar en el historial 
                // searchBloc.add(AddToHistoryEvent(place));
                close(context, result);
              }
            ); 
          }, 
        );
      },
    );
    // return Text( 'BuildResults' );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // implement buildSuggestions
    // return Text( 'BuildSuggestions' ); // para pruebas
    // final searchBloc = BlocProvider.of<SearchBloc>(context);
    // print('jean: ${searchBloc.state.searchHistory.length}');
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        // siempre vamos a tener un valor aunque sea vacio []
        final places = state.searchHistory; // si le agregas esto al final .reversed.toList() invierte el array
        // tuve que agregar el size y darle tamano a los componentes de la columna
        final size = MediaQuery.of(context).size; // para obtener datos de la pantalla
        return  SingleChildScrollView(
          child: Column(  
            children: [
              SizedBox(
                height: size.height*0.1,
                child: ListTile(
                  leading: const Icon(Icons.location_on_outlined, color: Colors.black),
                  title: const Text( 'Colocar la ubicacion manualmente', style: TextStyle(color: Colors.black) ),
                  onTap: (){ 
                    final SearchResult result = SearchResult(cancel: false, manual: true)  ;
                    // es propio del SearchDelegate para deviolverte y salir de alli
                    close(context, result);
                  }, 
                ),
              ),
              SizedBox(
                height: size.height*0.9,
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const Divider(), // OJO al error, debe de contener el indes
                  itemCount: places.length,
                  itemBuilder: (context, index) {
                    final place = places[index];
                    return ListTile(
                      title: Text( place.text ),
                      subtitle: Text( place.placeName ),
                      leading: const Icon(Icons.history_sharp, color: Colors.black),
                      onTap: (){
                        print('jean: Enviar a este lugar $place');
                        final SearchResult result = SearchResult(
                          cancel: false, 
                          manual: false,
                          position: LatLng( place.center[1], place.center[0] ),
                          name: place.text,
                          description: place.placeName,
                          lastSearch: place
                        );  
                        // agregar el evento de guardar en el historial 
                        // searchBloc.add(AddToHistoryEvent());
                        close(context, result);
                      }
                    ); 
                  }, 
                ),
              ),
            ]
          ),
        );
      },
    );
  }

}