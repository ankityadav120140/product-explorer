import 'package:sqflite/sqflite.dart';

Future<void> createAvailableSizesTable(Database db) async {
  await db.execute('''
      CREATE TABLE AvailableSizes (
        product_id INTEGER,
        size TEXT
      )
    ''');
}
