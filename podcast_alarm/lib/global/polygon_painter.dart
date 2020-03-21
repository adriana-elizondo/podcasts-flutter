import 'package:flutter/material.dart';

class PolygonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = new Rect.fromLTRB(size.height / 2, 0.0, size.width, size.height / 2);

    // a fancy rainbow gradient
    final Gradient gradient = new LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Color.fromRGBO(48, 35, 174, 1.0),
        Color.fromRGBO(86, 53, 184, 0.83),
        Color.fromRGBO(106, 64, 190, 0.72),
        Color.fromRGBO(123, 72, 194, 0.66),
        Color.fromRGBO(200, 109, 215, 0.3),
      ],
      stops: [
        0.0,
        0.2,
        0.4,
        0.75,
        1.0,
      ],
    );

    final Paint paint = new Paint()..shader = gradient.createShader(rect);
    Path path = Path();
    path.moveTo(size.width / 2, size.height / 2.5);
    path.lineTo(0, size.height / 5);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height / 4);
    path.moveTo(size.width / 2, size.height / 3);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
