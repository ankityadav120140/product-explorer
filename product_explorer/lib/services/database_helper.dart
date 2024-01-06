import 'package:product_explorer/local/model/local_available_sizes_table.dart';
import 'package:product_explorer/local/model/local_product_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? database;

  DatabaseHelper._();

  Future<Database> get fetchDatabase async {
    if (database != null) return database!;
    database = await _initDB('mydb.db');
    return database!;
  }

  bool get isDatabaseInitialized => database != null;

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = "$dbPath/$filePath";
    return await openDatabase(path,
        version: 1, onCreate: _createDB, onConfigure: _onConfigure);
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _createDB(Database db, int version) async {
    await createProductTable(db);
    await createAvailableSizesTable(db);
  }
}
