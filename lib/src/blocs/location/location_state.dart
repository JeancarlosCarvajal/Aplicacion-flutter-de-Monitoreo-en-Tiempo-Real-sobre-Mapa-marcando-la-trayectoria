part of 'location_bloc.dart';

// quite el abstract
class LocationState extends Equatable {

  // ver si estoy siguiendo al usuario
  final bool followingUser;

  // TODO: ultimo geolocation conocido


  // TODO: HIstorial





  const LocationState({
    this.followingUser = false
  });
  
  @override
  List<Object> get props => [followingUser];
}

// esto lo borre voy a tener unsa sola clase para manejar mi estado
// class LocationInitial extends LocationState {}
