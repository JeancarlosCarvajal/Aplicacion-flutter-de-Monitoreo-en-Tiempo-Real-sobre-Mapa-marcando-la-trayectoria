part of 'map_bloc.dart';

class MapState extends Equatable {

  // saber si el mapa ha sido inicializado
  final bool isMapInitialized;
  // en caso que se quiera seguir al usuario
  final bool followUser;

  const MapState({
    this.isMapInitialized = false, 
    this.followUser = false
  });

  MapState copyWith({
    bool? isMapInitialized, 
    bool? followUser
  }) => MapState(
      isMapInitialized: isMapInitialized ?? this.isMapInitialized,
      followUser: followUser ?? this.followUser,    
  );
  
  @override
  List<Object> get props => [isMapInitialized, followUser];
}
 
