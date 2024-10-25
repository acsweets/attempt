import 'dart:math';
import 'package:flutter/material.dart';

class Rotating3DSphere extends StatefulWidget {
  const Rotating3DSphere({super.key});

  @override
   createState() => _Rotating3DSphereState();
}

class _Rotating3DSphereState extends State<Rotating3DSphere> {
  double rotationX = 0;
  double rotationY = 0;
  Offset lastPosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              // 根据拖动更新旋转角度
              rotationY -= details.delta.dx * 0.01;
              rotationX += details.delta.dy * 0.01;
            });
          },
          child: CustomPaint(
            size: const Size(300, 300),
            painter: SpherePainter(rotationX, rotationY),
          ),
        ),

        GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              // 根据拖动更新旋转角度
              rotationY -= details.delta.dx * 0.01;
              rotationX += details.delta.dy * 0.01;
            });
          },
          child: CustomPaint(
            size: const Size(300, 300),
            painter: SphereBallPainter(rotationX, rotationY),
          ),
        ),
      ],
    );
  }
}

class SpherePainter extends CustomPainter {
  final double rotationX;
  final double rotationY;
  final double radius = 100;
  final int numPoints = 500;

  SpherePainter(this.rotationX, this.rotationY);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    double centerX = size.width / 2;
    double centerY = size.height / 2;

    for (var i = 0; i < numPoints; i++) {
      // 球面上的经纬度坐标
      double theta = acos(2 * i / numPoints - 1); // 纬度
      double phi = sqrt(numPoints * pi) * i; // 经度

      // 球的3D坐标
      double x = radius * sin(theta) * cos(phi);
      double y = radius * sin(theta) * sin(phi);
      double z = radius * cos(theta);

      // 旋转矩阵
      double tempX = x * cos(rotationY) - z * sin(rotationY);
      double tempZ = x * sin(rotationY) + z * cos(rotationY);
      double tempY = y * cos(rotationX) - tempZ * sin(rotationX);
      double newZ = y * sin(rotationX) + tempZ * cos(rotationX);

      // 3D到2D的投影 (模拟透视效果)
      // 加入保护，防止 newZ 过小
      double minZ = 0.1;  // 设置一个最小值，防止除以接近 0 的值
      double scaleFactor = 100 / (100 + newZ.clamp(minZ, double.infinity));  // 简单的透视公式
      double screenX = centerX + tempX * scaleFactor;
      double screenY = centerY + tempY * scaleFactor;

      // 检查是否为 NaN
      if (screenX.isNaN || screenY.isNaN) {
        continue;  // 忽略无效值，避免绘制时出错
      }

      // 绘制球面上的点
      canvas.drawCircle(Offset(screenX, screenY), 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;  // 每次旋转时重绘
  }
}

class SphereBallPainter extends CustomPainter {
  final double rotationX;
  final double rotationY;
  final double radius = 100;
  final int numPoints = 500;

  SphereBallPainter(this.rotationX, this.rotationY);

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;

    for (var i = 0; i < numPoints; i++) {
      // 球面上的经纬度坐标
      double theta = acos(2 * i / numPoints - 1); // 纬度
      double phi = sqrt(numPoints * pi) * i; // 经度

      // 球的3D坐标
      double x = radius * sin(theta) * cos(phi);
      double y = radius * sin(theta) * sin(phi);
      double z = radius * cos(theta);

      // 旋转矩阵
      double tempX = x * cos(rotationY) - z * sin(rotationY);
      double tempZ = x * sin(rotationY) + z * cos(rotationY);
      double tempY = y * cos(rotationX) - tempZ * sin(rotationX);
      double newZ = y * sin(rotationX) + tempZ * cos(rotationX);

      // 3D到2D的投影 (模拟透视效果)
      double minZ = 0.1;
      double scaleFactor = 100 / (100 + newZ.clamp(minZ, double.infinity));  // 透视公式
      double screenX = centerX + tempX * scaleFactor;
      double screenY = centerY + tempY * scaleFactor;

      // 检查是否为 NaN
      if (screenX.isNaN || screenY.isNaN) {
        continue;
      }

      // 根据 Z 值设置颜色，Z 越大颜色越亮，Z 越小颜色越暗
      double colorFactor = (newZ + radius) / (2 * radius);  // 将 Z 转换为 0~1 范围
      Paint paint = Paint()
        ..color = Color.lerp(Colors.red, Colors.blue, colorFactor)!  // 颜色插值
        ..style = PaintingStyle.fill;

      // 绘制球面上的点
      canvas.drawCircle(Offset(screenX, screenY), 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}