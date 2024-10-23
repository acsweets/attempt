import '../unit/enum.dart';

class Task {
  final int? id;
  final String title;
  final String? describe;
  final DateTime data;
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
        id: 0,
        title: '',
        data: DateTime.fromMicrosecondsSinceEpoch(1),
        status: TodoState.fromString(map['status']),
        describe: map['map'],
        repeat: false);
  }

  Map toJson() => {
        'id': id,
        'title': title,
        'data': data.toString(),
        'status': status,
        'repeat': repeat ? 1 : 0,
        'describe': describe
      };
}
