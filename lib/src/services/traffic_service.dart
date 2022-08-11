




import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart' as http;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/src/models/models.dart';
import 'package:maps_app/src/services/services.dart';

class TrafficService {

  // el dio sirve para dar formato a las respuestas http que tienen formato JSON y otras cosas mas
  final Dio _dioTraffic;

  final String _baseUrl = 'api.mapbox.com'; // para usar HTTP paquete

  final String _baseHTTPS = 'https://api.mapbox.com'; // para usar Dio paquete

  TrafficService()
    // : this._dioTraffic = Dio()..interceptors.add(TrafficInterseptor()); // configurar interseptores desde la clase nueva mas complejo pero otra forma de hacerlo, NO recomendada es mas trabajo
    : this._dioTraffic = Dio(); // Sin configurar interseptores, se configura mas abajo mas sesillooo OJOJOJOJO
 
  Future<TrafficResponse> getCoorsStartToEnd(LatLng start, LatLng end) async {
    // coordenada original
    // https://api.mapbox.com/directions/v5/mapbox/driving/-64.6704470511136,10.197819480066102;-64.68369719231988,10.181118808609341?alternatives=true&geometries=polyline6&overview=simplified&steps=false&access_token=API_KEY_MAPBOX
    
    // aqui accedemos al token de acceso de MapBox
    final apiMapBox = dotenv.env['MAPBOX_TOKEN']; // MAPBOX_TOKEN_STYLES   MAPBOX_TOKEN

    // tomamos los datos de la latitud y longitud de los parametros obtenidos de la funcion
    final endpoint = '/directions/v5/mapbox/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}';

    // Usando HTTP con un modelo
    // var url =  Uri.https(_baseUrl, endpoint, {
    //   'alternatives': 'true',
    //   'geometries': 'polyline6',
    //   'overview': 'simplified',
    //   'steps': 'false',
    //   'access_token': apiMapBox,
    // }); 
    // esto es con http se tiene que crear el modelo para trabajar con la respuesta
    // final responce = await http.get(url);
    // return responce.body; 

    // usando interceptores de Dio, No me gusta es mas trabajooo
    // var responce =  await _dioTraffic.get('$_baseHTTPS$endpoint'); 

    // usando Dio que formatea la respuesta
    // esto es con Dio se tiene que crear el modelo para trabajar con la respuesta
     _dioTraffic.options.baseUrl = _baseHTTPS; // aqui seteamos la base del url en HTTPS
    // Agregando los parametros directamente en la peticion sin los interceptores, es mejor Menos trabajo
    var responce =  await _dioTraffic.get( endpoint,
      queryParameters: {
        'alternatives': 'true',
        'geometries': 'polyline6',
        'overview': 'simplified',
        'steps': 'false',
        'access_token': apiMapBox,
      }
    ); 

    final data = TrafficResponse.fromMap(responce.data); 

    return data; 

  } 
}