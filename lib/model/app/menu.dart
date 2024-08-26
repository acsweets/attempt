import 'package:flutter/cupertino.dart';

/// 导航栏
class Menu {
  final String label;
  final String path;
  final Icon ?icon;

  const Menu({required this.label, required this.path, this.icon});
}
