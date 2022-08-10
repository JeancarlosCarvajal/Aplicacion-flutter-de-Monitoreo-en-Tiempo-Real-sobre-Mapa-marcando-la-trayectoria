import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app/src/blocs/blocs.dart';

class ManualMarker extends StatelessWidget {

  const ManualMarker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker
          ? const _ManualMarkerBody()
          : const SizedBox();        
      },
    );
  }
}

class _ManualMarkerBody extends StatelessWidget {
   
  const _ManualMarkerBody({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;    
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          
          // Boton de atras quitar el manual marker
          const Positioned(
            top: 70,
            left: 20,
            child: _BtnBack()
          ),


          // marcador de position
          Center(
            child: Transform.translate(
              offset: const Offset(0, -20),
              child: BounceInDown(
                from: 100,
                child: const Icon(Icons.location_on_rounded, size: 60)
              ),
            ),
          ),

          // boton de confirmar
          Positioned(
            bottom: 70,
            left: 40,
            child: FadeInUp(
              duration: const Duration(milliseconds: 300),
              child: MaterialButton(
                minWidth: size.width - 120,
                color: Colors.black,
                elevation: 0,
                height: 30,
                shape: const StadiumBorder(),
                onPressed: () {
                  // TODO: confirmar la ubicacion
                  // print('jean: Boton de confirmar destino');
                  
                
                },
                child: const Text( 'Confirmar destino', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300) ),
              ),
            )
          )

        ],
      ),
    );
  }
}

class _BtnBack extends StatelessWidget {
  const _BtnBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 300),
      child: CircleAvatar(
        maxRadius: 30,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: (){
            // cancelar el marcador manual
            final searchBloc = BlocProvider.of<SearchBloc>(context);
            searchBloc.add(OnDeactivateManualMarkerEvent());
          }, 
        ),
      ),
    );
  }
}