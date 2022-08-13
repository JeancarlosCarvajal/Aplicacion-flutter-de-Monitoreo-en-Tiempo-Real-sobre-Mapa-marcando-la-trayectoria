


import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show BitmapDescriptor;

// retorna el Marker personalizado en el formato indicado por google map
Future<BitmapDescriptor> getAssetImageMarker() async { 
  return BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(
      devicePixelRatio: 2.5, // si la imagen es de 500 va qterminas siendo de 250

    ), 
    'assets/custom-pin.png'
  ); 
}

// Icono personlizado con url
// https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png
Future<BitmapDescriptor> getNetworkImageMarker() async{
  final resp = await Dio()
    .get(
      'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png',
      options: Options( responseType:  ResponseType.bytes ), // me envia los bites de la foto  
    );
  // cambiar el tamano a la imagen.. la list es resp.data
  final imageCodec = await  ui.instantiateImageCodec( resp.data, targetHeight: 150, targetWidth: 150 );
  // creamos un canva para dibujar esta imagen de arriba
  final frame = await imageCodec.getNextFrame();
  // metemos la imagen en el frame
  final data = await frame.image.toByteData( format: ui.ImageByteFormat.png );

  // por seguridad si no se puedo obtneer la imagen por 404 de la url
  if( data == null ) return await getAssetImageMarker();

  // devolvemos la resp.data en formato Bytes y borralooo
  // return BitmapDescriptor.fromBytes(resp.data); // respuesta de la imagen original son redimencionar

  // respuesta de la imagen url configurada al tamano deseado
  return BitmapDescriptor.fromBytes( data.buffer.asUint8List() );
}