import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widget/widget.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          tabs: [
            Text("1"),
            Text("2"),
          ],
          controller: _controller,
          onTap: (index) {
            switch (index) {
              case 0:
                context.go("/two");
                break;
              case 1:
                context.go("/sth");

                break;
            }
          },
          isScrollable: true,
          indicatorColor: Colors.blue,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorWeight: 3,
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 14),
          overlayColor: ButtonStyle(
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.hovered))
                  return Colors.yellow.withOpacity(0.2);
                if (states.contains(WidgetState.focused))
                  return Colors.red.withOpacity(0.2);
                if (states.contains(WidgetState.pressed))
                  return Colors.blue.withOpacity(0.3);
                return null;
              },
            ),
          ).overlayColor,
          splashFactory: InkSparkle.splashFactory,
        ),
      ),
      body: Column(
        children: [
          // SizedBox(
          //   height: 200,
          // ),
          // BaseButton(),
          SizedBox(
            width: 200,
            height: 200,
            child: CircleAnimation(),
          )
        ],
      ),
    );
  }
}





