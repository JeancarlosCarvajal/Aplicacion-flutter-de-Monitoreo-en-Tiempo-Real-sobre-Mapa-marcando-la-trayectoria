import 'package:flutter/material.dart';



class StartMarkerPainter extends CustomPainter {
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

    // creamos la figura
    canvas.drawCircle(Offset(circleBlackRadius, size.height - circleBlackRadius), circleBlackRadius, blackPaint);
    // circulo negro
    canvas.drawCircle(Offset(circleBlackRadius, size.height - circleBlackRadius), circleWhiteRadius, whitePaint);

    // crear unna caja blanca
    final path = new Path();
    path.moveTo(40, 20); 
    path.lineTo(size.width - 10, 20); // lienea horizontal arriba
    path.lineTo(size.width - 10, 100); // linea vertical derecha
    path.lineTo(40, 100); // linea horizontal abajo
    // crear sombra de la caja creada arriba
    canvas.drawShadow(path, Colors.black, 10, false);
    // pintamos la linea planteada arriba
    canvas.drawPath(path, whitePaint);

    // crear una caja negra de otra manera mas facil
    const blackBox = Rect.fromLTWH(40, 20, 70, 80);
    // diujamos en el canvas la caja negra
    canvas.drawRect(blackBox, blackPaint);

    // texto
    // minutos
    final textSpan = TextSpan(
      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
      text: '55'
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
    minutesPainter.paint(canvas, const Offset(40, 35));

    // hacer las palabras que acompanan al valor de los minutos
    final minutsText = TextSpan(
      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
      text: 'Min'
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
    minutesMinPainter.paint(canvas, const Offset(40, 68));

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;

}