import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "deencircle.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE user(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            phone TEXT
          )
        ''');
      },
    );
  }

  Future<bool> isLoggedIn() async {
    final db = await database;
    final result = await db.query("user");
    return result.isNotEmpty;
  }

  Future<void> loginUser(String name, String phone) async {
    final db = await database;
    await db.insert("user", {"name": name, "phone": phone});
  }

  Future<void> logoutUser() async {
    final db = await database;
    await db.delete("user");
  }
}
