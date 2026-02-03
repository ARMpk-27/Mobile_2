import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'user.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get db async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'databaseapp.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tbUsers (
        id INTEGER PRIMARY KEY,
        username TEXT,
        email TEXT
      )
    ''');
  }

  // CREATE
  Future<int> insertUser(User user) async {
    final dbClient = await db;
    return await dbClient.insert('tbUsers', user.toMap());
  }

  // READ
  Future<List<Map<String, dynamic>>> queryAllUsers() async {
    final dbClient = await db;
    return await dbClient.query('tbUsers');
  }

  // UPDATE
  Future<int> updateUser(User user) async {
    final dbClient = await db;
    return await dbClient.update(
      'tbUsers',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // DELETE (รายคน)
  Future<int> deleteUser(int id) async {
    final dbClient = await db;
    return await dbClient.delete(
      'tbUsers',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // DELETE ALL
  Future<void> deleteAllUsers() async {
    final dbClient = await db;
    await dbClient.delete('tbUsers');
  }

  // ✅ เพิ่มตาม PDF: ใส่ข้อมูลตั้งต้น
  Future<void> initializeUsers() async {
    final List<User> usersToAdd = [
      User(username: 'John', email: 'john@example.com'),
      User(username: 'Jane', email: 'jane@example.com'),
      User(username: 'Alice', email: 'alice@example.com'),
      User(username: 'Bob', email: 'bob@example.com'),
    ];

    for (final user in usersToAdd) {
      await insertUser(user);
    }
  }
}
