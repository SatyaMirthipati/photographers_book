import 'package:flutter/material.dart';

class BottomBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    var path = Path();
    var r = 40;
    var diff = 0;
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 0, 0, 0);
    path.lineTo(size.width * 0.5 - r - diff, 0);
    path.cubicTo(
      size.width * 0.5 - r + diff,
      0,
      size.width * 0.5 - r + 10,
      35,
      size.width * 0.5,
      35,
    );
    path.cubicTo(
      size.width * 0.5 + r - 10,
      35,
      size.width * 0.5 + r - diff,
      0,
      size.width * 0.5 + r + diff,
      0,
    );
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
