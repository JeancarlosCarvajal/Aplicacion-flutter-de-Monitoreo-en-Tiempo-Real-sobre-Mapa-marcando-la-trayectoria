import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 

import 'package:maps_app/src/blocs/blocs.dart';
import 'package:maps_app/src/views/views.dart';
import 'package:maps_app/src/widgets/widgets.dart';

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

          return SingleChildScrollView( // hay que definir dimenciones de los hijos sino da error
            child: Stack(
              children: [
                MapView(initialLocation: state.lastKnowLocation!),
          
                // TODO: Botones... 
                
              ],
            ),
          );

          // return GoogleMap(initialCameraPosition: initialCameraPosition); 
          // return Center(
          //   child: Text( 'Latitude: ${state.lastKnowLocation!.latitude}, Longitud: ${state.lastKnowLocation!.longitude}' ),
          // );

        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          BtnCurrentLocation()
        ],
      ),
    );
  }
}