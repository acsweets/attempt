import 'dart:math';
import 'package:flutter/material.dart';
import '../config_animation.dart';
import 'draw_gua.dart';

typedef GuaEnd = void Function(Gua gua);

class BaGuaWheel extends StatefulWidget {
  final double size;
  final GuaEnd? onComplete;

  const BaGuaWheel({
    super.key,
    required this.size,
    this.onComplete,
  });

  @override
  createState() => BaGuaWheelState();
}

class BaGuaWheelState extends State<BaGuaWheel>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  double _panRotation = 0.0;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  void _initializeAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _updateRotationAnimation();
  }

  void _updateRotationAnimation() {
    _rotationAnimation = Tween<double>(
      begin: 1,
      end: 150 + _random.nextInt(50).toDouble(),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.decelerate,
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
      onPanStart: _handlePanStart,
      onPanUpdate: _handlePanUpdate,
      onPanEnd: _handlePanEnd,
      child: AnimatedBuilder(
        animation: _rotationAnimation,
        builder: _buildRotatingWheel,
      ),
    );
  }

  void _handlePanStart(DragStartDetails details) {
    _animationController.stop();
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    setState(() {
      final Offset center = Offset(widget.size / 2, widget.size / 2);
      final Offset touchPosition = details.localPosition;
      final double angleAtTouchPosition =
          atan2(touchPosition.dy - center.dy, touchPosition.dx - center.dx);
      final double previousAngle = atan2(
        touchPosition.dy - center.dy - details.delta.dy,
        touchPosition.dx - center.dx - details.delta.dx,
      );
      _panRotation += angleAtTouchPosition - previousAngle;
    });
  }

  void _handlePanEnd(DragEndDetails details) {
    startAnimation();
  }

  void startAnimation() {
    if (!_animationController.isAnimating) {
      _updateRotationAnimation();
      _animationController.forward(from: 0.0).then((_) => _finalizeRotation());
    }
  }

  void _finalizeRotation() {
    setState(() {
      _panRotation = _snapToNearestPiOver4(_panRotation);
    });
    widget.onComplete
        ?.call(getGuaByAngle(_rotationAnimation.value * pi / 4 + _panRotation));
  }

  Widget _buildRotatingWheel(BuildContext context, Widget? child) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Transform.rotate(
        angle: _rotationAnimation.value * pi / 4 + _panRotation,
        child: CustomPaint(
          painter: BaGuaPainter(guaList: Gua.values),
        ),
      ),
    );
  }

  double _snapToNearestPiOver4(double angle) {
    return (angle / (pi / 4)).round() * (pi / 4);
  }

  Gua getGuaByAngle(double angle) {
    double normalizedAngle = angle % (2 * pi);
    double nearestAngle = (normalizedAngle / (pi / 4)).round() * (pi / 4);
    return _guaMap[nearestAngle] ?? Gua.qian;
  }

  final Map<double, Gua> _guaMap = {
    8 * pi / 4: Gua.qian,
    7 * pi / 4: Gua.kun,
    6 * pi / 4: Gua.zhen,
    5 * pi / 4: Gua.gen,
    4 * pi / 4: Gua.li,
    3 * pi / 4: Gua.kan,
    2 * pi / 4: Gua.dui,
    1 * pi / 4: Gua.xun,
  };
}
