import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as v;

import '../../draw/widget/draw_line.dart';
import '../../draw/widget/twinkle.dart';
import '../../widget/custorm_rander.dart';

class MatrixPage extends StatefulWidget {
  const MatrixPage({super.key});

  @override
  State<MatrixPage> createState() => _MatrixPageState();
}

class _MatrixPageState extends State<MatrixPage> {
  Matrix4 matrix4 = Matrix4.identity();
  bool transform = false;

  @override
  void initState() {
    matrix4.scale(2.0);
    super.initState();
  }

  // 定义初始状态的宽度、高度和颜色
  double _width = 200;
  double _height = 200;
  Color _color = Colors.blue;

  // 用于切换大小和颜色的函数
  void _changeContainer() {
    setState(() {
      // 改变宽度、高度和颜色
      _width = _width == 200 ? 300 : 200;
      _height = _height == 200 ? 300 : 200;
      _color = _color == Colors.blue ? Colors.red : Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('矩阵'),
      ),
      body: Column(
        children: [
          //矩阵计算的可视化
          //思考以什么方式去修改矩阵,
          //输入20 或 16个数字，变换,
          Row(
            children: [
              // Container(
              //   width: 40,
              //   height: 40,
              //   decoration: const BoxDecoration(
              //     color: Colors.deepPurpleAccent,
              //   ),
              //   // transform: Matrix4.translation(v.Vector3(100,100, 0)),
              //   // transform: Matrix4.rotationZ(70),
              //   transform: matrix4,
              //
              //   child: Text('变换'),
              // ),
              AnimatedContainer(
                width: _width,
                height: _height,
                color: _color,
                // 设置动画的持续时间
                duration: Duration(seconds: 1),
                // 设置动画的缓动曲线
                curve: Curves.easeInCirc,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _changeContainer,
                child: Text('点击我改变大小和颜色'),
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      transform = !transform;
                    });
                  },
                  child: Text('变换'))
            ],
          ),

          AnimatedSwitcher(
            duration: const Duration(seconds: 3), // 动画持续时间
            transitionBuilder: (Widget child, Animation<double> animation) {
              // 这里定义动画过渡效果
              // return FadeTransition(opacity: animation, child: child);
              return AnimatedBuilder(
                  animation: animation,
                  builder: (_, c) {
                    //过渡完成后text会直接变化
                    return SizedBox(
                      // height:100 * animation.value,
                      child: child,
                    );
                    // return Opacity(opacity: animation.value, child: child);
                  });
            },
            child: Text(
              '$_count', // 变化的文本
              key: ValueKey<int>(_count), // 确保每次切换时有不同的 key
              style: TextStyle(fontSize: 48),
            ),
          ),
          SizedBox(height: 20),
          Circle(
            color: Colors.amber,
          ),
          ElevatedButton(
            onPressed: _incrementCount,
            child: Text('增加数字'),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: 100,
            height: 10,
            child: CustomPaint(
              painter: DrawLine(),
            ),
          ),
          // Container(
          //   color: Colors.blueGrey,
          //   height: 100,
          //   width: 100,
          //   child: EditableText(
          //     controller: TextEditingController(),
          //     focusNode: FocusNode(),
          //     style: TextStyle(),
          //     mouseCursor: MouseCursor.defer,
          //     cursorColor: Colors.deepPurpleAccent,
          //     backgroundCursorColor: Colors.red,
          //     // 光标颜色
          //     textAlign: TextAlign.left,
          //     // 左对齐
          //     cursorWidth: 2.0,
          //     // 设置光标宽度
          //     showCursor: true,
          //     // 显示光标
          //     cursorRadius: Radius.zero, // 设置为直角光标
          //   ),
          // ),
          //说明矩阵的的作用
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('文字'),
              TwinkleAnimated(
                cursor: SizedBox(
                  width: 2,
                  height: 20,
                  child: CustomPaint(
                    painter: DrawLine(),
                  ),
                ),
              ),
            ],
          ),
          ItemInPut(),
        ],
      ),
    );
  }

  int _count = 0;

  // 用于增加数字的函数
  void _incrementCount() {
    setState(() {
      _count += 1;
    });
  }
}

//输入思维矩阵点击矩阵
//思路把输入框藏起来 自己写一个通过有没有文字来控制样式，输入框的好几种状态
class MatrixInput extends StatefulWidget {
  const MatrixInput({super.key});

  @override
  State<MatrixInput> createState() => _MatrixInputState();
}

class _MatrixInputState extends State<MatrixInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//只展示 传入text 有动画 有光标
//使用定位，只需要一个控制器
class ItemInPut extends StatefulWidget {
  final InputStatus inputStatus;

  const ItemInPut({
    super.key,
    this.inputStatus = InputStatus.notEntered,
  });

  @override
  State<ItemInPut> createState() => _ItemInPutState();
}

class _ItemInPutState extends State<ItemInPut> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: widget.inputStatus == InputStatus.notEntered ? input() : Text(''),
    );
  }

  Widget input() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blueAccent, width: 2)),
      padding: const EdgeInsets.only(
        top: 20,
        left: 5,
        right: 5,
        bottom: 5,
      ),
      child: TwinkleAnimated(
          cursor: SizedBox(
              width: 15,
              height: 1,
              child: CustomPaint(
                painter: DrawLine(color: Colors.blue),
              ))),
    );
  }

  //阶乘
  int factorial(int i) {
    if (i == 1) return 1;
    return i * factorial(i - 1);
  }
}

//不同的输入状态
enum InputStatus {
  complete,
  wait,
  notEntered,
}
