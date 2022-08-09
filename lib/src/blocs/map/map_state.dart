part of 'map_bloc.dart';

class MapState extends Equatable {

  // saber si el mapa ha sido inicializado
  final bool isMapInitialized;
  // en caso que se quiera seguir al usuario
  final bool isFollowingUser;
  // polilines clase de Google
  final Map<String, Polyline> polylines;
  /*
    'mi_ruta: {
      id: polylineId de Google,
      points: [ [lat, long], [5165165, 5646546], [5165165, 5646546], [5165165, 5646546] ],
      width: 3,
      color: black87
    }
  */

  const MapState({
    this.isMapInitialized = false, 
    this.isFollowingUser = true,
    Map<String, Polyline>? polylines
  }): polylines = polylines ?? const {};

  MapState copyWith({
    bool? isMapInitialized, 
    bool? isFollowingUser,
    Map<String, Polyline>? polylines
  }) => MapState(
      isMapInitialized: isMapInitialized ?? this.isMapInitialized,
      isFollowingUser: isFollowingUser ?? this.isFollowingUser,    
      polylines: polylines ?? this.polylines
  );
  
  @override
  List<Object> get props => [isMapInitialized, isFollowingUser, polylines];
}
 
