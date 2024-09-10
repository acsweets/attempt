//绘制卦盘
import 'dart:math';

import 'package:flutter/material.dart';

import '../config_animation.dart';

enum Direction { up, down }

class BaGuaPainter extends CustomPainter {
  final List<Gua> guaList;
  final Direction? direction;

  BaGuaPainter({required this.guaList, this.direction = Direction.up});

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = min(size.width / 2, size.height / 2);
    final double angle = 2 * pi / guaList.length;

    for (int i = 0; i < guaList.length; i++) {
      // 将 labelAngle 以 -pi/2 为起点，使第一个卦象在 Y 轴正上方
      final double labelAngle = i * angle - pi / 2;
      final double labelRadius = radius * 0.85;
      final Offset labelOffset = Offset(
        size.width / 2 + labelRadius * cos(labelAngle),
        size.height / 2 + labelRadius * sin(labelAngle),
      );
      //成列
      final textPainter = TextPainter(
        text: TextSpan(
          text: "${guaList[i].name}\n${guaList[i].symbol}",
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w900, fontSize: 24),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      canvas.save();
      canvas.translate(labelOffset.dx, labelOffset.dy);

      // 根据方向调整字体的旋转角度
      if (direction == Direction.up) {
        canvas.rotate(labelAngle + pi / 2);
      } else {
        canvas.rotate(labelAngle - pi / 2);
      }

      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
