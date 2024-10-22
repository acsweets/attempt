import 'package:attempt/todo/db/app_db.dart';
import 'package:flutter/material.dart';


class CreateTodoPage extends StatefulWidget {
  const CreateTodoPage({super.key});

  @override
  State<CreateTodoPage> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('创建任务'),
      // ),
      body: Column(
        children: [
          ///标题，是否必传，提示文字 横纵布局 默认横向 描述
          Text(''),

          ///时间选择组件
          Container(
            color: Colors.white,
            height: 100,
            child: const TextField(
              style: TextStyle(fontSize: 14),
              cursorWidth: 1,
              expands: true,
              maxLines: null,
              decoration: InputDecoration(
                isCollapsed: true,
                //无边框
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),

          ///下拉框
          ///按钮  风格一直
          TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                foregroundColor: Colors.white,
                elevation: 2,
                shadowColor: Colors.orangeAccent),
            child: const Text('提交'),
            onPressed: () => submit(),
          ),
        ],
      ),
    );
  }

  Future<void> submit() async {
    print('插入数据');
    AppDB().insertTask({
      'title': '学英语',
      'dueDate': '2024-10-21',
      'isRecurring': 1,
      'status': 'pending'
    });
    // List task = await AppDB().getAllTasks();
    // print(task);
  }
}

///import 'package:flutter/material.dart';
//
// /// create by 张风捷特烈 on 2020/9/21
// /// contact me by email 1981462002@qq.com
//
//
// class TextButtonStyleDemo extends StatelessWidget {
//   const TextButtonStyleDemo({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       child: Wrap(
//         spacing: 10,
//         children: [
//           TextButton(
//             style: TextButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 foregroundColor: Colors.white,
//                 elevation: 2,
//                 shadowColor: Colors.orangeAccent),
//             child: const Text('TextButton 样式'),
//             onPressed: _onPressed,
//             onLongPress: _onLongPress,
//           ),
//           TextButton(
//             style: TextButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 foregroundColor: Colors.black,
//                 side: const BorderSide(color: Colors.blue, width: 1),
//                 shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                 // elevation: 2,
//                 shadowColor: Colors.orangeAccent),
//             child: const Text('TextButton 边线'),
//             autofocus: false,
//             onPressed: _onPressed,
//             onLongPress: _onLongPress,
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _onPressed() {}
//
//   void _onLongPress() {}
// }
