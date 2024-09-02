

import 'package:flutter/material.dart';

///[select] 对menuNode节点的处理，他主要对树形结构的遍历 拼一下path
typedef MenuMateExtParser = MenuMateExt Function(Map<String, dynamic> data);

class MenuNode implements Identify<String> {
  final List<MenuNode> children;
  final int depth;
  final MenuMeta data;

  bool get isLeaf => children.isEmpty;

  const MenuNode({
    this.children = const [],
    required this.data,
    this.depth = 0,
  });

  @override
  String get id => data.id;

  factory MenuNode.fromMap(
      Map<String, dynamic> data, {
        int deep = -1,
        String prefix = '',
        MenuMateExtParser? extParser,
      }) {
    String path = data['path'] ?? '';
    String label = data['label'] ?? '';
    IconData? icon = data['icon'];
    List<Map<String, dynamic>>? childrenMap = data['children'];
    List<MenuNode> children = [];

    if (childrenMap != null && childrenMap.isNotEmpty) {
      for (int i = 0; i < childrenMap.length; i++) {
        MenuNode cNode = MenuNode.fromMap(childrenMap[i],
            deep: deep + 1, prefix: prefix + path, extParser: extParser);
        children.add(cNode);
      }
    }

    MenuMateExt? ext;

    if (extParser != null) {
      ext = extParser(data);
    }

    return MenuNode(
      depth: deep,
      data: MenuMeta(router: prefix + path, label: label, icon: icon, ext: ext),
      children: children,
    );
  }

  MenuNode? find(String id) {
    return queryMenuNodeByPath(this, id);
  }

  MenuNode? queryMenuNodeByPath(MenuNode node, String id) {
    if (node.id == id) {
      return node;
    }
    if (node.children.isNotEmpty) {
      for (int i = 0; i < node.children.length; i++) {
        MenuNode? result = queryMenuNodeByPath(node.children[i], id);
        if (result != null) {
          return result;
        }
      }
    }
    return null;
  }
}

class MenuTreeMeta {
  final List<String> expandMenus;
  final MenuNode? activeMenu;
  final MenuNode root;

   List<MenuNode> get items=>root.children;

  MenuTreeMeta({
    required this.expandMenus,
    required this.activeMenu,
    required this.root,
  });

  MenuNode? queryMenuNodeByPath(MenuNode node, String path) {
    if (node.id == path) {
      return node;
    }
    if (node.children.isNotEmpty) {
      for (int i = 0; i < node.children.length; i++) {
        MenuNode? result = queryMenuNodeByPath(node.children[i], path);
        if (result != null) {
          return result;
        }
      }
    }
    return null;
  }

  MenuTreeMeta selectPath(String path,{bool singleExpand=false}) {
    MenuNode? node = queryMenuNodeByPath(root,path);
    if(node==null) return this;
    return select(node);
  }

  MenuTreeMeta select(MenuNode menu,{bool singleExpand=false}) {
    if (menu.isLeaf) return copyWith(activeMenu: menu);
    List<String> menus = [];
    String path = menu.id.substring(1);
    List<String> parts = path.split('/');

    if (parts.isNotEmpty) {
      String path = '';
      for (String part in parts) {
        path += '/$part';
        menus.add(path);
      }
    }

    if (expandMenus.contains(menu.id)) {
      menus.remove(menu.id);
      // expandMenus.map((e) => null);
    }

    if(!singleExpand){
      menus.addAll(expandMenus.where((e) => e!=menu.id));
    }

    return copyWith(expandMenus: menus);
  }

MenuTreeMeta copyWith({
  List<String>? expandMenus,
  MenuNode? activeMenu,
  MenuNode? root,
}) {
  return MenuTreeMeta(
    expandMenus: expandMenus ?? this.expandMenus,
    activeMenu: activeMenu ?? this.activeMenu,
    root: root ?? this.root,
  );
}}
abstract class MenuMateExt{
  const MenuMateExt();

  T? me<T extends MenuMateExt>(){
    return call<T>();
  }

  T? call<T extends MenuMateExt>(){
    if(this is T){
      return this as T;
    }
    return null;
  }
}

class MenuMeta implements Identify<String>{
  final String router;
  final String label;
  final IconData? icon;
  final MenuMateExt? ext;

  const MenuMeta({
    this.router = '',
    required this.label,
    this.icon,
    this.ext,
  });

  @override
  String toString() {
    return 'MenuMeta{router: $router, label: $label, icon: $icon}';
  }

  bool get enable => router.isNotEmpty;

  @override
  String get id => router;
}

abstract interface class Identify<T> {
  T get id;
}
