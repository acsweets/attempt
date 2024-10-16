import 'dart:io';

void main() {
  stdoutUse();
}

// 删除文件前的用户确认
Future<void> stdoutUse() async {
  try {
    stdout.write('确定要删除文件 吗？(y/n): ');
    String? response = stdin.readLineSync();

    if (response != null && response.toLowerCase() == 'y') {
      print('成功删除文件: ');
    } else {
      print('取消删除文件。');
    }
  } catch (e) {
    print('删除文件时出错: $e');
  }
}
