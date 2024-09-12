import 'dart:math';

import 'package:flutter/material.dart';

import '../../utils/config.dart';

class RandomNamePage extends StatefulWidget {
  const RandomNamePage({super.key});

  @override
  State<RandomNamePage> createState() => _RandomNamePageState();
}

class _RandomNamePageState extends State<RandomNamePage> {
  String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('随机名字'),
      ),
      body: Column(
        children: [
          SelectableText(
            showCursor: true,
            name ?? '随机一下试试把',
            style: TextStyle(color: name != null ? Colors.blue : Colors.grey),
          ),
          TextButton(onPressed: randomName, child: Text('随机名字'))
        ],
      ),
    );
  }

  final Random random = Random();

  void randomName() {
    int num = random.nextInt(Config.names.length - 1);
    name = Config.names[num];
    setState(() {});
  }
}
