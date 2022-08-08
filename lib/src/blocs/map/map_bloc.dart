import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app/src/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  GoogleMapController? _mapController;

  MapBloc() : super(const MapState()) {

    on<OnMapInitializedEvent>( _onInitMap );

  }

  // para obtner el GoogleMapController del GoogleMap
  void _onInitMap( OnMapInitializedEvent event, Emitter<MapState> emit ){  
    // Aqui estoy capturando el GoogleMapController inmediatamente que se inicia el mapa
    // se puede usar para varias cosas para manejar el mapa desde otras pantallas
    _mapController = event.controller;

    // agregamos estilos al mapa con nuestro Json
    _mapController!.setMapStyle( jsonEncode(uberMapTheme) );

    // emitimos un evento
    emit(state.copyWith(isMapInitialized: true));  
  }

  // mover la camara donde quiera
  void moveCamera(LatLng newLocation) {
    final CameraUpdate  cameraUpdate = CameraUpdate.newLatLng(newLocation) ; 
    _mapController?.animateCamera( cameraUpdate );
  }




}
