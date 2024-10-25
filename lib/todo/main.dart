import 'package:attempt/main.dart';
import 'package:attempt/todo/db/app_db.dart';
import 'package:attempt/todo/pages/create/page.dart';
import 'package:attempt/todo/pages/list/page.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../draw/3d/ball.dart';
import '../draw/glsl/shade.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  await AppDB().initDatabase();
  runApp(const TodoApp());
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('todo'),

        ),
        body: WarpCounterWidget(),
      ),

    );
  }
}
