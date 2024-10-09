import 'package:ac_storage/operation/database_helper.dart';
import 'package:ac_widget/widget/input/simple_input.dart';
import 'package:flutter/material.dart';

///  题目id 创建时间  类型 题目 答案
class InputQuestion extends StatefulWidget {
  const InputQuestion({super.key});

  @override
  State<InputQuestion> createState() => _InputQuestionState();
}

class _InputQuestionState extends State<InputQuestion> {
  String topics = '''
CREATE TABLE IF NOT EXISTS topics (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  answer TEXT UNIQUE NOT NULL,
  type TEXT NOT NULL,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
)
''';

  @override
  void initState() {
    // db();
    super.initState();
  }
  //
  // Future<void> db() async {
  //   var db = await DatabaseHelper().database;
  //   db.execute(topics);
  //   print(db.path);
  // }

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
              Text('题目'),
              Expanded(
                child: SimpleInput(
                  controller: TextEditingController(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text('题目'),
              Expanded(
                child: SimpleInput(
                  controller: TextEditingController(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text('题目'),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '用户名',
                    // 默认边框
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                        width: 2.0,
                      ),
                    ),
                    // 启用但未聚焦时的边框
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                        width: 2.0,
                      ),
                    ),
                    // 获取焦点时的边框
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                        width: 2.0,
                      ),
                    ),
                    // 错误状态下的边框
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                        width: 2.0,
                      ),
                    ),
                    // 获取焦点且错误状态下的边框
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                        width: 2.0,
                      ),
                    ),
                  ),
                )
              ),
            ],
          ),

        ],
      ),
    );
  }
}
