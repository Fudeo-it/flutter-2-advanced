import 'package:sqlite/model/todo_model.dart';
import 'package:path/path.dart' as path;

import 'package:sqflite/sqflite.dart';

class TodoRepository {
  late Database database;

  Future<void> initialize() async {
    final databasesPath = await getDatabasesPath();
    final dbPath = path.join(databasesPath, "todos.db");

    database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute("""
        CREATE TABLE todos(
          id INTEGER PRIMARY KEY,
          text TEXT
        );
      """);
      },
    );
  }

  Future<List<TodoModel>> all() async {
    final records = await database.query("todos");
    return records.map((record) => TodoModel.fromRecord(record)).toList();
  }

  Future<TodoModel> create(String todo) async {
    final id = await database.insert("todos", {
      "text": todo,
    });

    return TodoModel(
      id: id,
      text: todo,
    );
  }

  Future<void> delete(TodoModel todo) async {
    await database.delete("todos", where: "id = ?", whereArgs: [todo.id]);
  }
}
