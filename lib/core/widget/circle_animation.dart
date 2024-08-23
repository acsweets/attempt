import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

//一个球从左边向右边移动边移动边变大
//分析有两个动画 一个是大小的控制一个是位置的控制
//颜色随着变化

class CircleAnimation extends StatefulWidget {
  const CircleAnimation({super.key});

  @override
  State<CircleAnimation> createState() => _CircleAnimationState();
}

class _CircleAnimationState extends State<CircleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _radiusController;
  late Animation<double> _radius;
  late Animation<double> _position;

  static final Animatable<double> _easeCurveTween =
  CurveTween(curve: Curves.bounceInOut);

  @override
  void initState() {
    _radiusController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    //圆心添加自己的动画曲线
    _radius = _radiusController
        .drive(Tween(begin: 10.0, end: 100.0).chain(_easeCurveTween));
    _radiusController.repeat(reverse: true);

    //定位可以添加自己的动画曲线
    _position = _radiusController.drive(
        Tween<double>(begin: 0.0, end: 100).chain(CurveTween(curve: Curves.ease))
    );

    super.initState();
  }

  //两种形式添加曲线效果
  // Curves.ease.transform(_radiusController.value),
  // static final Animatable<double> _easeCurveTween =   CurveTween(curve: Curves.bounceInOut);
  // _radiusController
  // .drive(Tween(begin: 10.0, end: 100.0).chain(_easeCurveTween));
  @override
  void dispose() {
    _radiusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _radius,
        builder: (c, w) {
          return CustomPaint(
              painter: CustomAnimation(
                  radius: _radius.value,
                  position:_position.value ,
                  color: Color.lerp(
                      Colors.red, Colors.cyanAccent, _radiusController.value)));
        });
  }
}

class CustomAnimation extends CustomPainter {
  final double radius;
  final Color? color;
  final double position;

  CustomAnimation(
      {this.radius = 50, this.color = Colors.blueAccent, this.position = 0,});

  @override
  void paint(Canvas canvas, Size size) {
    assert(position <= size.width - radius,"圆移动的位置必须小于约束的宽度");

    Paint paint = Paint()
      ..color = color!
      ..blendMode = BlendMode.darken;
    canvas.drawCircle(
        Offset(radius + position, size.height / 2), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomAnimation oldDelegate) {
    return oldDelegate.radius != radius || oldDelegate.color != color;
  }
}
