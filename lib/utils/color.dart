import 'package:flutter/material.dart';

class ColorUtil {
  ///app主色调
  static const Color kBaseColor = Color(0xff1ec9b0);
  static const Color kBackgroundColor = Color(0xffffffff);

  static const Color kGreyColor = Colors.grey;

  static WidgetStateProperty<Color?> stateColor([
    Color baseColor = kBaseColor,
    Color? hoverColor,
    Color? pressColor,
  ]) {
    return WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) {
        //移入
        if (states.contains(WidgetState.hovered)) {
          return hoverColor ?? baseColor.withOpacity(0.2);
        }
        //点击
        if (states.contains(WidgetState.focused) ||
            states.contains(WidgetState.pressed)) {
          return pressColor ?? baseColor.withOpacity(0.3);
        }
        return null;
      },
    );
  }

  static WidgetStateProperty<Color?> stateAllColor([
    Color baseColor = kBaseColor,
  ]) {
    return WidgetStateProperty.all<Color?>(baseColor);
  }
}
