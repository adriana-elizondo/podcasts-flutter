import 'dart:math';
import 'package:flutter/material.dart';

class CirclePercentIndicator extends StatelessWidget {
  final Stream<int> progressStream;

  CirclePercentIndicator({@required this.progressStream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: progressStream,
      builder: (ctx, snapshot) {
        int progress = snapshot.data ?? 0;
        return CustomPaint(
          foregroundPainter: CircleProgress(progress.toDouble()),
          child: Center(
            child: Text(progress.toString()),
          ),
        );
      },
    );
  }
}

class CircleProgress extends CustomPainter {
  double currentProgress;

  CircleProgress(this.currentProgress);

  @override
  void paint(Canvas canvas, Size size) {
    //this is base circle
    Paint outerCircle = Paint()
      ..strokeWidth = 2
      ..color = Color(0xFF4C5F6B)
      ..style = PaintingStyle.stroke;

    Paint completeArc = Paint()
      ..strokeWidth = 2
      ..color = Color(0xFF16D0E8)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - 10;

    canvas.drawCircle(
        center, radius, outerCircle); // this draws main outer circle

    double angle = 2 * pi * (currentProgress / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, completeArc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
