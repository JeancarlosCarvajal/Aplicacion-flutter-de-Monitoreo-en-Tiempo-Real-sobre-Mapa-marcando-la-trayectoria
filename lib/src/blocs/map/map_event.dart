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
  OnMapInitializedEvent(this.controller);
}


class OnStopFollowingUserEvent extends MapEvent {}
class OnStartFollowingUserEvent extends MapEvent {}