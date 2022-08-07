import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {

  StreamSubscription? gpsServiceSubscription; // me importo dart:async

  GpsBloc() : super( const GpsState(isGpsPermissionGranted: false, isGpsEnabled: false) ) {

    on<GpsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GpsAddPermissionEvent>((event, emit) => emit(state.copyWidth(
        isGpsEnabled: event.isGpsEnabled,
        isGpsPermissionGranted: event.isGpsPermissionGranted
      ))
    );
    _init();
  }

  //
  Future<void> _init()async{
    // // verifica el status al inicial la app
    // final isEnabled = await _checkGpsStatus();
    // // verifica si tenemos permiso al iniciar la app
    // final isGranted = await _isPermissionGranted();
    // print('isEnabled: $isEnabled, isGranted: $isGranted');

    // hacer los dos future de manera simultanea 
    final List<bool> gpsInitStatus = await Future.wait([
      _checkGpsStatus(), // el 0
      _isPermissionGranted(), // el 1
    ]);
    
    // agregar un evento
    add(GpsAddPermissionEvent(
      isGpsEnabled: gpsInitStatus[0], 
      isGpsPermissionGranted: gpsInitStatus[1] // envia el estado donde se encuentre de momento
    ));
  }

  // verifica si ya tuvimos el permiso con anterioridad
  Future<bool> _isPermissionGranted() async {
    final isGranted = await Permission.location.isGranted;
    return isGranted;
  }


  // verificamos que tenemos el acceso al GPS.... NOO estamos pidiendo permisos aqui
  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();

    // ver el estado del evento.. 
    // esto evalua el estado del GPS en tiempo real, cuando se descativa o cuando se activa
    gpsServiceSubscription = Geolocator.getServiceStatusStream().listen((event) {
      final isEnabled = ( event.index == 1 ) ? true : false;
      print('Service status $isEnabled');

      // agregar un evento en tiempo real y se modifique
      add( 
        GpsAddPermissionEvent(
          isGpsEnabled: isEnabled, 
          isGpsPermissionGranted: state.isGpsPermissionGranted // envia el estado donde se encuentre de momento
        ) 
      );

    });
    return isEnable;
  }

  // pregunta si quiere dar permisos de geolocalizacion
  Future<void> askGpsAccess() async{
    // ver el estatus del permiso
    final status = await Permission.location.request();
    
    switch (status) { 
      case PermissionStatus.granted:
        add(GpsAddPermissionEvent(isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: true));
        break;
      case PermissionStatus.denied: 
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add(GpsAddPermissionEvent(isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: false));
        // me abre las setting para que el usuario pueda cambiar las opciones del gps
        openAppSettings();
    } 
  }


  // limpiar el listener del geolocator evita fugas de memoria
  @override
  Future<void> close() {
    // OJOJOJ el ? indica que si tienes un valor que cancelar cancelalo sinooo NO hagas nada.
    // OJO si le colocas ! estas diciebdo que este valor siempre va tener algo que NO va ser null entonces NO aplica en este caso
    gpsServiceSubscription?.cancel();
    return super.close();
  }

}
