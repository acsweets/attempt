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
            {
              'label': '案例 1',
              'path': '/draw/example/two',
              'children': [],
            },
          ],
        },
        {
          'label': '卡迪尔坐标系',
          'icon': Icons.exposure_rounded,
          'path': '/draw/cartesian',
        },
        {
          'label': '矩阵变换',
          'icon': Icons.exposure_rounded,
          'path': '/draw/matrix',
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
        },
        {
          'label': '赛贝尔曲线可视化',
          'icon': Icons.exposure_rounded,
          'path': '/tools/saber',
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
    "oak", //- 橡树（坚硬的木材，多用于建筑和家具）
    "pine", //- 松树（常绿针叶树，木材常用于建筑）
    "maple", //- 枫树（以糖枫为著名，树液可制作枫糖浆）
    "birch", //- 桦树（树皮白色或灰色，木材柔韧）
    "cedar", //- 雪松（常绿乔木，木材具有芳香，防虫效果好）
    "willow", //- 柳树（细长柔软的枝条，常生长在水边）
    "cherry", //- 樱桃树（开花美丽，木材用于高档家具）
    "spruce", //- 云杉（针叶常绿树种，木材轻质适合做乐器）
    "ash", //- 白蜡树（木材坚硬有弹性，常用于制作工具）
    "elm", //- 榆树（木材坚固，常用于家具和建筑）
    "poplar", //- 杨树（木材柔软轻盈，常用于造纸）
    "redwood", //- 红杉（世界上最高的树，木材耐腐）
    "mahogany", //- 桃花心木（红色硬木，用于高档家具）
    "cypress", //- 柏树（常绿乔木，木材耐腐，适合户外使用）
    "ebony", //- 乌木（黑色硬木，密度高，常用于工艺品）
    "walnut", //- 胡桃木（坚硬的木材，常用于高档家具和乐器）
    "sycamore", //- 悬铃木（木材坚硬，常用于地板和家具）
    "beech", //- 山毛榉（木材坚硬，有弹性，常用于制作乐器）
    "teak", //- 柚木（木材耐水，常用于船舶和家具）
    "fir", //- 冷杉（常绿针叶树，木材轻质适用于建筑）
    "bamboo", //- 竹子（空心的茎，常用于建筑和工艺品）
    "sandalwood", //- 檀香木（芳香木材，常用于香料和雕刻）
    "yew", //- 紫杉（常绿针叶树，木材用于弓和工具柄）
    "hickory", //- 山胡桃（木材坚硬有弹性，常用于工具和乐器）
    "larch", //- 落叶松（针叶树，木材耐腐，适合户外使用）
    "alder", //- 赤杨（木材柔软，常用于制作家具和乐器）
    "holly", //- 冬青树（叶子尖锐，木材适合雕刻和装饰）
    "chestnut", //- 栗树（木材坚硬，栗子可食用）
    "magnolia", //- 木兰树（开花美丽，常用于园艺观赏）
    "linden", //- 椴树（木材柔软轻质，常用于雕刻）
    "sequoia", //- 巨杉（世界上最大和最高的树种之一）
    "juniper", //- 杜松（木材用于制作家具和香料）
    "boxwood", //- 黄杨木（木材质地细腻，适合雕刻）
    "hornbeam", //- 鹅耳枥（木材坚硬，常用于工具和器具）
    "olive", //- 橄榄树（木材用于家具，橄榄果可食用）
    "palmetto", //- 美洲棕榈（常见的棕榈树种，适合热带气候）
    "sassafras", //- 洋玉兰（芳香木材，常用于药物和香料）
    "tamarind", //- 罗望子（木材用于建筑，果实可食用）
    "mulberry", //- 桑树（果实可食用，树叶喂养蚕）
    "baobab", //- 猴面包树（树干巨大，果实含丰富维生素C）
    "ginkgo", //- 银杏（落叶乔木，树叶常用于药物）
    "palm", //- 棕榈树（常用于热带地区，提供椰子、棕榈油等）
    "eucalyptus", //- 桉树（芳香木材，常用于医药和香料）
    "balsa", //- 巴尔沙木（世界上最轻的木材，常用于模型制作）
    "acacia", //- 金合欢（木材坚硬，常用于制作家具）
    "rosewood", //- 红木（深色硬木，常用于高档家具和乐器）
    "tulipwood", //- 郁金香木（木材色彩丰富，适合制作工艺品）
    "coconut", //- 椰子树（果实用于食品，树木可制作家具）
    "elmwood", //- 榆木（木材坚固，耐久性强，适合建筑和家具）
    "bamboo grass", //- 竹草（常见的草本植物，用于编织工艺品）
  ];
}



