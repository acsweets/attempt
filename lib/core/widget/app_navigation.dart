import 'package:flutter/material.dart';

import '../../core/model/menu.dart';
import '../../core/widget/app_nav_bar.dart';

class AppNavigation extends StatelessWidget {
  final Widget child;

  const AppNavigation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppNavBar(
        menus: [Menu(label: "主页", path: ""), Menu(label: "副页", path: "")],
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
