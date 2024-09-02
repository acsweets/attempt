import 'package:attempt/attempt.dart';
import 'package:flutter/material.dart';

import '../model/menu/menu_node.dart';
import '../model/menu/menu_state.dart';
import '../utils/config.dart';

typedef OnSelectMenu = void Function();

class MenusTree extends StatefulWidget {
  final List<MenuNode>? menus;
  final int depth;

  const MenusTree({super.key, this.menus, this.depth = 0});

  @override
  State<MenusTree> createState() => _MenusTreeState();
}

class _MenusTreeState extends State<MenusTree> {
  late List<MenuNode> menus;

  @override
  void initState() {
    parseMenus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: menus.length,
      itemBuilder: (_, i) {
        return Container(
          decoration: BoxDecoration(
            border: const Border(
                top: BorderSide(width: 1, color: ColorUtil.kGreyColor)),
            borderRadius: BorderRadius.circular(2),
          ),
          child: TreeItem(
            menus: menus[i],
            depth: widget.depth + 1,
          ),
        );
      },
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }

  Future<void> parseMenus() async {
    menus = widget.menus ??
        Config.appMenus.map((e) => MenuNode.fromMap(e)).toList();
  }
}

class TreeItem extends StatefulWidget {
  final MenuNode menus;
  final int depth;
  final OnSelectMenu? onSelect;

  const TreeItem({
    super.key,
    required this.menus,
    this.depth = 0,
    this.onSelect,
  });

  @override
  State<TreeItem> createState() => _TreeItemState();
}

MenuState menuState = MenuState();

class _TreeItemState extends State<TreeItem> {
  bool showChildren = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(2))),
            overlayColor: ColorUtil.stateColor(),
            backgroundColor: ColorUtil.stateAllColor(widget.menus.select
                ? ColorUtil.kBaseColor
                : ColorUtil.kBackgroundColor),
            foregroundColor: ColorUtil.stateAllColor(Colors.blueGrey),
          ),
          onPressed: () {
            setState(() {
              menuState.selectNode(widget.menus);
              showChildren = !showChildren;
              context.go(widget.menus.path);
            });
            widget.onSelect?.call();
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5.0 * widget.depth, right: 5),
                child: Text(widget.menus.label),
              ),
              if (widget.menus.icon != null)
                Icon(
                  widget.menus.icon,
                  size: 18,
                ),
              const Spacer(),
              if (widget.menus.children.isNotEmpty)
                Icon(showChildren
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_right),
            ],
          ),
        ),
        Visibility(
            visible: showChildren,
            child: MenusTree(
              menus: widget.menus.children,
              depth: widget.depth + 1,
            )),
      ],
    );
  }
}
