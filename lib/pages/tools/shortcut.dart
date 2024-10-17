import 'package:ac_widget/widget/input/shortcut_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JumpToInter extends Intent {
  const JumpToInter();
}

class NextInter extends Intent {
  const NextInter();
}

class PreviousInter extends Intent {
  const PreviousInter();
}
//快捷键的案例
class ShortcutPage extends StatefulWidget {
  const ShortcutPage({super.key});

  @override
  State<ShortcutPage> createState() => _ShortcutPageState();
}

class _ShortcutPageState extends State<ShortcutPage> {
  int _selectedIndex = -1;
  final List<String> _options = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 5',
  ];

  // 方法：选择上一个选项
  void _selectPrevious() {
    setState(() {
      if (_selectedIndex > 0) {
        _selectedIndex--;
      }
    });
  }

  // 方法：选择下一个选项
  void _selectNext() {
    setState(() {
      if (_selectedIndex < _options.length - 1) {
        _selectedIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('快捷键案例'),
      ),
      body: Column(
        children: [
          const Text('Ctrl + D: 跳转到目标页面'),
          SizedBox(
            width: double.infinity,
            height: 200,
            child: ShortcutKey(
              shorts: [
                ShortData(
                    callback: (Intent intent) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const DestinationPage()),
                      );
                      return null;
                    },
                    intent: const JumpToInter(),
                    singleActivator: const SingleActivator(
                      LogicalKeyboardKey.keyD,
                      control: true,
                    )),
                ShortData(
                    callback: (i) => _selectPrevious(),
                    intent: const PreviousInter(),
                    singleActivator:
                        const SingleActivator(LogicalKeyboardKey.arrowUp)),
                ShortData(
                    callback: (Intent intent) => _selectNext(),
                    intent: const NextInter(),
                    singleActivator:
                        const SingleActivator(LogicalKeyboardKey.arrowDown)),
              ],
              child: Container(
                height: 200,
                width: 200,
                color: Colors.blueGrey,
              ),
            ),
          ),
          Text('↑ / ↓: 导航选项'),
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: _options.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_options[index]),
                  selected: index == _selectedIndex,
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 目标页面
class DestinationPage extends StatelessWidget {
  const DestinationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 使用 AppBar 以便用户可以通过返回按钮返回上一页
      appBar: AppBar(
        title: const Text('目标页面'),
      ),
      body: const Center(
        child: Text(
          '你已经跳转到目标页面！',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
