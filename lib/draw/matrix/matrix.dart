import 'package:flutter/material.dart';

/// 思考
/// 需求  矩阵变换的计算 坐标由矩阵变换得到一个新的坐标
/// 颜色 通过 矩阵变换得到一个新的颜色 . 图片加上遮罩
/// 矩阵的计算 矩阵的概念 矩阵的使用
///  三个页面  矩阵在图形变换中的使用，矩阵在颜色变换的使用  矩阵的概念=>加计算
///

/// 矩阵1 * 矩阵2
///

class MatrixCalculation extends StatefulWidget {
  const MatrixCalculation({super.key});

  @override
  State<MatrixCalculation> createState() => _MatrixCalculationState();
}

class _MatrixCalculationState extends State<MatrixCalculation> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  List<double> _customColorMatrix() {
    return [
      1.5, 0, 0, 0, 0, // 红色更亮 (1.5倍)
      0, 1, 0, 0, 0, // 绿色不变
      0, 0, 0.7, 0, 0, // 蓝色更暗 (0.7倍)
      0, 0, 0, 1, 0, // Alpha不变
    ];
  }
}
