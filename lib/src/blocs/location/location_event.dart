part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent(); 
  @override
  List<Object> get props => [];
}


//crear evento, cuando el usuari tenga un nuevo evento
class OnNewUserLocationEvent extends LocationEvent {
  final LatLng newLocation;
  OnNewUserLocationEvent(this.newLocation);
}

// indicar el inicio y fin del seguimiento del usuario
class OnStartFollingUser extends LocationEvent {}
class OnStopFollingUser extends LocationEvent {}
