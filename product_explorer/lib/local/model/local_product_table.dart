import 'package:sqflite/sqflite.dart';

Future<void> createProductTable(Database db) async {
  await db.execute('''
      CREATE TABLE IF NOT EXISTS products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        Brand TEXT,
        Gender TEXT,
        Theme TEXT,
        Category TEXT,
        SubCategory TEXT,
        Name TEXT,
        Color TEXT,
        Option TEXT,
        MRP REAL,
        Collection TEXT,
        Fit TEXT,
        Description TEXT,
        QRCode TEXT,
        OfferMonths TEXT,
        Finish TEXT,
        ImageUrl TEXT,
        ImageUrl2 TEXT,
        ImageUrl3 TEXT,
        ImageUrl4 TEXT,
        ImageUrl5 TEXT,
        MaxQuantity INTEGER,
        TechnologyImageUrl TEXT
      )
    ''');
}
