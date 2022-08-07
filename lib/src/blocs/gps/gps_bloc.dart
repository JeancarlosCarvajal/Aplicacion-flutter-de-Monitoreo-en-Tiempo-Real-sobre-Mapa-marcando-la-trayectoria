import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

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
    final isEnabled = await _checkGpsStatus();
    print('isEnabled: $isEnabled');
    
    // agregar un evento
    add(GpsAddPermissionEvent(
      isGpsEnabled: isEnabled, 
      isGpsPermissionGranted: state.isGpsPermissionGranted // envia el estado donde se encuentre de momento
    ));
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
      add(GpsAddPermissionEvent(
        isGpsEnabled: isEnabled, 
        isGpsPermissionGranted: state.isGpsPermissionGranted // envia el estado donde se encuentre de momento
      ));      
    });
    return isEnable;
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
