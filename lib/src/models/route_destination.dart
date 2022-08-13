




import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteDestination {
  
   // son los puntos de la polyline
  final List<LatLng> points;
  // duracion del trayecto segun MapBox
  final double duration;
  // distancia desde inicio al fin del trayect
  final double distance;

  RouteDestination({
    required this.points, 
    required this.duration, 
    required this.distance
  });


}