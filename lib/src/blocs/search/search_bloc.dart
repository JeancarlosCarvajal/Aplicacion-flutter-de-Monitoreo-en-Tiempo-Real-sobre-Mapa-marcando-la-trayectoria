import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

import 'package:maps_app/src/models/models.dart';
import 'package:maps_app/src/services/services.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  // ver la respuesta de la API de trafficService
  TrafficService trafficService;

  SearchBloc({
    required this.trafficService
  }) : super(const SearchState()) {
 
    on<OnActivateManualMarkerEvent>((event, emit) {
      emit(state.copyWidth(displayManualMarker: true));
    }); 

    on<OnDeactivateManualMarkerEvent>((event, emit) {
      emit(state.copyWidth(displayManualMarker: false));
    });  

  }

  Future<RouteDestination> getCoorsStartToEndBloc(LatLng start, LatLng end) async{  
    final trafficResponse = await trafficService.getCoorsStartToEnd(start, end);
    // el geoometry viene codificado en polyline6 (Serializado en pares de valores) y debemos 
    // convertirlo a como quiere google Latitud y Longitud y MapBox viene al contrario

    // la API posiblemente me va responder con dos rutas o mas, pero solo voy a usar una sola ruta la primera es [0]
    final geometry = trafficResponse.routes[0].geometry;
    final distance = trafficResponse.routes[0].distance;
    final duration = trafficResponse.routes[0].duration;

    // decodifica la geometria en formato polyline6 con 6 nuemros accuracyExponent 6
    final points = decodePolyline(geometry, accuracyExponent: 6); 
    print(points);
    // .toList() para convertirlo en una lista
    final polyLines = points.map(( coors ) => LatLng(coors[0].toDouble(), coors[1].toDouble()) ).toList();
    return RouteDestination(
      points: polyLines, 
      duration: duration, 
      distance: distance
    );
  }


  // devolver la respuesta 
  Future getPlacesByQueryBloc(LatLng proximity, String query) async{
    final resp = trafficService.getResultByQuery(proximity, query);

    // TODO:  alamcenar en el state

  }


}
