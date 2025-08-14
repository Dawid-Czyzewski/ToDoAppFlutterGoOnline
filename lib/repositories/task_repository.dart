import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';
import '../database/db_queries.dart';

class TaskRepository {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(kDatabaseName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: kDatabaseVersion, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute(kCreateTasksTable);
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final maps = await db.query(kTableTasks);
    return maps.map(Task.fromMap).toList();
  }

  Future<int> insertTask(Task task) async {
    final db = await database;
    return await db.insert(kTableTasks, task.toMap());
  }

  Future<int> updateTask(Task task) async {
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
}