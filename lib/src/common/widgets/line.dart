import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  final double length;
  final double dashLength;
  final double dashGap;
  final Color color;

  const DottedLine({
    required this.length,
    super.key,
    this.dashLength = 4,
    this.dashGap = 2,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) => CustomPaint(
        size: Size(length, 1),
        painter: DottedLinePainter(dashLength, dashGap, color),
      );
}

class DottedLinePainter extends CustomPainter {
  final double dashLength;
  final double dashGap;
  final Color color;

  DottedLinePainter(this.dashLength, this.dashGap, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashLength, 0),
        paint,
      );
      startX += dashLength + dashGap;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
