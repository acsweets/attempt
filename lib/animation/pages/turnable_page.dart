import 'package:flutter/material.dart';

import '../widget/turntable.dart';

class TurntablePage extends StatefulWidget {
  const TurntablePage({super.key});

  @override
  State<TurntablePage> createState() => _TurntablePageState();
}

class _TurntablePageState extends State<TurntablePage> {
  final GlobalKey<BaGuaWheelState> ba1GuaKey = GlobalKey<BaGuaWheelState>();
  final GlobalKey<BaGuaWheelState> ba2GuaKey = GlobalKey<BaGuaWheelState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('八卦转盘'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: BaGuaWheel(
              key: ba1GuaKey,
              size: 200,
              onComplete: (gua) {
                print('选中的卦：${gua.name}');
                ba2GuaKey.currentState?.startAnimation();
              },
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: BaGuaWheel(
              key: ba2GuaKey,
              size: 100,
              onComplete: (gua) {
                print('选中的卦：${gua.name}');
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
                ba1GuaKey.currentState?.startAnimation();
              },
              child: Text('启动')),
        ],
      ),
    );
  }
}
