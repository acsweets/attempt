import 'package:flutter/material.dart';

import '../model/model.dart';

///简单封装了下TabBar
class NavBar extends StatefulWidget {
  final List<Menu> menus;
  final Color tabColor;
  final double menuRadius;
  final double margin;

  const NavBar(
      {super.key,
        required this.menus,
        this.tabColor = Colors.blue,
        this.menuRadius = 10,
        this.margin = 5});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(vsync: this, length: widget.menus.length);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorWeight: 0,
      dividerColor: Colors.transparent,
      indicatorColor: Colors.transparent,
      tabs: List.generate(widget.menus.length, (i) {
        return Nav(
          menuRadius: widget.menuRadius,
          menu: widget.menus[i],
          selectColor: _controller.index == i
              ? widget.tabColor
              : widget.tabColor.withOpacity(0.5),
        );
      }),
      controller: _controller,
      onTap: (i) {
        setState(() {});
      },

      ///label 的内边距
      labelPadding: EdgeInsets.zero,
      indicator: BoxDecoration(
          border: Border.all(width: 0.5, color: Colors.transparent)),
      indicatorPadding: EdgeInsets.zero,
      splashBorderRadius: BorderRadius.circular(widget.menuRadius),
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
          if (states.contains(WidgetState.hovered)) {
            return widget.tabColor.withOpacity(0.2);
          }
          if (states.contains(WidgetState.focused)) {
            return widget.tabColor;
          }
          if (states.contains(WidgetState.pressed)) {
            return widget.tabColor.withOpacity(0.5);
          }
          return null;
        },
      ),
    );
  }
}

class Nav extends StatelessWidget {
  final Menu menu;
  final Color? selectColor;
  final double menuRadius;
  final double margin;
  final TextStyle? labelStyle;

  const Nav(
      {super.key,
      required this.menu,
      this.selectColor,
      this.labelStyle,
      this.menuRadius = 10,
      this.margin = 5});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: selectColor,
        borderRadius: BorderRadius.circular(menuRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (menu.icon != null) menu.icon!,
          Text(
            menu.label,
            style: labelStyle ?? const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}

