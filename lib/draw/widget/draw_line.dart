import 'package:flutter/material.dart';

class DrawLine extends CustomPainter {
  //横线竖线长度 长度颜色
  final Color? color;

  final double? angle;

  DrawLine({
    this.color,
    this.angle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    //..style = PaintingStyle.stroke 空心 or fill
    Paint paint = Paint()..color = color ?? Colors.black;
    if (angle != null) canvas.rotate(angle!);
    Path linePath = Path();
    linePath.lineTo(size.width, 0);
    linePath.lineTo(size.width, size.height);
    linePath.lineTo(0, size.height);
    linePath.close();
    canvas.drawPath(linePath, paint);
    // canvas.drawLine(const Offset(0, 0), Offset(size.width, 0), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

