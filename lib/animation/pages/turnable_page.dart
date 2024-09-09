import 'package:flutter/material.dart';

import '../widget/turntable.dart';

class TurntablePage extends StatefulWidget {
  const TurntablePage({super.key});

  @override
  State<TurntablePage> createState() => _TurntablePageState();
}

class _TurntablePageState extends State<TurntablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('八卦转盘'),
      ),
      body:  Column(
        children: [
          SizedBox(height: 10,),
          BaGuaWheelController(size: 200, controller: BaGuaController(),),


        ],
      ),
    );
  }
}
