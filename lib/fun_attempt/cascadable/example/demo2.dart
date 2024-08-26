import 'package:flutter/material.dart';
import '../../fun_attempt.dart';


class CategorySelectionScreen extends StatefulWidget {
  const CategorySelectionScreen({super.key});

  @override
   createState() => _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  late CascadableValueNotifier<String> categoryNotifier;
  late CascadableMultipleValueNotifier<String> subCategoryNotifier;

  @override
  void initState() {
    super.initState();

    categoryNotifier = CascadableValueNotifier<String>(
      null,
      dataSource: StaticOptionsProvider<String>(['Category 1', 'Category 2']),
    );

    subCategoryNotifier = CascadableMultipleValueNotifier<String>(
      <String>{},
      dataSource: AsyncOptionsProvider<String>(
        dataBuilder: () async {
          // 模拟异步加载子类别数据
          return Future.delayed(
            Duration(milliseconds: 300),
                () => ['Subcategory 1', 'Subcategory 2'],
          );
        },
      ),
    );

    // 添加子级通知器到父级通知器
    categoryNotifier.addChild(subCategoryNotifier);
  }

  @override
  void dispose() {
    categoryNotifier.dispose();
    subCategoryNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Selection'),
      ),
      body: Column(
        children: [
          ValueListenableBuilder<String?>(
            valueListenable: categoryNotifier,
            builder: (context, category, _) {
              return DropdownButton<String>(
                hint: Text('Select Category'),
                value: category,
                items: categoryNotifier.dataSource
                    .getDataSync()!
                    .map((cat) => DropdownMenuItem<String>(
                  value: cat,
                  child: Text(cat),
                ))
                    .toList(),
                onChanged: (value) {
                  categoryNotifier.value = value;
                },
              );
            },
          ),
          Expanded(
            child: ValueListenableBuilder<Set<String>?>(
              valueListenable: subCategoryNotifier,
              builder: (context, subCategories, _) {
                if (subCategories == null || subCategories.isEmpty) {
                  return const Center(child: Text('No subcategories available'));
                }
                return ListView(
                  children: subCategories
                      .map((subCategory) => ListTile(
                    title: Text(subCategory),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () {
                        subCategoryNotifier.remove(subCategory);
                      },
                    ),
                  ))
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
