import 'dart:ui';

void main() {
  // calculatePoints();
  // print(countSpecialNumbers(99));
  print(factorial(10));
}

// void startDrawingBezier() {
//   if (clickNodes.length < 2) return;
//
//   setState(() {
//     isPrinted = true;
//     t = 0;
//     bezierNodes = [];
//   });
// //你想要每隔一段时间执行某个操作，直到满足某个条件为止
//   Future.doWhile(() async {
//     await Future.delayed(const Duration(milliseconds: 16));
//     setState(() {
//       t += 0.01;
//       if (t <= 1) {
//         //通过线性插值的递归，递归一次少一个控制点，只剩1个点递归结束，找到在t处贝塞尔曲线的点
//         bezierNodes.add(_calculateBezierPoint(clickNodes, t));
//       }
//     });
//     return t <= 1;
//   });
// }
// 笛卡尔坐标系
//假如有3个点  [0,0]  [0,5], [0,10]   [计算内赛尔曲线] 【取t 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1】
// [ ]
//计算点
// Offset _calculateBezierPoint(List<Offset> points, double t) {
//   List<Offset> nextPoints = [];
//   for (int i = 0; i < points.length - 1; i++) {
//     nextPoints.add(Offset(
//       lerpDouble(points[i].dx, points[i + 1].dx, t)!,
//       lerpDouble(points[i].dy, points[i + 1].dy, t)!,
//     ));
//   }
//   if (nextPoints.length == 1) {
//     return nextPoints[0];
//   } else {
//     return _calculateBezierPoint(nextPoints, t);
//   }
// }
// }
void calculatePoints() {
  if (points.length < 2) return;
  List<Point> bezierNodes = [];
  double t = 0;

  while (t < 0.9) {
    t += 0.1;
    //通过线性插值的递归，递归一次少一个控制点，只剩1个点递归结束，找到在t处贝塞尔曲线的点
    bezierNodes.add(_calculateBezierPoint(points, t));
  }

  // Future.doWhile(() async {
  //   await Future.delayed(const Duration(milliseconds: 16));
  //   // t += 0.01;
  //   t += 0.1;
  //   if (t <= 1) {
  //     //通过线性插值的递归，递归一次少一个控制点，只剩1个点递归结束，找到在t处贝塞尔曲线的点
  //     bezierNodes.add(_calculateBezierPoint(points, t));
  //   }
  //   return t <= 1;
  // });
}

Point _calculateBezierPoint(List<Point> points, t) {
  List<Point> nextPoints = [];
  for (int i = 0; i < points.length - 1; i++) {
    nextPoints.add(Point(
      lerpDouble(points[i].dx, points[i + 1].dx, t)!,
      lerpDouble(points[i].dy, points[i + 1].dy, t)!,
    ));
  }
  if (nextPoints.length == 1) {
    //t时 这个贝塞尔曲线的点
    print('${nextPoints[0]}');
    return nextPoints[0];
  } else {
    return _calculateBezierPoint(nextPoints, t);
  }
}

List<Point> points = [Point(0, 0), Point(5, 5), Point(0, 10)];
Map<String, dynamic> pointsMap = {
  'points': [
    {
      'dx': 0,
      'dy': 0,
    },
    {
      'dx': 5,
      'dy': 5,
    },
    {
      'dx': 0,
      'dy': 10,
    },
  ]
};

class Point {
  final double dx;
  final double dy;

  Point(
    this.dx,
    this.dy,
  );

  factory Point.formMap(Map<String, dynamic> map) {
    return Point(map['dx'], map['dy']);
  }

  @override
  String toString() {
    return '($dx,$dy)';
  }
}

int countSpecialNumbers(int n) {
  int speNum = 0;
  for (int i = 1; i <= n; i++) {
    if (special(i)) {
      speNum++;
    }
  }

  return speNum;
}

bool special(int n) {
  List<String> num = n.toString().split('');
  if (num.length == num.toSet().toList().length) {
    return true;
  } else {
    return false;
  }
}

int factorial(int i) {
  if (i == 1) return 1;
  return i * factorial(i - 1);
}


