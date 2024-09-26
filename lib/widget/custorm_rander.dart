import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

// 自定义的 RenderObject
class RenderCircle extends RenderBox {
  Color color;

  RenderCircle({required this.color});

  @override
  void performLayout() {
    // 设置自身的大小为 100x100 的正方形
    size = constraints.constrain(Size(100, 100));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final paint = Paint()..color = color;
    final center = offset + Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // 绘制一个圆
    context.canvas.drawCircle(center, radius, paint);
  }
}


class Circle extends LeafRenderObjectWidget {
  final Color color;

  const Circle({super.key, required this.color});

  @override
  RenderCircle createRenderObject(BuildContext context) {
    return RenderCircle(color: color);
  }

  @override
  void updateRenderObject(BuildContext context, RenderCircle renderObject) {
    renderObject.color = color;
  }
}


// 自定义的多子组件 RenderObject
class RenderCustomMultiChild extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, ContainerBoxParentData<RenderBox>>,
        RenderBoxContainerDefaultsMixin<RenderBox, ContainerBoxParentData<RenderBox>> {
  late final double spacing;

  RenderCustomMultiChild({required this.spacing});

  @override
  void performLayout() {
    double currentX = 0; // 水平方向上的偏移量
    double maxHeight = 0; // 用于存储容器的最大高度

    // 遍历所有子组件，测量并布局
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as ContainerBoxParentData<RenderBox>;

      // 告诉每个子组件如何进行布局
      child.layout(BoxConstraints.tightFor(width: 50, height: 50), parentUsesSize: true);

      // 记录每个子组件的位置信息
      childParentData.offset = Offset(currentX, 0);

      // 更新当前水平偏移量，加入子组件的宽度以及自定义的间距
      currentX += child.size.width + spacing;

      // 更新容器的最大高度
      maxHeight = maxHeight < child.size.height ? child.size.height : maxHeight;

      // 获取下一个子组件
      child = childAfter(child);
    }

    // 设置容器的大小
    size = Size(currentX - spacing, maxHeight); // 减去最后一个间距
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    RenderBox? child = firstChild;

    // 逐个绘制每个子组件
    while (child != null) {
      final childParentData = child.parentData as ContainerBoxParentData<RenderBox>;
      context.paintChild(child, childParentData.offset + offset);

      // 获取下一个子组件
      child = childAfter(child);
    }
  }
}



class CustomMultiChildWidget extends MultiChildRenderObjectWidget {
  final double spacing;

  const CustomMultiChildWidget({
    super.key,
    required this.spacing,
    required super.children,
  });

  @override
  RenderCustomMultiChild createRenderObject(BuildContext context) {
    return RenderCustomMultiChild(spacing: spacing);
  }

  @override
  void updateRenderObject(BuildContext context, RenderCustomMultiChild renderObject) {
    renderObject.spacing = spacing;
  }
}


class MyCustomRenderBox extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, ContainerBoxParentData<RenderBox>> {
  @override
  void performLayout() {
    double totalWidth = 0.0;
    double maxHeight = 0.0;

    // 遍历子组件，进行布局
    RenderBox? child = firstChild;
    while (child != null) {
      child.layout(const BoxConstraints(maxWidth: double.infinity));
      final BoxParentData childParentData = child.parentData as BoxParentData;
      childParentData.offset = Offset(totalWidth, 0);
      totalWidth += child.size.width;
      maxHeight = math.max(maxHeight, child.size.height);
      child = childAfter(child);
    }

    size = Size(totalWidth, maxHeight);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    RenderBox? child = firstChild;
    while (child != null) {
      final BoxParentData childParentData = child.parentData as BoxParentData;
      context.paintChild(child, childParentData.offset + offset);
      child = childAfter(child);
    }
  }
}

