import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class SwitchCard extends StatefulWidget {
  const SwitchCard({super.key});

  @override
  State<SwitchCard> createState() => _SwitchCardState();
}

class _SwitchCardState extends State<SwitchCard> {
  final List<Color> _cardColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 300,
                height: double.infinity,
                color: _cardColors[index],
              );
            },
            itemCount: _cardColors.length,
            itemWidth: 300.0,
            layout: SwiperLayout.STACK,

              indicatorLayout:PageIndicatorLayout.DROP,
              pagination: const SwiperPagination(
                  alignment: Alignment.topCenter),
          ),
        ),
        SizedBox(
          height: 200,
          child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 300,
                  height: double.infinity,
                  color: _cardColors[index],
                  child: Text('$index'),
                );
              },
              itemCount: _cardColors.length,
              itemWidth: 300.0,
              itemHeight: 400.0,
              layout: SwiperLayout.CUSTOM,
              customLayoutOption: CustomLayoutOption(
                  // Which index is the first item of array below
                  startIndex: -1,
                  // array length
                  stateCount: 3)
                // ..addRotate([
                //   // rotation of every item
                //   -45.0 / 180,
                //   0.0,
                //   45.0 / 180
                // ])
                ..addTranslate([
                  // offset of every item
                  Offset(30.0, 20.0),
                  Offset(20.0, 10.0),
                  Offset(10.0,0.0),
                  Offset(370.0, 0.0)
                ])

                // ..addScale([
                //  1,
                //   0.9,
                //   0.8,
                //   0.8,
                // ],Alignment.centerLeft )
              // customLayoutOption: CustomLayoutOption(
              //   // Which index is the first item of array below
              //     startIndex: -1,
              //     // array length
              //     stateCount: 3
              // )
              //   // ..addRotate([
              //   //   // rotation of every item
              //   //   -45.0 / 180,
              //   //   0.0,
              //   //   45.0 / 180
              //   // ])
              //   ..addTranslate([
              //     // offset of every item
              //     Offset(-370.0, -40.0),
              //     Offset(0.0, 0.0),
              //     Offset(370.0, -40.0)
              //   ])

              //
              // customLayoutOption: CustomLayoutOption(
              //     startIndex: -1,
              //     stateCount: 3
              // )
              //   ..addRotate([
              //   -45.0/180,
              //   0.0,
              //   45.0/180
              // ])
              //   ..addTranslate([
              //     //Offset(x, y) ,x 是横向偏移量  y 垂直方向
              //   Offset(0.0, 0.0), //Offset(x, y)   第一个卡片偏移量
              //   Offset(-30.0, 0.0), // 第二个卡片偏移量
              //   Offset(-50.0, 0.0)// 第三个卡片偏移量
              // ]),
              ),
        )
      ],
    );
  }
}
