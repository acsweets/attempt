import 'package:flutter/material.dart';

class Article extends StatefulWidget {
  const Article({super.key});

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Router(
        routerDelegate: MyDelegate(),
      ),
    );
  }
}

class MyDelegate extends RouterDelegate with ChangeNotifier {
  //2.0本质是操作pages
  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        // MaterialPage(child: HomePage()),
      ],
    );
  }

  @override
  Future<bool> popRoute() {
    return Future.value(true);
  }

  @override
  Future<void> setNewRoutePath(configuration) async {
    print("");
  }
}
