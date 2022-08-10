




class SearchResult {

  // para saber si el usuario cancelo la busqueda
  final bool cancel;
  // colocar el marcado de manera manual
  final bool manual;

  SearchResult({
    required this.cancel, 
    this.manual = false
  });

  // TODO: tengo que hacer modificaciones
  // name, desciption, latlong

  //leer desde consola mas facil
  @override
  String toString() {
    return '{cancel: $cancel, manual: $manual}';
  }

}