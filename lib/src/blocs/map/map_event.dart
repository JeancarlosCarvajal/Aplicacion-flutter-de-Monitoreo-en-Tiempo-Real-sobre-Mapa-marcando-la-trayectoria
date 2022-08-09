part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

// se cre para capturar el GoogleMapController del mapa de Google
class OnMapInitializedEvent extends MapEvent {
  // controller que me va suministrar Google Map en el mapa
  final GoogleMapController controller;
  // constructor
  const OnMapInitializedEvent(this.controller);
}


class OnStopFollowingUserEvent extends MapEvent {}
class OnStartFollowingUserEvent extends MapEvent {}


// actualizar el Mapa de PolyLines que estan dentro del locationBloc en forma de arreglo
class UpdateUserPolylinesEvent extends MapEvent {
  final List<LatLng> userLocations;
  const UpdateUserPolylinesEvent(this.userLocations);
}

class OnToggleUserRoute extends MapEvent {}