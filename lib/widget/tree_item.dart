import 'package:attempt/attempt.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

typedef OnSelectMenu = void Function(
  String id,
);

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

  bool _select = false;

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
            onSelect: (id) {
              if (id == menus[i].id) {
                _select = true;
                setState(() {});
              }
            },
            select: _select,
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
    menus = widget.menus ?? appMenus.map((e) => MenuNode.formMap(e)).toList();
  }
}

class TreeItem extends StatefulWidget {
  final MenuNode menus;
  final int depth;
  final OnSelectMenu? onSelect;
  final bool select;

  const TreeItem({
    super.key,
    required this.menus,
    this.depth = 0,
    this.onSelect,
    this.select = false,
  });

  @override
  State<TreeItem> createState() => _TreeItemState();
}

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
            backgroundColor: ColorUtil.stateAllColor(widget.select
                ? ColorUtil.kBaseColor
                : ColorUtil.kBackgroundColor),
            foregroundColor: ColorUtil.stateAllColor(Colors.blueGrey),
          ),
          onPressed: () {
            widget.onSelect?.call(widget.menus.id);
            showChildren = !showChildren;
            context.go(widget.menus.path);
            setState(() {});
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

class MenuNode {
  String id;
  String label;
  IconData? icon;
  String path;
  List<MenuNode> children;

  MenuNode(this.label,
      {this.path = '/404',
      this.icon,
      required this.children,
      required this.id});

  factory MenuNode.formMap(Map<String, dynamic> map) {
    return MenuNode(
      map['label'],
      icon: map['icon'],
      path: map['path'],
      children: map['children'] == null
          ? []
          : (map['children'] as List).map((e) => MenuNode.formMap(e)).toList(),
      id: const Uuid().v4(),
    );
  }
}

const List<Map<String, dynamic>> appMenus = [
  {
    'label': '动画',
    'icon': Icons.animation,
    'path': '/animation',
    'children': [
      {
        'label': '案例',
        'path': '/example',
        'icon': Icons.exposure_rounded,
        'children': [
          {
            'label': '案例 1',
            'path': '/animation/example/one',
            'children': [],
          },
          {
            'label': '案例 2',
            'path': '/animation/example/two',
            'children': [],
          },
        ],
      },
      {
        'label': '知识点',
        'path': '/knowledge',
        'icon': Icons.article,
        'children': [
          {
            'label': '知识点 1',
            'path': '/animation/knowledge/one',
            'children': [],
          },
          {
            'label': '知识点 2',
            'path': '/animation/knowledge/two',
            'children': [],
          },
        ],
      }
    ],
  },
  {
    'label': '绘制',
    'icon': Icons.draw,
    'path': '/draw',
    'children': [
      {
        'label': '案例',
        'icon': Icons.exposure_rounded,
        'path': '/draw/example',
        'children': [
          {
            'label': '案例 1',
            'path': '/draw/example/one',
            'children': [],
          },
        ],
      }
    ],
  }
];
