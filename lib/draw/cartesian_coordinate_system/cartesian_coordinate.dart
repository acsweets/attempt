import 'package:flutter/material.dart';

class CartesianPainter extends CustomPainter {
  final double unitLength; // 每个单位的长度
  final Color axisColor; // 坐标轴的颜色

  CartesianPainter({required this.unitLength, required this.axisColor});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;
    // canvas.save();
    // canvas.translate(size.width / 2, size.height / 2);
    // canvas.drawCircle(Offset(0, 0), 5, paint);
    // canvas.restore(); //要和save 配合使用
    // canvas.drawCircle(Offset(10, 10), 5, paint..color = Color(0xff826853));

    // canvas.drawLine(Offset(-size.width, size.height/2),
    //     Offset(size.width, size.height/2), paint);
    //
    // canvas.drawLine(Offset(size.width/2, -size.height),
    //     Offset(size.width/2, size.height), paint);
    // 绘制 x 轴
    drawX(canvas,size,paint);
    // canvas.drawLine(
    //   Offset(0, size.height / 2),
    //   Offset(size.width, size.height / 2),
    //   paint,
    // );

    // 绘制 y 轴
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      paint,
    );

    // 画刻度线
    drawScales(canvas, size);
  }

  void drawScales(Canvas canvas, Size size) {
    final Paint scalePaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0;

    // 绘制 x 轴的刻度
    for (double i = 0; i <= size.width; i += 10,) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i, size.height),
        scalePaint,
      );
    }

    // 绘制 y 轴的刻度
    for (double i = 0; i <= size.height; i += 10) {
      canvas.drawLine(
        Offset(0, i),
        Offset(size.width, i),
        scalePaint,
      );
    }
  }

  void drawText(String text, Canvas canvas, Offset offset) {
    TextPainter tp = TextPainter(
      text: TextSpan(
          text: text,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 12,
          )),
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, offset);
  }

  void drawX(Canvas canvas, Size size, Paint paint) {
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );
    for (double i = 0; i < size.width; i += 50) {
      drawText('${i - size.width / 2}', canvas, Offset(i, size.height / 2));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
