import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLHelper {
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'pickup_requests.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE pickups (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            address TEXT,
            contact TEXT,
            date TEXT
          )
        ''');
      },
    );
  }

  static Future<int> insertPickup(Map<String, dynamic> data) async {
    final db = await getDatabase();
    return await db.insert('pickups', data);
  }

  static Future<List<Map<String, dynamic>>> getPickups() async {
    final db = await getDatabase();
    return await db.query('pickups');
  }
}
