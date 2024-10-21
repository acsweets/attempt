class Task {
  final String title;
  final DateTime data;
  final String status;
  final bool repeat;

  Task({
    required this.title,
    required this.data,
    required this.status,
    required this.repeat,
  });

  factory Task.formMap(Map<String, dynamic> map) {
    return Task(
        title: '',
        data: DateTime.fromMicrosecondsSinceEpoch(1),
        status: '',
        repeat: false);
  }
}
