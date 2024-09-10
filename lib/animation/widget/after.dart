import 'dart:math';
import 'package:flutter/material.dart';

import '../config_animation.dart';
import 'draw_gua.dart';

typedef GuaEnd = void Function(Gua gua);

class BaGuaWheelController extends StatefulWidget {
  final double size;
  final GuaEnd? onComplete;

  const BaGuaWheelController({
    super.key,
    required this.size,
    this.onComplete,
  });

  @override
  createState() => _BaGuaWheelControllerState();
}

class _BaGuaWheelControllerState extends State<BaGuaWheelController>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _customRangeAnimation;
  double panRotation = 0.0;

  bool isDragging = false;
  Random random = Random();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    // 生成 150 到 200 之间的随机数
    _customRangeAnimation =
        Tween<double>(begin: 1, end: (150 + random.nextInt(50)).toDouble())
            .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.decelerate, // 使用减速曲线
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        _animationController.stop();
        isDragging = true;
      },
      //拖动更新角度
      onPanUpdate: (details) {
        setState(() {
          final Offset center = Offset(widget.size / 2, widget.size / 2);
          final Offset touchPosition = details.localPosition;

          final double angleAtTouchPosition =
              atan2(touchPosition.dy - center.dy, touchPosition.dx - center.dx);

          // 计算前一次触摸位置的角度
          final double previousAngle = atan2(
              touchPosition.dy - center.dy - details.delta.dy,
              touchPosition.dx - center.dx - details.delta.dx);

          // 计算角度的差值，并更新当前旋转角度
          final double deltaAngle = angleAtTouchPosition - previousAngle;
          panRotation += deltaAngle;
        });
      },

      ///拖动结束给一个动画
      onPanEnd: (details) {
        isDragging = false;
        _customRangeAnimation =
            Tween<double>(begin: 1, end: (150 + random.nextInt(50)).toDouble())
                .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.decelerate, // 使用减速曲线
          ),
        );
        _animationController.forward(from: 0.0).then((_) {
          setState(() {
            panRotation = _snapToNearestPiOver4(panRotation);
          });
          if (widget.onComplete != null) {
            widget.onComplete!(getGuaByAngle(
                _customRangeAnimation.value * pi / 4 + panRotation));
          }
        });
      },
      onTap: () {},
      child: AnimatedBuilder(
        animation: _customRangeAnimation,
        builder: (BuildContext context, Widget? child) {
          return SizedBox(
            width: 200,
            height: 200,
            child: Transform.rotate(
              angle: _customRangeAnimation.value * pi / 4 + panRotation,
              child: CustomPaint(
                painter: BaGuaPainter(guaList: Gua.values),
              ),
            ),
          );
        },
      ),
    );
  }

  // 计算并修正角度
  double _snapToNearestPiOver4(double angle) {
    // 计算 π/4 的倍数的整数
    int nearestMultiple = (angle / (pi / 4)).round();

    // 返回最近的 π/4 倍数
    return nearestMultiple * (pi / 4);
  }

  // 根据给定的角度，返回最接近的 Gua 枚举
  Gua getGuaByAngle(double angle) {
    // 将角度归一化到 0 到 2π 之间
    double normalizedAngle = angle % (2 * pi);

    // 找到最接近的 π/4 倍数
    double nearestAngle = (normalizedAngle / (pi / 4)).round() * (pi / 4);

    // 返回对应的 Gua 枚举
    return guaMap[nearestAngle] ?? Gua.qian; // 默认返回 Gua.qian（或你想要的默认值）
  }

  Map<double, Gua> guaMap = {
    8 * pi / 4: Gua.qian,
    7 * pi / 4: Gua.kun,
    6 * pi / 4: Gua.zhen,
    5 * pi / 4: Gua.gen,
    4 * pi / 4: Gua.li,
    3 * pi / 4: Gua.kan,
    2 * pi / 4: Gua.dui,
    1 * pi / 4: Gua.xun,
  };
//判断角度是否属于 pi/4 的倍数【1/4 2/4 3/4  pi  5/4 6/4 7/4 2pi】  不属于就将角度置为最近的那个      (2pi/8)是一整圈放8个
}


