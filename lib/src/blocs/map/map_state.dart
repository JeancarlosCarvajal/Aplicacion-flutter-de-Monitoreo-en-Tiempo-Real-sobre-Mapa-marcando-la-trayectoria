part of 'map_bloc.dart';

class MapState extends Equatable {

  // saber si el mapa ha sido inicializado
  final bool isMapInitialized;
  // en caso que se quiera seguir al usuario
  final bool isFollowingUser;
  // para mostrar mi ruta en el mapa
  final bool showMyRoute;
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
  
  // captura la ubicacion final del usuario para crear una marca en la ruta
  final LatLng? endPontSearch;

  const MapState({
    this.isMapInitialized = false, 
    this.isFollowingUser = false,
    this.showMyRoute = true,
    this.endPontSearch,
    Map<String, Polyline>? polylines
  }): polylines = polylines ?? const {};

  MapState copyWith({
    bool? isMapInitialized, 
    bool? isFollowingUser,
    bool? showMyRoute,
    LatLng? endPontSearch,
    Map<String, Polyline>? polylines
  }) => MapState(
      isMapInitialized: isMapInitialized ?? this.isMapInitialized,
      isFollowingUser: isFollowingUser ?? this.isFollowingUser,    
      showMyRoute: showMyRoute ?? this.showMyRoute,
      endPontSearch: endPontSearch ?? this.endPontSearch,
      polylines: polylines ?? this.polylines
  );
  
  @override
  List<Object> get props => [isMapInitialized, isFollowingUser, polylines, showMyRoute];
}
 
