import 'package:ac_tools/ac_tools.dart';
import 'package:attempt/main.dart';
import 'package:attempt/todo/db/app_db.dart';
import 'package:attempt/todo/pages/create/page.dart';
import 'package:attempt/todo/pages/list/page.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../animation/card_switch/card.dart';
import '../animation/card_switch/pageview.dart';
import '../animation/card_switch/switch.dart';
import '../draw/line.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  await AppDB().initDatabase();
  HttpManger.instance
      .init('http://yijuzhan.com', interceptors: [OptionInterceptor( ),ResponseInterceptors()]);
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
      builder: BotToastInit(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('我的日常任务'),
        ),
        body:  SwitchCard(),
      ),
    );
  }
}
