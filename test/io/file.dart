import 'dart:io';
import 'package:path/path.dart' as p;
import 'dart:convert';

// Future<void> main() async {
//   // 定义文件路径
//
//
//   const filePath = 'example.txt';
//   final file = File(filePath);
//
//   // 1. 创建文件并写入内容
//   await createAndWriteFile(file);
//
//   // 2. 读取文件内容
//   final content = await readFile(file);
//
//   // 3. 分析文件数据
//   analyzeData(content);
// }

Future<void> main() async {
  // 定义目标目录路径
  // final directoryPath = getTargetDirectoryPath();

  final directoryPath = dataPath();

  final directory = Directory(directoryPath);

  // 1. 创建目录（如果不存在）
  await createDirectory(directory);

  // 定义文件路径（在目标目录中）
  final filePath = p.join(directoryPath, 'example.txt');
  final file = File(filePath);
  final codePath = p.join(Directory.current.path, 'lib', 'http', 'http.dart');
  final codeFile = File(codePath);

  // 2. 创建文件并写入内容
  await createAndWriteFile(file);

  // 3. 读取文件内容
  // final content = await readFile(file);
  final content = await readFile(codeFile);
  print(content);

  // 4. 分析文件数据
  // analyzeData(content);
}

// 获取目标目录的绝对路径
String getTargetDirectoryPath() {
  // 示例：在用户主目录下创建一个名为 'dart_files' 的目录
  // 您可以根据需要修改此路径
  final homeDir = Platform.isWindows
      ? Platform.environment['USERPROFILE']
      : Platform.environment['HOME'];

  if (homeDir == null) {
    throw Exception('无法获取用户主目录');
  }

  return p.join(homeDir, 'dart_files');
}

//在项目的下创建一个 assets中创建一个 datas 的目录
String dataPath() {
  Directory current = Directory.current;
  String target = p.join(current.path, 'assets', 'data');
  return target;
}

// 创建目录（如果不存在）
Future<void> createDirectory(Directory directory) async {
  try {
    if (!await directory.exists()) {
      //recursive 递归创建
      await directory.create(recursive: true);
      print('目录已创建: ${directory.path}');
    } else {
      print('目录已存在: ${directory.path}');
    }
  } catch (e) {
    print('创建目录时出错: $e');
  }
}

// 创建文件并写入内容
Future<void> createAndWriteFile(File file) async {
  try {
    // 检查文件是否存在，如果不存在则创建
    if (!await file.exists()) {
      await file.create();
      print('文件已创建: ${file.path}');
    } else {
      print('文件已存在: ${file.path}');
    }

    // 要写入的数据
    String data = '''
    Dart 是一种由 Google 开发的编程语言。
    它主要用于构建移动、桌面、服务器和 Web 应用程序。
    Dart 支持面向对象的编程和异步编程。
    ''';

    // 写入数据到文件（覆盖模式）
    await file.writeAsString(data);
    print('数据已写入文件。');
  } catch (e) {
    print('写入文件时出错: $e');
  }
}

// 读取文件内容
Future<String> readFile(File file) async {
  try {
    String contents = await file.readAsString();
    print('文件内容读取成功。$contents');
    return contents;
  } catch (e) {
    print('读取文件时出错: $e');
    return '';
  }
}

// 分析数据（例如，统计单词数量）
void analyzeData(String data) {
  if (data.isEmpty) {
    print('没有数据可分析。');
    return;
  }

  // 使用正则表达式分割单词
  List<String> words = data
      .replaceAll(RegExp(r'[^\w\s]'), '') // 移除标点符号
      .toLowerCase()
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty)
      .toList();

  // 统计单词数量
  int wordCount = words.length;
  print('总单词数: $wordCount');

  // 统计每个单词出现的次数
  Map<String, int> wordFrequency = {};
  for (var word in words) {
    wordFrequency[word] = (wordFrequency[word] ?? 0) + 1;
  }

  print('单词频率:');
  wordFrequency.forEach((key, value) {
    print('$key: $value');
  });
}

Future<void> deleteFileWithConfirmation(File file) async {
  try {
    if (await file.exists()) {
      stdout.write('确定要删除文件 ${file.path} 吗？(y/n): ');
      String? response = stdin.readLineSync();

      if (response != null && response.toLowerCase() == 'y') {
        await file.delete();
        print('成功删除文件: ${file.path}');
      } else {
        print('取消删除文件。');
      }
    } else {
      print('文件不存在: ${file.path}');
    }
  } catch (e) {
    print('删除文件时出错: $e');
  }
}