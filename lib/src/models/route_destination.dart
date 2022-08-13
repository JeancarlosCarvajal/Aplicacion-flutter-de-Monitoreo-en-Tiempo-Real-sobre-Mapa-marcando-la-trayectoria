




import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/src/models/places_models.dart';

class RouteDestination {
  
   // son los puntos de la polyline
  final List<LatLng> points;
  // duracion del trayecto segun MapBox
  final double duration;
  // distancia desde inicio al fin del trayect
  final double distance;
  // lugar obtenido en funcion de la geolocalizacion
  final Feature? endPlace;

  RouteDestination({
    required this.points, 
    required this.duration, 
    required this.distance, 
    this.endPlace
  });


}