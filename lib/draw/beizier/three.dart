import 'dart:math' as math;

import 'package:flutter/material.dart';

//绘制笛卡尔坐标系
class CartesianPainter extends CustomPainter {
  //刻度 宽高  坐标系颜色 刻度颜色  绘制箭头 坐标轴的粗细

  @override
  void paint(Canvas canvas, Size size) {
    //基于宽高100来绘制， 左下为正。
    drawCoordinateAxis(canvas, size);
    drawScale(canvas, size);
    drawScaleValue(canvas, size);
  }

  ///旋转角度 [rotationAngle]
  //绘制箭头
  void drawArrow(Canvas canvas, Size size, {double? rotationAngle = 0}) {
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    Path arrowPath = Path();
    Matrix4 matrix4 = Matrix4.identity();
    // matrix4.scale(x);
    arrowPath.moveTo(0, -size.height / 2);
    arrowPath.transform(matrix4.storage);
    arrowPath.lineTo(size.width / 2, 0);
    arrowPath.lineTo(0, size.height / 2);
    Paint arrowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.red;
    canvas.rotate(rotationAngle! * 3.1415926 / 180);
    canvas.drawPath(arrowPath, arrowPaint);
    canvas.restore();
  }

  //轴线
  void drawAxis(Canvas canvas, Size size) {
    Paint axisPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.blue;
    double arrowSize = size.width / 20;
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(size.width, size.height / 2), axisPaint);
    canvas.save();
    canvas.translate(size.width - arrowSize, size.height / 2 - arrowSize / 2);
    drawArrow(canvas, Size(arrowSize, arrowSize));
    canvas.restore();
  }

  //刻度包含文字
  void drawScale(Canvas canvas, Size size) {
    //
    Paint scalePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.grey;
    //绘制垂直线 ,但是靠近轴线的左右不绘制
    double spacing = 40;
    for (int i = 0; i <= size.width / spacing; i++) {
      Offset p1 = Offset(spacing * i, 0);
      Offset p2 = Offset(spacing * i, size.height);
      canvas.drawLine(p1, p2, scalePaint);
    }
    //绘制横向线 ,但是靠近轴线的左右不绘制
    for (int i = 0; i <= size.height / spacing; i++) {
      Offset p1 = Offset(0, spacing * i);
      Offset p2 = Offset(size.width, spacing * i);
      canvas.drawLine(p1, p2, scalePaint);
    }
  }

//坐标系
  void drawCoordinateAxis(Canvas canvas, Size size) {
    drawAxis(canvas, size);
    canvas.save();
    canvas.translate(0, size.height);
    canvas.rotate(270 * 3.1415926 / 180);
    drawAxis(canvas, size);
    canvas.restore();
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

  void drawScaleValue(Canvas canvas, Size size) {
    double spacing = 40;
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    for (int i = 0; i <= size.width / 2 / spacing; i++) {
      drawText(i.toString(), canvas, Offset(spacing * i, 0));
      drawText((-i).toString(), canvas, Offset(-spacing * i, 0));
    }
    for (int i = 0; i <= size.height / 2 / spacing; i++) {
      drawText(i.toString(), canvas, Offset(0, spacing * i));
      drawText((-i).toString(), canvas, Offset(0, -spacing * i));
    }
    canvas.restore();
    //左负右正  0-size.width/2
    //上负下正  0-size.height/2
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// 拿gpt优化过的 => 减少了保存恢复的操作
class CartesianPainterG extends CustomPainter {
  // 绘制方法
  @override
  void paint(Canvas canvas, Size size) {
    drawCoordinateAxis(canvas, size);
  }

  /// 绘制箭头，参数为旋转角度 [rotationAngle]
  void drawArrow(Canvas canvas, Size size, {double rotationAngle = 0}) {
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(rotationAngle * 3.1415926 / 180);

    Path arrowPath = Path()
      ..moveTo(0, -size.height / 2)
      ..lineTo(size.width / 2, 0)
      ..lineTo(0, size.height / 2);

    Paint arrowPaint = Paint()..style = PaintingStyle.stroke;
    canvas.drawPath(arrowPath, arrowPaint);
    canvas.restore();
  }

  // 绘制轴线
  void drawAxis(Canvas canvas, Size size, {bool isHorizontal = true}) {
    Paint axisPaint = Paint()..style = PaintingStyle.stroke;
    double arrowSize = 20;

    // 绘制轴线
    Offset start = isHorizontal
        ? Offset(0, size.height / 2)
        : Offset(size.width / 2, size.height);
    Offset end = isHorizontal
        ? Offset(size.width, size.height / 2)
        : Offset(size.width / 2, 0);

    canvas.drawLine(start, end, axisPaint);

    // 绘制轴线上的箭头
    canvas.save();
    if (isHorizontal) {
      canvas.translate(size.width - arrowSize, size.height / 2 - arrowSize / 2);
    } else {
      canvas.translate(size.width / 2 - arrowSize / 2, arrowSize);
      canvas.rotate(270 * 3.1415926 / 180); // 旋转竖直箭头
    }
    drawArrow(canvas, Size(arrowSize, arrowSize));
    canvas.restore();
  }

  // 绘制笛卡尔坐标系
  void drawCoordinateAxis(Canvas canvas, Size size) {
    drawAxis(canvas, size, isHorizontal: true); // 水平轴
    drawAxis(canvas, size, isHorizontal: false); // 垂直轴
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

//Claude 优化的 => 变味了
class CartesianPainterM extends CustomPainter {
  final Color axisColor;
  final Color scaleColor;
  final double arrowSize;
  final double scaleLength;

  CartesianPainterM({
    this.axisColor = Colors.black,
    this.scaleColor = Colors.grey,
    this.arrowSize = 10,
    this.scaleLength = 5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final axisPaint = Paint()
      ..color = axisColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final scalePaint = Paint()
      ..color = scaleColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    _drawAxis(canvas, size, axisPaint, Axis.horizontal);
    _drawAxis(canvas, size, axisPaint, Axis.vertical);
    _drawScales(canvas, size, scalePaint);
  }

  void _drawAxis(Canvas canvas, Size size, Paint paint, Axis axis) {
    final isHorizontal = axis == Axis.horizontal;
    final start = Offset(
      isHorizontal ? 0 : size.width / 2,
      isHorizontal ? size.height / 2 : size.height,
    );
    final end = Offset(
      isHorizontal ? size.width : size.width / 2,
      isHorizontal ? size.height / 2 : 0,
    );

    canvas.drawLine(start, end, paint);
    _drawArrow(canvas, end, isHorizontal ? 0 : -math.pi / 2, paint);
  }

  void _drawArrow(Canvas canvas, Offset tip, double angle, Paint paint) {
    final path = Path();
    path.moveTo(tip.dx, tip.dy);
    path.lineTo(tip.dx - arrowSize, tip.dy + arrowSize / 2);
    path.lineTo(tip.dx - arrowSize, tip.dy - arrowSize / 2);
    path.close();

    canvas.save();
    canvas.translate(tip.dx, tip.dy);
    canvas.rotate(angle);
    canvas.translate(-tip.dx, -tip.dy);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  void _drawScales(Canvas canvas, Size size, Paint paint) {
    final xCenter = size.width / 2;
    final yCenter = size.height / 2;

    for (var i = 0; i < size.width; i += 50) {
      canvas.drawLine(
        Offset(i.toDouble(), yCenter - scaleLength / 2),
        Offset(i.toDouble(), yCenter + scaleLength / 2),
        paint,
      );
    }

    for (var i = 0; i < size.height; i += 50) {
      canvas.drawLine(
        Offset(xCenter - scaleLength / 2, i.toDouble()),
        Offset(xCenter + scaleLength / 2, i.toDouble()),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
