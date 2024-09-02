import 'package:flutter/material.dart';

class Config{
  static const List<Map<String, dynamic>> appMenus = [
    {
      'label': '主页',
      'path': '/home',
      'children': [],
    },
    {
      'label': '动画',
      'icon': Icons.animation,
      'path': '/animation',
      'children': [
        {
          'label': '案例',
          'path': '/animation/example',
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
    },
  ];
}