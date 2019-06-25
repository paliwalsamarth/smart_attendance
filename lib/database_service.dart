import 'package:smart_attendance/database_helper.dart';
import 'package:smart_attendance/modelDatabase.dart';

class RepositoryServiceTodo {
  static Future<List<Client>> getAllTodos() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.todoTable}''';
    final data = await db.rawQuery(sql);
    List<Client> todos = List();

    for (final node in data) {
      final todo = Client.fromJson(node);
      todos.add(todo);
    }
    return todos;
  }

  static Future<Client> getTodo(int id) async {
    //final sql = '''SELECT * FROM ${DatabaseCreator.todoTable}
    //WHERE ${DatabaseCreator.id} = $id''';
    //final data = await db.rawQuery(sql);

    final sql = '''SELECT * FROM ${DatabaseCreator.todoTable}
    WHERE ${DatabaseCreator.id} = ?''';

    List<dynamic> params = [id];
    final data = await db.rawQuery(sql, params);

    final todo = Client.fromJson(data.first);
    return todo;
  }

  static Future<void> addTodo(Client todo) async {
    /*final sql = '''INSERT INTO ${DatabaseCreator.todoTable}
    (
      ${DatabaseCreator.id},
      ${DatabaseCreator.name},
      ${DatabaseCreator.info},
      ${DatabaseCreator.isDeleted}
    )
    VALUES
    (
      ${todo.id},
      "${todo.name}",
      "${todo.info}",
      ${todo.isDeleted ? 1 : 0}
    )''';*/

    final sql = '''INSERT INTO ${DatabaseCreator.todoTable}
    (
      ${DatabaseCreator.index},
      ${DatabaseCreator.role},
      ${DatabaseCreator.name},
      ${DatabaseCreator.post},
      ${DatabaseCreator.attendanceId},
      ${DatabaseCreator.clas},
      ${DatabaseCreator.id},
      ${DatabaseCreator.branch},
      ${DatabaseCreator.faculty},
      ${DatabaseCreator.programme},
      ${DatabaseCreator.sec}
    )
    VALUES (?,?,?,?)''';
    List<dynamic> params = [todo.index, todo.role, todo.name, todo.post, todo.attendanceId, todo.clas, todo.id, todo.branch, todo.faculty, todo.programme, todo.sec];
    final result = await db.rawInsert(sql, params);
    DatabaseCreator.databaseLog('Add todo', sql, null, result, params);
  }

  static Future<void> deleteTodo(Client todo) async {
    /*final sql = '''UPDATE ${DatabaseCreator.todoTable}
    SET ${DatabaseCreator.isDeleted} = 1
    WHERE ${DatabaseCreator.id} = ${todo.id}
    ''';*/

    final sql = '''Delete * from ${DatabaseCreator.todoTable}
    ''';

    List<dynamic> params = [todo.id];
    final result = await db.rawUpdate(sql, params);

    DatabaseCreator.databaseLog('Delete todo', sql, null, result, params);
  }

  static Future<void> updateTodo(Client todo) async {
    /*final sql = '''UPDATE ${DatabaseCreator.todoTable}
    SET ${DatabaseCreator.name} = "${todo.name}"
    WHERE ${DatabaseCreator.id} = ${todo.id}
    ''';*/

    final sql = '''UPDATE ${DatabaseCreator.todoTable}
    SET ${DatabaseCreator.name} = ?
    WHERE ${DatabaseCreator.id} = ?
    ''';

    List<dynamic> params = [todo.name, todo.id];
    final result = await db.rawUpdate(sql, params);

    DatabaseCreator.databaseLog('Update todo', sql, null, result, params);
  }

  static Future<int> todosCount() async {
    final data = await db.rawQuery('''SELECT COUNT(*) FROM ${DatabaseCreator.todoTable}''');

    int count = data[0].values.elementAt(0);
    int idForNewItem = count++;
    return idForNewItem;
  }
}