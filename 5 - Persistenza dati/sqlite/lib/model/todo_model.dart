class TodoModel {
  final int id;
  final String text;

  const TodoModel({
    required this.id,
    required this.text,
  });

  factory TodoModel.fromRecord(Map<String, dynamic> data) {
    final id = data["id"] as int;
    final text = data["text"] as String;

    return TodoModel(
      id: id,
      text: text,
    );
  }
}
