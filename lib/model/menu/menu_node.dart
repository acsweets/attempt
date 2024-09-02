import 'package:flutter/material.dart';

class MenuNode {
  bool select;
  final String label;
  final IconData? icon;
  final String path;
  final List<MenuNode> children;
  String route;

  bool get isLeaf => children.isEmpty;

  MenuNode(this.label,
      {this.path = '/404',
        this.icon,
        required this.children,
        this.select = false,
        this.route = ''});

  factory MenuNode.fromMap(Map<String, dynamic> map) {
    return MenuNode(
      map['label'],
      icon: map['icon'],
      path: map['path'],
      children: map['children'] == null
          ? []
          : (map['children'] as List).map((e) => MenuNode.fromMap(e)).toList(),
    );
  }
}