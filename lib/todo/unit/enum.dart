enum TodoState {
  beOverdue('beOverdue'), //过期
  pending('pending'), //进行中
  completed('completed'); //完成

  final String name;

  const TodoState(this.name);

  static TodoState fromString(String name) {
    return TodoState.values.firstWhere(
          (e) => e.name == name,
      orElse: () => throw ArgumentError('No matching TodoState for name: $name'),
    );
  }
}
