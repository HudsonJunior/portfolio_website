import 'package:flutter/material.dart';

class SpiningCirclerPainter extends CustomPainter {
  final double radius;

  SpiningCirclerPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;

    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return radius != (oldDelegate as SpiningCirclerPainter).radius;
  }
}
