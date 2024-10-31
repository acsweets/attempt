// import 'package:flutter/material.dart';
//
//
//
// class CurveWithAnimatedShadow extends StatefulWidget {
//   @override
//   _CurveWithAnimatedShadowState createState() => _CurveWithAnimatedShadowState();
// }
//
// class _CurveWithAnimatedShadowState extends State<CurveWithAnimatedShadow>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: Duration(seconds: 3),
//       vsync: this,
//     )..repeat(); // 持续重复动画
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: AnimatedBuilder(
//         animation: _controller,
//         builder: (context, child) {
//           return CustomPaint(
//             size: Size(300, 300),
//             painter: CurveShadowPainter(_controller.value),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class CurveShadowPainter extends CustomPainter {
//   final double animationValue;
//
//   CurveShadowPainter(this.animationValue);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.blue
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 4.0;
//
//     final shadowPaint = Paint()
//       ..color = Colors.blue.withOpacity(0.3)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 6.0
//       ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4);
//
//     // 定义曲线路径
//     final path = Path()
//       ..moveTo(0, size.height)
//       ..quadraticBezierTo(
//           size.width / 2, size.height / 2 - 100, size.width, size.height);
//
//     // 绘制原曲线
//     canvas.drawPath(path, paint);
//
//     // 创建动态阴影路径
//     final shadowPath = Path();
//     for (double t = 0.0; t <= animationValue; t += 0.01) {
//       final x = t * size.width;
//       final y = size.height -
//           4 * t * (size.height / 2 - 100) * (1 - t); // 贝塞尔曲线点公式
//       if (t == 0.0) {
//         shadowPath.moveTo(x, y);
//       } else {
//         shadowPath.lineTo(x, y);
//       }
//     }
//
//     // 沿着原有曲线绘制动态阴影
//     canvas.drawPath(shadowPath, shadowPaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CurveShadowPainter oldDelegate) {
//     return oldDelegate.animationValue != animationValue;
//   }
// }



import 'package:flutter/material.dart';



class CurveWithAnimatedShadow extends StatefulWidget {
  @override
  _CurveWithAnimatedShadowState createState() => _CurveWithAnimatedShadowState();
}

class _CurveWithAnimatedShadowState extends State<CurveWithAnimatedShadow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..forward();
      // ..repeat(); // 持续重复动画
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: const Size(300, 300),
            painter: CurveShadowPainter(_controller.value),
          );
        },
      ),
    );
  }
}

class CurveShadowPainter extends CustomPainter {
  final double animationValue;

  CurveShadowPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final shadowPaint = Paint()
      ..color = Colors.purpleAccent.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    // 定义曲线路径
    final path = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(
          size.width / 2, size.height / 2 - 100, size.width, size.height);

    // 绘制原曲线
    canvas.drawPath(path, paint);

    // 使用 PathMetric 获取曲线的部分路径，实现阴影的延伸效果
    final pathMetrics = path.computeMetrics();
    final shadowPath = Path();

    for (final metric in pathMetrics) {
      final length = metric.length * animationValue; // 根据动画值确定阴影路径长度
      shadowPath.addPath(metric.extractPath(0, length), Offset.zero);
    }
    // 绘制动态阴影
    canvas.drawPath(shadowPath, shadowPaint);
  }

  @override
  bool shouldRepaint(covariant CurveShadowPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
