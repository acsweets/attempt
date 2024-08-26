import 'package:attempt/attempt.dart';
import 'package:flutter/material.dart';

//按钮的宽度 大小 边距怎么设置
class AtButton extends StatefulWidget {
  final double radius;
  final Color? color;
  final bool showRipple;
  final VoidCallback? onPressed;
  final Icon? icon;
  final String label;

  const AtButton({
    super.key,
    this.radius = 0,
    this.color,
    this.showRipple = true,
    this.onPressed,
    this.icon,
    required this.label,
  });

  @override
  State<AtButton> createState() => _AtButtonState();
}

class _AtButtonState extends State<AtButton> {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      enabled: widget.onPressed != null,
      child: InkWell(
        onTap: widget.onPressed,
        overlayColor: ColorUtil.stateColor(),

        ///InkSparkle.splashFactory
        ///InkRipple.splashFactory
        ///InkSplash.splashFactory
        ///不显示水波纹
        ///splashFactory: NoSplash.splashFactory,
        splashFactory: InkSplash.splashFactory,

        child: Container(
          child: Row(
            children: [
              Text(widget.label),
              if (widget.icon != null) widget.icon!,
            ],
          ),
        ),
      ),
    );
  }
}
//默认水波纹颜色是按钮颜色变淡
//
//设置水波纹颜色
//是否显示水波纹
//可点击不可点击时 不同的样式
