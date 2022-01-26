import 'package:persistenza_dati/model/saved_quote_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class SavedQuotesRepository {
  late Database database;

  Future<void> initialize() async {
    final databasesPath = await getDatabasesPath();
    final dbPath = path.join(databasesPath, 'persistenza_dati.db');

    database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("""
        CREATE TABLE saved_quotes(
          id INTEGER PRIMARY KEY,
          text TEXT NOT NULL
        );
      """);
      },
    );
  }

  Future<List<SavedQuoteModel>> all() async {
    final rows = await database.query("saved_quotes");
    return rows.map((row) => SavedQuoteModel.fromRecord(row)).toList();
  }

  Future<SavedQuoteModel> create(String text) async {
    final id = await database.insert("saved_quotes", {
      "text": text,
    });

    return SavedQuoteModel(
      id: id,
      text: text,
    );
  }

  Future<void> delete(SavedQuoteModel savedQuoteModel) async {
    await database.delete(
      "saved_quotes",
      where: "id = ?",
      whereArgs: [savedQuoteModel.id],
    );
  }
}
