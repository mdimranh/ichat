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
          CREATE TABLE me(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            firstName TEXT,
            lastName TEXT,
            phone TEXT,
            username TEXT,
            statusMessage TEXT
          )
        ''');
      },
    );
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    final db = await database;
    final result = await db.query("me");
    final me = result.first;
    return me;
  }

  Future<void> addUserInfo(
    String firstName,
    String lastName,
    String phone,
    String username,
    String statusMessage,
  ) async {
    final db = await database;
    final result = await db.query("me");
    if (result.isEmpty) {
      await db.insert("me", {
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "username": username,
        "statusMessage": statusMessage,
      });
    } else {
      final me = result.first;
      await db.update(
        "me",
        {
          "firstName": firstName,
          "lastName": lastName,
          "phone": phone,
          "username": username,
          "statusMessage": statusMessage,
        },
        where: "id = ?",
        whereArgs: [me["id"]],
      );
    }
  }

  Future<void> updateUser(
    String firstName,
    String lastName,
    String phone,
    String username,
    String statusMessage,
  ) async {
    final db = await database;
    final users = await db.query("me");
    final me = users.first;
    await db.update(
      "me",
      {
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "username": username,
        "statusMessage": statusMessage,
      },
      where: "id = ?",
      whereArgs: [me["id"]],
    );
  }
}
