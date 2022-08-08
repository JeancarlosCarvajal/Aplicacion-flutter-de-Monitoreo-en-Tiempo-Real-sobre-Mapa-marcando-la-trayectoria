part of 'location_bloc.dart';

// quite el abstract
class LocationState extends Equatable {

  // ver si estoy siguiendo al usuario
  final bool followingUser;

  // ultimo geolocation conocido del usuario
  final LatLng? lastKnowLocation;

  // HIstorial de navegacion
  final List<LatLng> myLocationHistory;

  const LocationState({
    this.followingUser = false,
    this.lastKnowLocation, 
    myLocationHistory
  }): myLocationHistory = myLocationHistory ?? const []; // en caso que no mande este valor, entoces sera un array vacio [] por defecto

  // creamo el copyWith para ser usado y no mutar el objeto  
  LocationState copyWith({
    bool? followingUser,
    LatLng? lastKnowLocation,
    List<LatLng>? myLocationHistory
  }) => LocationState(
    followingUser     : followingUser ?? this.followingUser, 
    lastKnowLocation  : lastKnowLocation ?? this.lastKnowLocation, 
    myLocationHistory : myLocationHistory ?? this.myLocationHistory, 
  );
  
  @override
  List<Object?> get props => [followingUser, lastKnowLocation, myLocationHistory];
}

// esto lo borre voy a tener unsa sola clase para manejar mi estado
// class LocationInitial extends LocationState {}
