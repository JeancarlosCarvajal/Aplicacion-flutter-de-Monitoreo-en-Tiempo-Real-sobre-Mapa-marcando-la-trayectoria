


import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TrafficInterseptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final apiMapBox = dotenv.env['MAPBOX_TOKEN']; // MAPBOX_TOKEN_STYLES   MAPBOX_TOKEN  
    options.queryParameters.addAll({ 
        'alternatives': 'true',
        'geometries': 'polyline6',
        'overview': 'simplified',
        'steps': 'false',
        'access_token': apiMapBox,
    }); 
    super.onRequest(options, handler);
  }

}