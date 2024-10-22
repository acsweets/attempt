class Task {
  final int? id;
  final String title;
  final DateTime data;
  final String status;
  final bool repeat;

  Task({
    this.id,
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
        status: '',
        repeat: false);
  }

  Map toJson() => {
        'id': id,
        'title': title,
        'data': data.toString(),
        'status': status,
        'repeat': repeat ? 1 : 0,
      };
}
