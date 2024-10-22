// 桥接模式允许你在形状和颜色两个维度上分别扩展
abstract class Shape {
  Shape(this.colorI);

  ColorI colorI;
}

class CircleShape extends Shape {
  CircleShape(super.colorI);
}

class TriangleShape extends Shape {
  TriangleShape(super.colorI);
}

abstract class ColorI {}

class RedColor extends ColorI {}
