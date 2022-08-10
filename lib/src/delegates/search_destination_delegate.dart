


import 'package:flutter/material.dart';



class SearchDestinationDelegate extends SearchDelegate {

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
          // el query es algo propio de SearchDelegate
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
        // es propio del SearchDelegate para deviolverte y salir de alli
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text( 'BuildResults' );
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
            // TODO: regresar algo
            close(context, null);
          },
        )
      ],
    );
  }

}