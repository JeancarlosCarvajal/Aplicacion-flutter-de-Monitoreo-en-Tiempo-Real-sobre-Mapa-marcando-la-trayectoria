import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  StreamSubscription<Position>? positionStream; // me importo 'dart:async'
  
  LocationBloc() : super(const LocationState()) { // tenia LocationInitial y lo cambie por LocationState()
    on<LocationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  // obtener la posicion actual del usuario una vez se tenga los permisos del gps
  Future getCurrentPosition() async {
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final Position position = await Geolocator.getCurrentPosition();
    print(position); 
    // TODO: retornar un objeto del tipo LatLong de google map
  }

  // darle seguimiento al usuario del gps
  void startFollowingUser(){ 
    print('startFollowingUser');
    
    // es para escuchar cualquier cambio en la ubicacion
    // simpre hay que limpiar los listen
    // 1) limpiarlo en el locartionBloc en el close
    // 2) se puede limpiar el en widget haciendo un dispose
    positionStream = Geolocator.getPositionStream().listen((event) {
      final position = event;
      print('Position: $position'); 
    });  
  }

  void stopFolloingUser(){
    // OJOJOJ el ? indica que si tienes un valor que cancelar cancelalo sinooo NO hagas nada.
    // OJO si le colocas ! estas diciebdo que este valor siempre va tener algo que NO va ser null entonces NO aplica en este caso
    positionStream?.cancel(); 
    print('stopFolloingUser');
    
  }
  

  @override
  Future<void> close() {
    stopFolloingUser();
    positionStream?.cancel();
    return super.close();
  }


}
