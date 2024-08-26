import 'package:flutter/material.dart';
import '../../fun_attempt.dart';

class SelectableItemsScreen extends StatefulWidget {
  const SelectableItemsScreen({super.key});

  @override
  createState() => _SelectableItemsScreenState();
}

class _SelectableItemsScreenState extends State<SelectableItemsScreen> {
  late final CascadableMultipleValueNotifier<String> _selectedItemsNotifier;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    _selectedItemsNotifier = CascadableMultipleValueNotifier<String>(
      <String>{},
      dataSource: StaticOptionsProvider<String>([
        "数据一",
        "数据二",
      ]),
    )..attachToAnimatedList(_listKey, _buildRemovedItem);
  }

  @override
  void dispose() {
    _selectedItemsNotifier.dispose();
    super.dispose();
  }

  Widget _buildRemovedItem(
      BuildContext context, String item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: ListTile(
        title: Text(item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selectable Items'),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: _selectedItemsNotifier.clearSet,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _selectedItemsNotifier.value.length,
              itemBuilder: (context, index, animation) {
                final item = _selectedItemsNotifier.value.elementAt(index);
                return SizeTransition(
                  sizeFactor: animation,
                  child: ListTile(
                    title: Text(item),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () => _selectedItemsNotifier.remove(item),
                    ),
                  ),
                );
              },
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (
                  c,
                ) {
                  return CategorySelectionScreen();
                }));
              },
              child: Text("跳转")),
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (
                  c,
                ) {
                  return AnimatedListExample();
                }));
              },
              child: Text("跳转AnimatedListExample")),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              children: ['Apple', 'Banana', 'Orange', 'Grapes', 'Mango']
                  .map((item) => ChoiceChip(
                        label: Text(item),
                        selected: _selectedItemsNotifier.value.contains(item),
                        onSelected: (selected) {
                          if (selected) {
                            _selectedItemsNotifier.add(item);
                          } else {
                            _selectedItemsNotifier.remove(item);
                          }
                        },
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
