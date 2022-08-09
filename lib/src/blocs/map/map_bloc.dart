import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/src/blocs/blocs.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  // hacer conexion con el locationBloc. obligatiro se neceita acceso obligatorio
  final LocationBloc locationBloc;

  GoogleMapController? _mapController;

  MapBloc({
    required this.locationBloc
  }) : super(const MapState()) {

    // eventocuando se inicia el mapa
    on<OnMapInitializedEvent>( _onInitMap );

    // evento cuando se para se seguir el usuario o empiece a seguirlo
    on<OnStartFollowingUserEvent>( _onstartFolliwUser );
    on<OnStopFollowingUserEvent>((event, emit) => emit( state.copyWith( isFollowingUser: false )) );

    //escuchar los cambios en el LocationBloc, para mover la camara en cada cambio de ubicacion del usuario
    locationBloc.stream.listen(( locationState ) {
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

  // mover la camara donde quiera
  void moveCamera(LatLng newLocation) {
    final CameraUpdate  cameraUpdate = CameraUpdate.newLatLng(newLocation);
    // print('jean: Moviendo Camara'); 
    _mapController?.animateCamera( cameraUpdate );
  }




}
