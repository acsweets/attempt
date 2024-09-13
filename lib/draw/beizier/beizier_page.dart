//http://wx.karlew.com/canvas/bezier/
//https://aaaaaaaty.github.io/bezierMaker.js/playground/playground.html  多次加动画
//赛贝尔曲线可视化
//更新点 刷新 按住拖动 根据拖动的点来更新
//画布 可以拖动的点
// 切换二次还是3次

//  信息  （0.0）开始 展示点位 几个不同的点

//  上下 布局 相对点位
// 能不能添加多个赛贝尔曲线

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math';

import '../cartesian_coordinate_system/cartesian_coordinate.dart';

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
          Container(
              width: 500,
              height: 500,
              // child: BezierCanvas(),
              child: CustomPaint(
                painter: CartesianPainter(
                  unitLength: 1,
                  axisColor: Colors.red,
                ),
              )),
          // Center(
          //   child: Container(
          //     width: 500,
          //     height: 500,
          //     color: Colors.white,
          //     child: CustomPaint(
          //       painter: CustomizedSaber(),
          //     ),
          //   ),
          // ),

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

class BezierCanvas extends StatefulWidget {
  const BezierCanvas({super.key});

  @override
  createState() => _BezierCanvasState();
}

class _BezierCanvasState extends State<BezierCanvas> {
  List<Offset> clickNodes = [];
  bool isPrinted = false;
  bool isDragging = false;
  int? draggingIndex;
  double t = 0;
  List<Offset> bezierNodes = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onPanDown: (details) {
              setState(() {
                for (int i = 0; i < clickNodes.length; i++) {
                  if ((clickNodes[i] - details.localPosition).distance < 10) {
                    draggingIndex = i;
                    isDragging = true;
                    break;
                  }
                }
                if (!isDragging && !isPrinted) {
                  clickNodes.add(details.localPosition);
                }
              });
            },
            onPanUpdate: (details) {
              if (isDragging && draggingIndex != null) {
                setState(() {
                  clickNodes[draggingIndex!] = details.localPosition;
                });
              }
            },
            onPanEnd: (details) {
              setState(() {
                isDragging = false;
                draggingIndex = null;
              });
            },
            child: CustomPaint(
              painter: BezierPainter(clickNodes, bezierNodes, isPrinted, t),
              child: Container(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: clearCanvas,
                child: Text('清空画布'),
              ),
              ElevatedButton(
                onPressed: redrawBezier,
                child: Text('重绘曲线'),
              ),
              ElevatedButton(
                onPressed: startDrawingBezier,
                child: Text('开始绘制'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void clearCanvas() {
    setState(() {
      clickNodes.clear();
      bezierNodes.clear();
      isPrinted = false;
      t = 0;
    });
  }

  void redrawBezier() {
    setState(() {
      isPrinted = false;
      bezierNodes.clear();
      t = 0;
    });
  }

  void startDrawingBezier() {
    if (clickNodes.length < 2) return;

    setState(() {
      isPrinted = true;
      t = 0;
      bezierNodes = [];
    });
//你想要每隔一段时间执行某个操作，直到满足某个条件为止
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 16));
      setState(() {
        t += 0.01;
        if (t <= 1) {
          //通过线性插值的递归，递归一次少一个控制点，找到在t处曲线的点
          bezierNodes.add(_calculateBezierPoint(clickNodes, t));
        }
      });
      return t <= 1;
    });
  }

  // 笛卡尔坐标系
  //假如有3个点  [0,0]  [5,5], [0,10]   [计算内赛尔曲线] 【取t 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1】
  // 计算 t=0.1 时
  //第一次计算  [(0-5)*t,(0-5)*t] = [0.5,0.5]   [(5-0)*t,(5-10)*t] = [ 4.5, 5.5]
  // 第二次计算 [（0.5-4.5）*t,(0.5-5.5)*t ] = [0.9,1.0] 得到贝塞尔这个点
  // 计算 t=0.2 时
  //第一次计算  [(0-5)*t,(0-5)*t] = [1,1]   [(5-0)*t,(5-10)*t] = [4, 6]
  // 第二次计算 [（1-4）*t, (1-6)*t ] = [1.6,2.0] 得到贝塞尔这个点

//计算点
  Offset _calculateBezierPoint(List<Offset> points, double t) {
    List<Offset> nextPoints = [];
    for (int i = 0; i < points.length - 1; i++) {
      nextPoints.add(Offset(
        lerpDouble(points[i].dx, points[i + 1].dx, t)!,
        lerpDouble(points[i].dy, points[i + 1].dy, t)!,
      ));
    }
    if (nextPoints.length == 1) {
      return nextPoints[0];
    } else {
      return _calculateBezierPoint(nextPoints, t);
    }
  }
}

///double? lerpDouble(num? a, num? b, double t)
///a: 起始值 (num?)，即插值的开始点。如果为 null，Flutter 会将其视为 0。
/// b: 结束值 (num?)，即插值的终点。如果为 null，Flutter 会将其视为 0。
/// t: 插值系数 (double)，范围通常在 [0, 1] 之间，用来表示插值的比例：
/// t = 0 时，返回 a 的值；
/// t = 1 时，返回 b 的值；
/// t 在 0 到 1 之间时，返回 a 和 b 之间的中间值；
/// t 可以超出 0 到 1 的范围，从而实现外插值效果。
///double? result = lerpDouble(50, 100, 0.5);
/// print(result); // 输出 75.0

class BezierPainter extends CustomPainter {
  final List<Offset> clickNodes;
  final List<Offset> bezierNodes;
  final bool isPrinted;
  final double t;

  BezierPainter(this.clickNodes, this.bezierNodes, this.isPrinted, this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final controlPointPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5
      ..style = PaintingStyle.fill;

    // 绘制控制点及其连线
    for (int i = 0; i < clickNodes.length; i++) {
      //绘制控制点
      canvas.drawCircle(clickNodes[i], 5, controlPointPaint);
      if (i > 0) {
        //绘制两点连线
        canvas.drawLine(clickNodes[i - 1], clickNodes[i], paint);
      }
    }

    // 如果已开始绘制贝塞尔曲线
    if (isPrinted) {
      final bezierPaint = Paint()
        ..color = Colors.red
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;
      for (int i = 0; i < bezierNodes.length - 1; i++) {
        canvas.drawLine(bezierNodes[i], bezierNodes[i + 1], bezierPaint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
