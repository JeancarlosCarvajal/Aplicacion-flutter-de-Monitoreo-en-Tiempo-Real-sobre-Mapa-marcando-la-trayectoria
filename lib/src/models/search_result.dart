




import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/src/models/models.dart';

class SearchResult {

  // para saber si el usuario cancelo la busqueda
  final bool cancel;
  // colocar el marcado de manera manual
  final bool manual;
  // laltitud y longitu para usarla en el buscador por nombre del sitio
  final LatLng? position;
  final String? name;
  final String? description;
  final Feature? lastSearch; 

  SearchResult({
    required this.cancel, 
    this.manual = false,
    this.position, 
    this.name, 
    this.description,
    this.lastSearch
  });

  // TODO: tengo que hacer modificaciones
  // name, desciption, latlong

  //leer desde consola mas facil
  @override
  String toString() {
    return '{cancel: $cancel, manual: $manual}';
  }

}