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
  void onSearchResult( BuildContext context, SearchResult result){
    final searchBloc = BlocProvider.of<SearchBloc>(context); 
    if(result.manual == true){
      searchBloc.add(OnActivateManualMarkerEvent());
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