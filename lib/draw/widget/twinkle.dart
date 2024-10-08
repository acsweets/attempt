import 'package:flutter/material.dart';

class TwinkleAnimated extends StatefulWidget {
  final Widget? cursor;

  const TwinkleAnimated({
    super.key,
    required this.cursor,
  });

  @override
  State<TwinkleAnimated> createState() => _TwinkleAnimatedState();
}

class _TwinkleAnimatedState extends State<TwinkleAnimated>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _startCursorAnimation();
  }

  void _startCursorAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _animationController.repeat(reverse: true);
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: widget.cursor,
    );
  }
}
