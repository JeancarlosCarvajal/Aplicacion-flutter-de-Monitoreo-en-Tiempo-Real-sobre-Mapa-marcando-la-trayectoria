import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import 'package:maps_app/src/markers/markers.dart';

Future<BitmapDescriptor> getStartCustomMarker(int minutes, String destination) async{

  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  const size = ui.Size(350, 150);

  // instancia de widget
  final startMarker = StartMarkerPainter(minutes: minutes, destination: destination);
  // dibujar en el canvas
  startMarker.paint(canvas, size);
  // obtener la imagen
  final picture = recorder.endRecording();

  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  // exportar a ong
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());

} 

Future<BitmapDescriptor> getEndCustomMarker(int kilometers, String destination) async{

  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  const size = ui.Size(350, 150);

  // instancia de widget
  final startMarker = EndMarkerPainter(kilometers: kilometers, destination: destination);
  // dibujar en el canvas
  startMarker.paint(canvas, size);
  // obtener la imagen
  final picture = recorder.endRecording();

  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  // exportar a ong
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());

} 