import 'dart:io';
import 'package:args/args.dart';
import 'package:path/path.dart' as p;

/// 定义可用的命令
enum Command { create, write, read, delete, help }

/// 映射命令字符串到 [Command] 枚举
Command? parseCommand(String? cmd) {
  switch (cmd?.toLowerCase()) {
    case 'create':
      return Command.create;
    case 'write':
      return Command.write;
    case 'read':
      return Command.read;
    case 'delete':
      return Command.delete;
    case 'help':
      return Command.help;
    default:
      return null;
  }
}

Future<void> main(List<String> arguments) async {
  // 定义 ArgParser
  final parser = ArgParser()
    ..addCommand('create')
    ..addCommand('write')
    ..addCommand('read')
    ..addCommand('delete')
    ..addFlag('help', abbr: 'h', negatable: false, help: '显示帮助信息');

  // 解析参数
  ArgResults argResults;
  try {
    argResults = parser.parse(arguments);
  } catch (e) {
    print('参数解析错误: $e');
    printUsage(parser);
    exit(64); // Exit code 64表示命令行使用错误
  }

  // 如果请求帮助，则显示帮助信息
  if (argResults['help'] as bool) {
    printUsage(parser);
    return;
  }

  // 获取命令
  final commandName = argResults.command?.name;
  final command = parseCommand(commandName);

  if (command == null) {
    print('未指定有效的命令。');
    printUsage(parser);
    exit(64);
  }

  // 根据命令执行相应操作
  switch (command) {
    case Command.create:
      await handleCreate(argResults.command!);
      break;
    case Command.write:
      await handleWrite(argResults.command!);
      break;
    case Command.read:
      await handleRead(argResults.command!);
      break;
    case Command.delete:
      await handleDelete(argResults.command!);
      break;
    case Command.help:
      printUsage(parser);
      break;
  }
}

/// 打印使用说明
void printUsage(ArgParser parser) {
  print('''
Dart 文件操作脚本

用法:
  dart run bin/main.dart <command> [options]

命令:
  create    创建一个新文件。
  write     向文件写入内容。
  read      读取文件内容。
  delete    删除文件。
  help      显示帮助信息。

选项:
  -h, --help    显示帮助信息。

命令详细信息:

1. 创建文件:
   dart run bin/main.dart create --path <文件路径>

   示例:
     dart run bin/main.dart create --path /path/to/file.txt

2. 写入文件:
   dart run bin/main.dart write --path <文件路径> --content <内容>

   示例:
     dart run bin/main.dart write --path /path/to/file.txt --content "Hello, Dart!"

3. 读取文件:
   dart run bin/main.dart read --path <文件路径>

   示例:
     dart run bin/main.dart read --path /path/to/file.txt

4. 删除文件:
   dart run bin/main.dart delete --path <文件路径>

   示例:
     dart run bin/main.dart delete --path /path/to/file.txt
''');
}

/// 处理创建文件命令
Future<void> handleCreate(ArgResults cmd) async {
  final path = cmd['path'] as String?;

  if (path == null) {
    print('错误: 创建文件需要 --path 参数。');
    return;
  }

  final filePath = p.normalize(path);
  final file = File(filePath);

  try {
    if (await file.exists()) {
      print('文件已存在: ${file.path}');
    } else {
      await file.create(recursive: true);
      print('成功创建文件: ${file.path}');
    }
  } catch (e) {
    print('创建文件时出错: $e');
  }
}

/// 处理写入文件命令
Future<void> handleWrite(ArgResults cmd) async {
  final path = cmd['path'] as String?;
  final content = cmd['content'] as String?;

  if (path == null || content == null) {
    print('错误: 写入文件需要 --path 和 --content 参数。');
    return;
  }

  final filePath = p.normalize(path);
  final file = File(filePath);

  try {
    if (!await file.exists()) {
      await file.create(recursive: true);
      print('文件不存在，已创建新文件: ${file.path}');
    }

    await file.writeAsString(content, mode: FileMode.write);
    print('成功写入内容到文件: ${file.path}');
  } catch (e) {
    print('写入文件时出错: $e');
  }
}

/// 处理读取文件命令
Future<void> handleRead(ArgResults cmd) async {
  final path = cmd['path'] as String?;

  if (path == null) {
    print('错误: 读取文件需要 --path 参数。');
    return;
  }

  final filePath = p.normalize(path);
  final file = File(filePath);

  try {
    if (!await file.exists()) {
      print('文件不存在: ${file.path}');
      return;
    }

    final contents = await file.readAsString();
    print('文件内容 (${file.path}):\n$contents');
  } catch (e) {
    print('读取文件时出错: $e');
  }
}

/// 处理删除文件命令
Future<void> handleDelete(ArgResults cmd) async {
  final path = cmd['path'] as String?;

  if (path == null) {
    print('错误: 删除文件需要 --path 参数。');
    return;
  }

  final filePath = p.normalize(path);
  final file = File(filePath);

  try {
    if (!await file.exists()) {
      print('文件不存在: ${file.path}');
      return;
    }

    // 确认删除
    stdout.write('确定要删除文件 "${file.path}" 吗？(y/n): ');
    String? response = stdin.readLineSync();

    if (response != null && response.toLowerCase() == 'y') {
      await file.delete();
      print('成功删除文件: ${file.path}');
    } else {
      print('取消删除文件。');
    }
  } catch (e) {
    print('删除文件时出错: $e');
  }
}
