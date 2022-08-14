import 'package:flutter/material.dart';



class EndMarkerPainter extends CustomPainter {
  // minutos
  final int kilometers;
  // destino
  final String destination;

  EndMarkerPainter({
    required this.kilometers, 
    required this.destination
  });

  @override
  void paint(Canvas canvas, Size size) {
    // implement paint hacer el dibujo necesario
    // OPJOJOJ el orden en que pintas el canvas se va mostrar uno solapa el siguiente
    // crear un lapiz pa dibujar 
    final blackPaint = Paint()..color = Colors.black;
    final whitePaint = Paint()..color = Colors.white;

    // radio del ciruclo
    const double circleBlackRadius = 20;
    const double circleWhiteRadius = 7;

    // creamos circulo blanco
    canvas.drawCircle(Offset(size.width * 0.5, size.height - circleBlackRadius), circleBlackRadius, blackPaint);
    // circulo negro
    canvas.drawCircle(Offset(size.width * 0.5, size.height - circleBlackRadius), circleWhiteRadius, whitePaint);

    // crear unna caja blanca
    final path = new Path();
    path.moveTo(10, 20); 
    path.lineTo(size.width - 10, 20); // lienea horizontal arriba
    path.lineTo(size.width - 10, 100); // linea vertical derecha
    path.lineTo(10, 100); // linea horizontal abajo
    // crear sombra de la caja creada arriba
    canvas.drawShadow(path, Colors.black, 10, false);
    // pintamos la linea planteada arriba
    canvas.drawPath(path, whitePaint);

    // crear una caja negra de otra manera mas facil
    const blackBox = Rect.fromLTWH(10, 20, 70, 80);
    // diujamos en el canvas la caja negra
    canvas.drawRect(blackBox, blackPaint);

    // texto
    // minutos
    final textSpan = TextSpan(
      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
      text: '$kilometers'
    );
    // pintar el texto 
    final minutesPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
      minWidth: 70,
      maxWidth: 70
    );
    // dibujar el texto en el canvas
    minutesPainter.paint(canvas, const Offset(10, 35));

    // hacer las palabras que acompanan al valor de los minutos
    const minutsText = TextSpan(
      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
      text: 'Km'
    );
    // pintar el texto 
    final minutesMinPainter = TextPainter(
      text: minutsText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
      minWidth: 70,
      maxWidth: 70
    );
    // dibujar el texto en el canvas
    minutesMinPainter.paint(canvas, const Offset(10, 68));

    // crear la descipcion
    // const tempDestino = 'Mi casa, Playa Guaica y Marina del Rey, hola mundo'; 
    // const tempDestino = 'Mi casa'; 
    final locationText = TextSpan(
      style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
      text: destination
    );
    // pintar el texto descripcion
    final locationPainter = TextPainter(
      maxLines: 2,
      ellipsis: '...',
      text: locationText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    )..layout(
      minWidth: size.width-95,
      maxWidth: size.width-95
    );
    // creamos la ubicacion de las letras de manera condicional para ubicarla mas al centro si tiene dos lineas
    final double offsetY = ( destination.length > 25 ) ? 35 : 48;
    // pintar el location painter
    locationPainter.paint(canvas, Offset(90, offsetY));


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;

}