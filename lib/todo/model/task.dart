import '../unit/enum.dart';

class Task {
  final int? id;
  final String title;
  final String? describe;
  final String data;
  final TodoState status;
  final bool repeat;

  Task({
    this.id,
    this.describe,
    required this.title,
    required this.data,
    required this.status,
    required this.repeat,
  });

  factory Task.formMap(Map<String, dynamic> map) {
    return Task(
        id: map['id'],
        title: map['title'],
        data: map['data'],
        status: TodoState.fromString(map['status']),
        describe: map['describe'],
        repeat: analysisNumber(map['repeat']));
  }

  Map toJson() => {
        'id': id,
        'title': title,
        'data': data.toString(),
        'status': status,
        'repeat': repeat ? 1 : 0,
        'describe': describe
      };

  static bool analysisNumber(int number) {
    if (number == 1) {
      return true;
    }
    return false;
  }

  static int  analysisInt(bool boer) {
    if (boer) {
      return 1;
    } else {
      return 0;
    }
  }

}
