import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/src/blocs/blocs.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  // hacer conexion con el locationBloc. obligatiro se neceita acceso obligatorio
  final LocationBloc locationBloc;

  GoogleMapController? _mapController;

  // cerrar el listener StreamSubscription<LocationState>
  StreamSubscription<LocationState>? locationStateSubscription;

  MapBloc({
    required this.locationBloc
  }) : super(const MapState()) {

    // eventocuando se inicia el mapa
    on<OnMapInitializedEvent>( _onInitMap );

    // evento cuando se para se seguir el usuario o empiece a seguirlo
    on<OnStartFollowingUserEvent>( _onstartFolliwUser );
    on<OnStopFollowingUserEvent>((event, emit) => emit( state.copyWith( isFollowingUser: false )) );

    // Actualizar el mapa de polylineas
    on<UpdateUserPolylinesEvent>( _updatePolylineNewPoint );

    // activar el evento para quitar la linea de seguimiento del usuario
    // OJOJOJ el uso del ! indica que va coloar el mismo valor pero en sentido contrario es decir si esta en true coloca false
    on<OnToggleUserRoute>((event, emit) => emit(state.copyWith(showMyRoute: !state.showMyRoute)));

    //escuchar los cambios en el LocationBloc, para mover la camara en cada cambio de ubicacion del usuario
    locationStateSubscription = locationBloc.stream.listen(( locationState ) {
      // agregamos la ubicacion en el Map
      if( locationState.lastKnowLocation != null ){
        add(UpdateUserPolylinesEvent(locationState.myLocationHistory));
      }
      // cuando se hace referencia al state es del mismo bloc donde estamos
      if(!state.isFollowingUser) return;
      // cuando se hace referencia al evento localState se hace al bloc que estamos escuchando LocationBloc
      if( locationState.lastKnowLocation == null) return; 
      // print('jean: ${locationState.lastKnowLocation}'); 
      // al llegar aqui si tengo una loicalizacion
      moveCamera(locationState.lastKnowLocation!);

    });

  }

  // para obtner el GoogleMapController del GoogleMap
  void _onInitMap( OnMapInitializedEvent event, Emitter<MapState> emit ){  
    // Aqui estoy capturando el GoogleMapController inmediatamente que se inicia el mapa
    // se puede usar para varias cosas para manejar el mapa desde otras pantallas
    _mapController = event.controller;

    // agregamos estilos al mapa con nuestro Json
    // _mapController!.setMapStyle( jsonEncode(uberMapTheme) ); // el estilo por defecto es mejor es Venezuela

    // emitimos un evento
    emit(state.copyWith(isMapInitialized: true));  
  }

  // optimizacion para que al activar el seguimiento inmediatamente siga al usuario y no espere el delay de las siguiente corrdenadas
  // esta funcion es la que recibe el on() click encima del on y te dice que va recibir
  void _onstartFolliwUser(OnStartFollowingUserEvent event, Emitter<MapState> emit) {
    emit( state.copyWith( isFollowingUser: true ));
    // cuando se hace referencia al evento localState se hace al bloc que estamos escuchando LocationBloc
    if( locationBloc.state.lastKnowLocation == null) return;
    moveCamera(locationBloc.state.lastKnowLocation!); 
  }

  // metodo que actualiza la polyline que va dentro del evento on()
  void _updatePolylineNewPoint( UpdateUserPolylinesEvent event, Emitter<MapState> emit ) {

    final myRoute = Polyline( // Polyline() es un Objeto que viene de GoogleMaps de Flutter   
      polylineId: PolylineId('MyRoute'),
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.userLocations
    );

    // creamos una copia de las polylines actuales, se hace esto porque no podemos modificar un  Mapa que sea constante
    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    // Sobreescribimos la polyline al mapa de polylines creados
    currentPolylines['MyRoute'] = myRoute;
    emit( state.copyWith(polylines: currentPolylines));
  }

  // mover la camara donde quiera
  void moveCamera(LatLng newLocation) {
    final CameraUpdate  cameraUpdate = CameraUpdate.newLatLng(newLocation);
    // print('jean: Moviendo Camara'); 
    _mapController?.animateCamera( cameraUpdate );
  }

  @override
  Future<void> close() {
    // cerrar la susbscripcion del listener del locationBlo
    // RECUERDA ? indica que si viene el valor cancelalo sino no hagas nada
    locationStateSubscription?.cancel();
    return super.close();
  }


}
