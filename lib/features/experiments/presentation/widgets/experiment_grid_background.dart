import 'package:flutter/material.dart';

class ExperimentGridBackground extends StatelessWidget {
  final Widget child;
  final double spacing;

  const ExperimentGridBackground({
    super.key,
    required this.child,
    this.spacing = 32,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF17152B), Color(0xFF101625)],
        ),
      ),
      child: CustomPaint(
        painter: _GridPainter(spacing: spacing),
        child: child,
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  final double spacing;

  const _GridPainter({required this.spacing});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.035)
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.spacing != spacing;
  }
}
