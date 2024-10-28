import 'package:flutter/material.dart';

import '../../model/task.dart';

/// 加一个倒计时，打卡，开始上班了 距离下班还有XX：XX 多久  《自己设置》
///

//分页查询
class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  //
  // void _scrollToTop() {
  //   _scrollController.animateTo(
  //     0,
  //     duration: Duration(milliseconds: 300),
  //     curve: Curves.easeInOut,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 200,
            child: ListView.builder(
              // controller: _scrollController,
              itemCount: 30, // 多一项用于显示加载指示器
              itemBuilder: (context, index) {
                // 显示任务列表项
                return Container();
              },
            ),
          ),
          // 回到顶部按钮
          // Positioned(
          //   bottom: 20,
          //   right: 20,
          //   child: FloatingActionButton(
          //     onPressed: _scrollToTop,
          //     child: Icon(Icons.arrow_upward),
          //   ),
          // ),
        ],
      ),
    );
  }


  /// 标题，状态  类型 时间 描述
  Widget itemTask(Task task) {
    return Column(
      children: [
        Text(task.title),
        if (task.describe != null) Text('${task.describe}'),
        Row(
          children: [
            ///状态

            ///时间
            Text(task.data.toString()),
          ],
        ),
      ],
    );
  }
}

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  List<String> tasks = [];
  int limit = 20; // 每次加载的数据条数
  int offset = 0; // 当前偏移量
  bool isLoading = false; // 是否正在加载
  final ScrollController _scrollController = ScrollController(); // 控制滚动的控制器

  @override
  void initState() {
    super.initState();
    loadMoreTasks(); // 初次加载
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // 当用户滚动到页面底部时，加载更多数据
        loadMoreTasks();
      }
    });
  }

  Future<void> loadMoreTasks() async {
    if (isLoading) return; // 如果已经在加载中，避免重复加载
    setState(() {
      isLoading = true; // 设置加载中状态
    });

    // 模拟异步数据获取
    await Future.delayed(const Duration(seconds: 2));

    // 假设我们每次加载 10 条任务
    List<String> newTasks =
        List.generate(limit, (index) => 'Task ${(offset + index + 1)}');
    setState(() {
      tasks.addAll(newTasks); // 添加新的任务到现有列表中
      offset += limit; // 更新偏移量
      isLoading = false; // 重置加载状态
    });
  }

  Future<void> _refreshTasks() async {
    setState(() {
      tasks.clear(); // 刷新时先清空任务列表
      offset = 0; // 重置偏移量
    });
    await loadMoreTasks(); // 重新加载数据
  }

  @override
  void dispose() {
    _scrollController.dispose(); // 清理 ScrollController 资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshTasks, // 设置下拉刷新的回调函数
        child: ListView.builder(
          controller: _scrollController, // 绑定 ScrollController
          itemCount: tasks.length + 1, // 加 1 用于显示加载指示器
          itemBuilder: (context, index) {
            if (index == tasks.length) {
              // 显示加载更多的指示器
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: isLoading
                      ? const CircularProgressIndicator() // 显示加载指示器
                      : const SizedBox(), // 如果没有加载中，显示空
                ),
              );
            }

            // 显示任务列表项
            return ListTile(
              title: Text(tasks[index]),
            );
          },
        ),
      ),
    );
  }
}
