import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

const double _kHeightLevel1 = 20; // 短线长
const double _kHeightLevel2 = 25; // 5 线长
const double _kHeightLevel3 = 30; //10 线长
const double _kPrefixOffSet = 5; // 左侧偏移
const double _kVerticalOffSet = 12; // 线顶部偏移
const double _kStrokeWidth = 2; // 刻度宽
const double _kSpacer = 4; // 刻度间隙
const List<Color> _kRulerColors = [
  // 渐变色
  Color(0xFF1426FB),
  Color(0xFF6080FB),
  Color(0xFFBEE0FB),
];
const List<double> _kRulerColorStops = [0.0, 0.2, 0.8];

class RulerChooser extends StatefulWidget {
  final Size size;
  final void Function(double) onChanged;
  final int min;
  final int max;

  const RulerChooser(
      {super.key,
      required this.onChanged,
      this.max = 200,
      this.min = 100,
      this.size = const Size(240.0, 60)});

  @override
  createState() => _RulerChooserState();
}

class _RulerChooserState extends State<RulerChooser> {
  final ValueNotifier<double> _dx = ValueNotifier(0.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _parser,
      child: CustomPaint(
          size: widget.size,
          painter: _HandlePainter(dx: _dx, max: widget.max, min: widget.min)),
    );
  }

  double dx = 0;

  void _parser(DragUpdateDetails details) {
    dx += details.delta.dx;
    if (dx > 0) {
      dx = 0.0;
    }
    var limitMax = -(widget.max - widget.min) * (_kSpacer + _kStrokeWidth);
    if (dx < limitMax) {
      dx = limitMax;
    }
    _dx.value = dx;

    widget.onChanged(details.delta.dx / (_kSpacer + _kStrokeWidth));
    }
}


class _HandlePainter extends CustomPainter {
  final _paint = Paint();
  final Paint _pointPaint = Paint();

  final ValueNotifier<double> dx;
  final int max;
  final int min;

  _HandlePainter({required this.dx, required this.max, required this.min}) : super(repaint: dx) {
    _paint
      ..strokeWidth = _kStrokeWidth
      ..shader = ui.Gradient.radial(
          const Offset(0, 0), 25, _kRulerColors, _kRulerColorStops, TileMode.mirror);
    _pointPaint
      ..color = Colors.purple
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);

    drawArrow(canvas);
    canvas.translate(_kStrokeWidth / 2 + _kPrefixOffSet, _kVerticalOffSet);
    canvas.translate(dx.value, 0);
    drawRuler(canvas);
  }

  // 绘制刻度
  void drawRuler(Canvas canvas) {
    double y = _kHeightLevel1;
    for (int i = min; i < max + 5; i++) {
      if (i % 5 == 0 && i % 10 != 0) {
        y = _kHeightLevel2;
      } else if (i % 10 == 0) {
        y = _kHeightLevel3;
        _simpleDrawText(canvas, i.toString(),
            offset: Offset(-3, _kHeightLevel3 + 5));
      } else {
        y = _kHeightLevel1;
      }
      canvas.drawLine(Offset.zero, Offset(0, y), _paint);
      canvas.translate(_kStrokeWidth + _kSpacer, 0);
    }
  }

  // 绘制三角形尖角
  void drawArrow(Canvas canvas) {
    var path = Path()
      ..moveTo(_kStrokeWidth / 2 + _kPrefixOffSet, 3)
      ..relativeLineTo(-3, 0)
      ..relativeLineTo(3, _kPrefixOffSet)
      ..relativeLineTo(3, -_kPrefixOffSet)
      ..close();
    canvas.drawPath(path, _pointPaint);
  }

  void _simpleDrawText(Canvas canvas, String str,
      {Offset offset = Offset.zero}) {
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle())
      ..pushStyle(
        ui.TextStyle(
            color: Colors.black, textBaseline: ui.TextBaseline.alphabetic),
      )
      ..addText(str);
    canvas.drawParagraph(
        builder.build()
          ..layout(ui.ParagraphConstraints(width: 11.0 * str.length)),
        offset);
  }

  @override
  bool shouldRepaint(_HandlePainter oldDelegate) =>
      oldDelegate.dx != dx || oldDelegate.min != min || oldDelegate.max != max;
}


//曲线小球运动 animationValue 的值修改小球的圆心的位置

class BallDrawingCurveAnimation extends StatefulWidget {
  const BallDrawingCurveAnimation({super.key});

  @override
   createState() => _BallDrawingCurveAnimationState();
}

class _BallDrawingCurveAnimationState extends State<BallDrawingCurveAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Offset> _points = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    // )..repeat();
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ball Drawing Curve Animation')),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            const size = Size(300, 300);
            final x = size.width * _controller.value;
            final y = size.height / 2 + math.sin(_controller.value * 2 * math.pi) * 50;
            _points.add(Offset(x, y));
            return CustomPaint(
              size: size,
              painter: BallDrawingCurvePainter(_points, Offset(x, y)),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            _points.clear();
            _controller.reset();
            _controller.forward();
          });
        },
      ),
    );
  }
}

class BallDrawingCurvePainter extends CustomPainter {
  final List<Offset> points;
  final Offset ballPosition;

  BallDrawingCurvePainter(this.points, this.ballPosition);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }

    // Draw the ball
    final ballPaint = Paint()..color = Colors.red;
    canvas.drawCircle(ballPosition, 10, ballPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}