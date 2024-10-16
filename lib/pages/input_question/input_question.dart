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
          // FollowPopup(
          //   width: 100,
          //   height: 100,
          //   child: Container(
          //     padding: EdgeInsets.all(10),
          //     color: Colors.blueGrey,
          //     child: Text('111'),
          //   ),
          // follow: Container(
          //   height: 100,
          //   width: 100,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       color: Colors.white,
          //       border: Border.all(color: Colors.black)),
          // ),
          // ),
          // Row(
          //   children: [
          //     Text('题目'),
          //     Expanded(
          //       child: SimpleInput(
          //         controller: TextEditingController(),
          //       ),
          //     ),
          //   ],
          // ),

          // const SizedBox(
          //   height: 300,
          //   width: 200,
          //   child: AcLine(),
          // )
        ],
      ),
    );
  }
}

