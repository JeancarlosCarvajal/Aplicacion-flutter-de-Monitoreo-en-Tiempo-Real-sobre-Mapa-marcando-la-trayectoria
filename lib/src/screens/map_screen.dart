import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/src/blocs/blocs.dart';

class MapScreen extends StatefulWidget { // lo converti a statufull para poder inicializar la ubicacion del usuario 
   
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  late LocationBloc locationBloc;

  @override
  void initState() { //se dispara una vez cuando se construye y puedo hacer una limpieza  
    super.initState();

    // acceso al bloc de location, para ver la ubicacion.. startFollowingUser es para verlo en tiempo real
    // esto se ejecuta de primero y renombramos el locationbloc con los datos y ya se pueden usar mas abajo
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser(); 
  }
  @override
  void dispose() {
    // acceso al bloc de location, para ver la ubicacion.. 
    // stopFolloingUser detener el stream de seguimiento dejar de escuchar cuando se cierre esta pantalla 
    locationBloc.stopFolloingUser(); 
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if( state.lastKnowLocation == null ) return const Center(child: Text( 'Esepere por favor...' ));
          return Center(
            child: Text( 'Latitude: ${state.lastKnowLocation!.latitude}, Longitud: ${state.lastKnowLocation!.longitude}' ),
          );
        },
      ),
    );
  }
}