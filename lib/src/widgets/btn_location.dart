import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/src/blocs/blocs.dart';
import 'package:maps_app/src/ui/ui.dart';

class BtnCurrentLocation extends StatelessWidget {
   
  const BtnCurrentLocation({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final LocationBloc locationBloc = BlocProvider.of<LocationBloc>(context);
    final MapBloc mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.red[500],
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(Icons.my_location_outlined),
          color: Colors.white,
          onPressed: (){
            
            // acceder al Bloc
            final userLocation = locationBloc.state.lastKnowLocation;
            
            // Snack Bar para que muestre mensaje personalizado
            if(userLocation == null) { 
              // el CustomSnackBar se creo en UI es un mensaje modal
              final snack = CustomSnackBar(message: 'No hay Ubicacion');
              ScaffoldMessenger.of(context).showSnackBar(snack);
              return;              
            }
            // si todo bien en caso si hay userLocation, seguimos con el codigo debajo
            // setear el seguimiento del usuario en true
            mapBloc.add(OnStartFollowingUserEvent());            
            // acceder al MapBloc para mover la camara a la ultima posicion conocida en el locationBloc
            mapBloc.moveCamera(userLocation);

          }, 
        ),
      ),
    );
  }
}