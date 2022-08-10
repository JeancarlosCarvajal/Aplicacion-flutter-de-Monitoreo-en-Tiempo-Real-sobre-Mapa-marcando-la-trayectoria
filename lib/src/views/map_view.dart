import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/src/blocs/blocs.dart';

class MapView extends StatelessWidget {

  final LatLng initialLocation;

  final Set<Polyline> polylines;
   
  const MapView({
    Key? key, 
    required this.initialLocation, 
    required this.polylines
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final mapBloc = BlocProvider.of<MapBloc>(context);

    final CameraPosition initialCameraPosition = CameraPosition( 
      target: initialLocation, 
      zoom: 15
    );
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Listener( // escucha eventos del usuario par ver si movio la pantalla y dejar de seguir al objetivo del GPS
        onPointerMove: (pointerMoveEvent) => mapBloc.add(OnStopFollowingUserEvent()),
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          compassEnabled: false,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          polylines: polylines,
          
          // es una manera de capturar el controlador y tenerlo disponible en otro lado de la aplicacion 
          onMapCreated: (controller) => mapBloc.add(OnMapInitializedEvent(controller)), 
      
          // TODO: Markers
      
          // TODO: polylines
      
          // TODO: cuando se mueva el mapa 
      
        ),
      ),
    ); 
  }
}