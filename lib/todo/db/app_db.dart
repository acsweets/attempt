import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

/// 建新表操作新表
class AppDB {
  static final AppDB _instance = AppDB._internal();
  Database? todoDB;

  // 工厂构造函数，确保每次返回同一个实例
  factory AppDB() {
    return _instance;
  }

  // 内部构造函数，避免外部创建
  AppDB._internal();

  // 初始化数据库
  Future<void> initDatabase() async {
    if (todoDB == null) {
      final dbPath = await getDatabasesPath();
      todoDB = await openDatabase(
        join(dbPath, 'todo_database.db'),
        version: 1,
        onCreate: (db, version) async {
          // 创建 tasks 表
          await db.execute('''
        CREATE TABLE IF NOT EXISTS tasks(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          dueDate TEXT NOT NULL,
          isRecurring INTEGER NOT NULL,
          status TEXT NOT NULL
        )
      ''');
        },
      );
      print('todoDB.path${todoDB?.path}');
    }
  }

  /// await insertTask(db, {
  //   'title': 'Buy groceries',
  //   'dueDate': DateTime.now().add(Duration(days: 1)).toIso8601String(),
  //   'isRecurring': 1,  // 是否为重复任务
  //   'status': 'pending', // 状态：未完成
  // });
  Future<void> insertTask(Map<String, dynamic> task) async {
    await todoDB?.insert(
      'tasks', // 表名
      task, // 插入的数据
      conflictAlgorithm: ConflictAlgorithm.replace, // 如果有冲突则替换
    );
  }

  ///Future<List<Map<String, dynamic>>> getPendingTasks(Database db) async {
//   return await db.query(
//     'tasks',
//     where: 'status = ?',   // 查询条件
//     whereArgs: ['pending'] // 对应的参数
//   );
// }

  Future<List<Map<String, dynamic>>> getAllTasks() async {
    todoDB?.execute('');
    return await todoDB!.query('tasks'); // 查询所有任务
  }

  Future<Map<String, dynamic>?> getTaskById(Database db, int id) async {
    final List<Map<String, dynamic>> result = await db.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return result.first; // 返回找到的任务
    }
    return null;
  }

  ///await updateTask(db, 1, {
  //   'status': 'completed',  // 将状态更新为已完成
  // });
  Future<void> updateTask(
      Database db, int id, Map<String, dynamic> updatedTask) async {
    await db.update(
      'tasks',
      updatedTask, // 更新的数据
      where: 'id = ?', // 确定要更新哪条数据
      whereArgs: [id],
    );
  }

  /// await deleteTask(db, 1); // 删除ID为1的任务
  Future<void> deleteTask(Database db, int id) async {
    await db.delete(
      'tasks',
      where: 'id = ?', // 删除条件
      whereArgs: [id],
    );
  }

  ///分页查询 limit 条数     offset 定位
  Future<List<Map<String, dynamic>>> getPaginatedTasks(
      Database db, int limit, int offset) async {
    return await db.rawQuery('''
    SELECT * FROM tasks ORDER BY id LIMIT ? OFFSET ?
    ''', [limit, offset]);
  }
}

