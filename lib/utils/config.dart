import 'package:flutter/material.dart';

class Config {
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
    {
      'label': '小工具',
      'icon': Icons.draw,
      'path': '/tools',
      'children': [
        {
          'label': '取名困难',
          'icon': Icons.exposure_rounded,
          'path': '/tools/randomName',
        }
      ],
    },
  ];
  static const List<String> names = [
    "Chinese rose", //月季
    "violet", //紫罗兰；
    "cotton tree", //木棉
    // "lilac", //c
    // "lily", //百合
    "wall flower", //紫罗兰
    "peach", //桃花
    // "wisteria", //紫藤
    "tree peony", //牡丹
    "peony", //芍药
    "camellia", //茶花
    " cape jasmine", //栀子花
    "cockscomb", //鸡冠花；
    "honeysuckle", //金银花；
    "chrysanthemum", //菊花；
    // "carnation", // 康乃馨；
    "orchid", //兰花；
    "jasmine", //茉莉花；
    "daffodil", //水仙花；
    // "peony", //牡丹；
    "begonia", //秋海棠；
    // "cactus", //仙人掌；
    // "poppy", //罂粟；

  ];
}
