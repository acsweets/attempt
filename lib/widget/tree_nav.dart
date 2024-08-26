import 'package:attempt/widget/tree_item.dart';
import 'package:flutter/material.dart';

import '../utils/color.dart';

///展开收起 根据数据生成可折叠的树形结构

class TreeNav extends StatefulWidget {
  final Widget child;

  const TreeNav({super.key, required this.child});

  @override
  State<TreeNav> createState() => _TreeNavState();
}

class _TreeNavState extends State<TreeNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
              width: 200,
              height: double.infinity,
              child: Column(
                children: [
                  Container(
                    child: Text('个人信息区域'),
                  ),
                  MenusTree(),
                ],
              )),
          const SizedBox(height: double.infinity,child: VerticalDivider(width: 2,color: ColorUtil.kGreyColor,),),
          Expanded(
              child: Container(
            color: ColorUtil.kBaseColor,
            width: double.infinity,
            height: double.infinity,
            child: widget.child,
          )),
        ],
      ),
    );
  }
}
