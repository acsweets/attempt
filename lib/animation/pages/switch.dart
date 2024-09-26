import 'package:flutter/material.dart';

class SwitchDemo extends StatefulWidget {
  const SwitchDemo({super.key});

  @override
  State<SwitchDemo> createState() => _SwitchDemoState();
}

class _SwitchDemoState extends State<SwitchDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('转换动画'),
      ),
      body: Column(
        children: [
          Container(
            child: AnimatedSwitcher(duration: Duration(seconds: 2)
            ,child: Container(),),
          )
        ],
      ),
    );
  }
}
