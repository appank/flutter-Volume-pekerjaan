import 'package:sqflite/sqflite.dart' as sql;

class SQLHaleper {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE data(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      db_title TEXT,
      db_panjang TEXT,
      db_lebar TEXT,
      db_tinggi TEXT,
      db_satuan TEXT,
      db_jumlah INTEGER,
      createAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase("database_name.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    });
  }

  static Future<int> createData(
      String DB_title,
      String? DB_panjang,
      String? DB_lebar,
      String? DB_tinggi,
      String? DB_satuan,
      int DB_jumlah) async {
    final db = await SQLHaleper.db();
    final data = {
      'db_title': DB_title,
      'db_panjang': DB_panjang,
      'db_lebar': DB_lebar,
      'db_tinggi': DB_tinggi,
      'db_satuan': DB_satuan,
      'db_jumlah': DB_jumlah
    };
    final id = await db.insert('data', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await SQLHaleper.db();
    return db.query('data', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getString(int id) async {
    final db = await SQLHaleper.db();
    return db.query('data', where: "id = ? ", whereArgs: [id], limit: 1);
  }

  // static Future<int> updateData(int id, String title, String? desc) async {
  //   final db = await SQLHaleper.db();
  //   final data = {
  //     'title': title,
  //     'desc': desc,
  //     'createAt': DateTime.now().toString()
  //   };
  //   final result =
  //       await db.update('data', data, where: "id = ?", whereArgs: [id]);
  //   return result;
  // }

  static Future<void> deletData(int id) async {
    final db = await SQLHaleper.db();
    try {
      await db.delete('data', where: " id= ?", whereArgs: [id]);
    } catch (e) {}
  }
}
