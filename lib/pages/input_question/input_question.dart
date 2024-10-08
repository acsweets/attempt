import 'package:flutter/material.dart';

///  题目id 创建时间  类型 题目 答案
class InputQuestion extends StatefulWidget {
  const InputQuestion({super.key});

  @override
  State<InputQuestion> createState() => _InputQuestionState();
}

class _InputQuestionState extends State<InputQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('录入题目'),
      ),
      body: Column(
        children: [
          Row(
            children: [


            ],
          ),
          Row(
            children: [


            ],
          ),
        ],
      ),
    );
  }
}
