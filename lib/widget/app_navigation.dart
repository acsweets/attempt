import 'package:attempt/attempt.dart';
import 'package:flutter/material.dart';

const List<Menu> _kAppMenus = [ Menu(label: "主页", path: ""),  Menu(label: "副页", path: "")];


class AppNavigation extends StatelessWidget {
  final Widget child;

  const AppNavigation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppNavBar(

        menus: _kAppMenus ,
      ),
      body: Column(
        children: [
          const Divider(),
          Expanded(child: child),
        ],
      ),
    );
  }
}

