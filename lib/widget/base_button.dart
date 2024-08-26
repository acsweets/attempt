import 'package:flutter/material.dart';

import 'customize_ripples.dart';

class BaseButton extends StatefulWidget {
  const BaseButton({super.key});

  @override
  State<BaseButton> createState() => _BaseButtonState();
}

class _BaseButtonState extends State<BaseButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: CustomizeRipples(),
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.hovered)) {
            return Colors.blue.withOpacity(0.2);
          }
          if (states.contains(WidgetState.focused) ||
              states.contains(WidgetState.pressed)) {
            return Colors.blue.withOpacity(0.3);
          }
          return null;
        },
      ),
    );

    // return ElevatedButton(
    //   onPressed: () {},
    //
    //
    //   style: ButtonStyle(
    //
    //     // 动态调整按钮的最小尺寸
    //     // minimumSize: WidgetStateProperty.resolveWith<Size>(
    //     //   (Set<WidgetState> states) {
    //     //     if (states.contains(WidgetState.pressed)) {
    //     //       return Size(150, 50); // 按下时尺寸较小
    //     //     } else if (states.contains(WidgetState.hovered)) {
    //     //       return Size(200, 60); // 悬停时尺寸较大
    //     //     }
    //     //     return Size(180, 55); // 默认尺寸
    //     //   },
    //     // ),
    //     // // 动态调整按钮的内边距
    //     // padding: WidgetStateProperty.resolveWith<EdgeInsetsGeometry>(
    //     //   (Set<WidgetState> states) {
    //     //     if (states.contains(WidgetState.pressed)) {
    //     //       return EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0);
    //     //     } else if (states.contains(WidgetState.hovered)) {
    //     //       return EdgeInsets.symmetric(vertical: 18.0, horizontal: 30.0);
    //     //     }
    //     //     return EdgeInsets.symmetric(vertical: 16.0, horizontal: 28.0);
    //     //   },
    //     // ),
    //
    //     splashFactory: CustomizeRipples(),
    //   ),
    //   child: Text('按钮'),
    // );
  }
}