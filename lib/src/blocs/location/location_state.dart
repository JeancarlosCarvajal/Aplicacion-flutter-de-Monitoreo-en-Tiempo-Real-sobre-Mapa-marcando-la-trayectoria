part of 'location_bloc.dart';

// quite el abstract
class LocationState extends Equatable {

  // ver si estoy siguiendo al usuario
  final bool isFollowingUser;

  // ultimo geolocation conocido del usuario
  final LatLng? lastKnowLocation;

  // HIstorial de navegacion
  final List<LatLng> myLocationHistory;

  const LocationState({
    this.isFollowingUser = false,
    this.lastKnowLocation, 
    myLocationHistory
  }): myLocationHistory = myLocationHistory ?? const []; // en caso que no mande este valor, entoces sera un array vacio [] por defecto

  // creamo el copyWith para ser usado y no mutar el objeto  
  LocationState copyWith({
    bool? isFollowingUser,
    LatLng? lastKnowLocation,
    List<LatLng>? myLocationHistory
  }) => LocationState(
    isFollowingUser   : isFollowingUser ?? this.isFollowingUser, 
    lastKnowLocation  : lastKnowLocation ?? this.lastKnowLocation, 
    myLocationHistory : myLocationHistory ?? this.myLocationHistory, 
  );
  
  @override
  List<Object?> get props => [isFollowingUser, lastKnowLocation, myLocationHistory];
}

// esto lo borre voy a tener unsa sola clase para manejar mi estado
// class LocationInitial extends LocationState {}
