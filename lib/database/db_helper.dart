import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';
import 'db_queries.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper instance = DBHelper._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), kDatabaseName);
    return await openDatabase(
      path,
      version: kDatabaseVersion,
      onCreate: (db, version) async {
        await db.execute(kCreateTasksTable);
      },
    );
  }

  Future<int> insertTask(Task task) async {
    final db = await database;
    return await db.insert(kTableTasks, task.toMap());
  }

  Future<int> updateTask(Task task) async {
    if (task.id == null) {
      throw ArgumentError('Cannot update a task without an ID.');
    }
    final db = await database;
    return await db.update(
      kTableTasks,
      task.toMap(),
      where: '$kColId = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete(
      kTableTasks,
      where: '$kColId = ?',
      whereArgs: [id],
    );
  }

  Future<List<Task>> getAllTasks() async {
    final db = await database;
    final maps = await db.query(
      kTableTasks,
      orderBy: '$kColDeadline ASC',
    );
    return maps.map(Task.fromMap).toList();
  }

  Future<List<Task>> getTasksByDone(bool isDone) async {
    final db = await database;
    final maps = await db.query(
      kTableTasks,
      where: '$kColIsDone = ?',
      whereArgs: [isDone ? 1 : 0],
      orderBy: '$kColDeadline ASC',
    );
    return maps.map(Task.fromMap).toList();
  }

  Future<int> getTaskCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM $kTableTasks');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> getCompletedTaskCount() async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) FROM $kTableTasks WHERE $kColIsDone = 1',
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<void> close() async {
    final db = _database;
    if (db != null && db.isOpen) {
      await db.close();
      _database = null;
    }
  }
}