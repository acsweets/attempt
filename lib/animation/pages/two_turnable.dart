import 'package:flutter/material.dart';

import '../config_animation.dart';
import '../widget/turntable.dart';

class SpinningPage extends StatefulWidget {
  const SpinningPage({super.key});

  @override
  createState() => _SpinningPageState();
}

class _SpinningPageState extends State<SpinningPage> {
  late List<Gua> guaList;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const largeWheelSize = 200.0; // 大转盘的直径是屏幕宽度
    const smallWheelSize = largeWheelSize / 2; // 小转盘的直径是大转盘的1/2
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('摇卦'),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            // 大转盘
            Positioned(
              top: 20, // 大转盘的中心点在顶点
              child: BaGuaWheel(
                size: largeWheelSize,
                onComplete: (Gua gua) {
                  setState(() {
                    // logger.info("当前上卦:$gua");
                    guaList.first = gua;
                  });
                },
              ),
            ),
            // 小转盘
            Positioned(
              top: largeWheelSize + 60, // 小转盘放在大转盘下方
              child: BaGuaWheel(
                size: smallWheelSize,
                onComplete: (Gua gua) {
                  setState(() {
                    // logger.info("当前下卦:$gua");
                    guaList.last = gua;
                  });
                },
              ),
            ),
            // 开始按钮
            Positioned(
              bottom: 80,
              child: SizedBox(
                width: 80,
                height: 80,
                child: ElevatedButton(
                  onPressed: () {
                  },
                  child: Text(""),
                ),
              ),
            ),
            Positioned(
              top: largeWheelSize / 2 +
                  180 +
                  (smallWheelSize / 2) -
                  (80 / 2), // 开始按钮位于小转盘中心
              child: TextButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         HexagramDetailPage(hexagram: Xiang
                  //             .getXiangByYaoList(guaList)),
                  //   ),
                  // );
                },
                child: Text(
                  // guaList.length >= 2 ? Xiang
                  //   .getXiangByYaoList(guaList)
                  //   .getGuaProps()
                  //   .fullName :
                  '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
