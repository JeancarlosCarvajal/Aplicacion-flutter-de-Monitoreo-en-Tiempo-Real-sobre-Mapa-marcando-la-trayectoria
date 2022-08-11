import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        return const Text( 'Aqui van los resultados' );
      },
    );
    // return Text( 'BuildResults' );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // implement buildSuggestions
    // return Text( 'BuildSuggestions' ); // para pruebas
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.location_on_outlined, color: Colors.black),
          title: const Text( 'Colocar la ubicacion manualmente', style: TextStyle(color: Colors.black) ),
          onTap: (){ 
            final SearchResult result = SearchResult(cancel: false, manual: true)  ;
            // es propio del SearchDelegate para deviolverte y salir de alli
            close(context, result);
          },
        )
      ],
    );
  }

}