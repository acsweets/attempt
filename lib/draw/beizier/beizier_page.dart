//http://wx.karlew.com/canvas/bezier/
//赛贝尔曲线可视化
//更新点 刷新 按住拖动 根据拖动的点来更新
//画布 可以拖动的点
// 切换二次还是3次

//  信息  （0.0）开始 展示点位 几个不同的点

//  上下 布局 相对点位
// 能不能添加多个赛贝尔曲线

import 'package:flutter/material.dart';

class SaberPage extends StatefulWidget {
  const SaberPage({super.key});

  @override
  State<SaberPage> createState() => _SaberPageState();
}

class _SaberPageState extends State<SaberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('赛贝尔曲线可视化'),
      ),
      body: Column(
        children: [
          //拖动更新点
          //细化就是  按下 移动 抬起
          // 二次是 3个点 3次是4 个点
          Center(
            child: Container(
              width: 500,
              height: 500,
              color: Colors.white,
              child: CustomPaint(
                painter: CustomizedSaber(),
              ),
            ),
          ),

          // 点位信息
Text('')
        ],
      ),
    );
  }
}

class CustomizedSaber extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
