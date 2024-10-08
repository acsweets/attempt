import 'package:attempt/attempt.dart';
import 'package:flutter/material.dart';


class AppNavBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Menu> menus;
  final Widget? logo;
  final double? barHeight;

  const AppNavBar({super.key, required this.menus, this.logo, this.barHeight});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: kToolbarHeight,
          child: NavigationToolbar(
            leading: logo,
            middle: SizedBox(
                width: 200,
                child: NavBar(
                  menus: menus,
                  menuRadius: 0,
                )),
            // trailing: const Row(children: [Icon(Icons.ac_unit_rounded)]),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(barHeight ?? kToolbarHeight);
}
