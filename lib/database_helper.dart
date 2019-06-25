import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database db;

class DatabaseCreator {
  static const todoTable = 'todo';
    static const index = 'index';
  static const role ='role';
  static const name = 'name';
  static const post = 'post';
  static const attendanceId = 'attendanceId';
  static const clas = 'clas';
  static const id = 'id';
  static const branch = 'branch';
  static const faculty = 'faculty';
  static const programme = 'programme';
  static const sec= 'sec';

  static void databaseLog(String functionName, String sql,
      [List<Map<String, dynamic>> selectQueryResult, int insertAndUpdateQueryResult, List<dynamic> params]) {
    print(functionName);
    print(sql);
    if (params != null) {
      print(params);
    }
    if (selectQueryResult != null) {
      print(selectQueryResult);
    } else if (insertAndUpdateQueryResult != null) {
      print(insertAndUpdateQueryResult);
    }
  }

  Future<void> createTodoTable(Database db) async {
    final todoSql = '''CREATE TABLE $todoTable
    (
      
      $index INTEGER PRIMARY KEY,
              $role TEXT,
              $name TEXT,
              $post TEXT,
              $attendanceId TEXT,
              $clas TEXT,
              $id TEXT,
              $branch TEXT,
              $faculty TEXT,
              $programme TEXT,
              $sec TEXT,
      
    )''';

    await db.execute(todoSql);
  }

  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    //make sure the folder exists
    if (await Directory(dirname(path)).exists()) {
      //await deleteDatabase(path);
    } else {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> initDatabase() async {
    final path = await getDatabasePath('todo_db');
    db = await openDatabase(path, version: 1, onCreate: onCreate);
    print(db);
  }

  Future<void> onCreate(Database db, int version) async {
    await createTodoTable(db);
  }
}