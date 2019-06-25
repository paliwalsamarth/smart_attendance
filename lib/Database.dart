import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_attendance/modelDatabase.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Client ("
              "index INTEGER PRIMARY KEY,"
              "role TEXT,"
              "name TEXT,"
              "post TEXT,"
              "attendance_id TEXT,"
              "clas TEXT,"
              "id TEXT,"
              "branch TEXT,"
              "faculty TEXT,"
              "programme TEXT,"
              "sec TEXT,"

              ")");
        });
  }


  newClient(Client newClient) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as index FROM Client");
    int index = table.first["index"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Client (index,role,name,post,attendance_id,clas,id,branch,faculty,programme,sec)"
            " VALUES (?,?,?,?,?,?,?,?,?,?,?)",
        [index, newClient.role, newClient.name, newClient.post, newClient.attendanceId, newClient.clas, newClient.id, newClient.branch, newClient.faculty, newClient.programme,  newClient.sec,]);
    return raw;
  }

//  blockOrUnblock(Client client) async {
//    final db = await database;
//    Client blocked = Client(
//        id: client.id,
//        firstName: client.firstName,
//        lastName: client.lastName,
//        blocked: !client.blocked);
//    var res = await db.update("Client", blocked.toMap(),
//        where: "id = ?", whereArgs: [client.id]);
//    return res;
//  }

  updateClient(Client newClient) async {
    final db = await database;
    var res = await db.update("Client", newClient.toJson(),
        where: "index = ?", whereArgs: [newClient.index]);
    return res;
  }

  getClient(int index) async {
    final db = await database;
    var res = await db.query("Client", where: "index = ?", whereArgs: [index]);
    return res.isNotEmpty ? Client.fromJson(res.first) : null;
  }

//  Future<List<Client>> getBlockedClients() async {
//    final db = await database;
//
//    print("works");
//    // var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
//    var res = await db.query("Client", where: "blocked = ? ", whereArgs: [1]);
//
//    List<Client> list =
//    res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
//    return list;
//  }

//  Future<List<Client>> getAllClients() async {
//    final db = await database;
//    var res = await db.query("Client");
//    List<Client> list =
//    res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
//    return list;
//  }
//
//  deleteClient(int index) async {
//    final db = await database;
//    return db.delete("Client", where: "index = ?", whereArgs: [index]);
//  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Client");
  }
}