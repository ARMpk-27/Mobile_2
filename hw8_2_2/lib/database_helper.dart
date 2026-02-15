import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'user.dart';

class DatabaseHelper {
  DatabaseHelper._instance();
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;

  Future<Database> get db async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'appDBbmi2.db');

    _database = await openDatabase(
      path,
      version: 4,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return _database!;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tbUsers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        email TEXT,
        pwd TEXT,
        weight REAL,
        height REAL,
        bmi REAL,
        bmi_type TEXT,
        normal_weight REAL,
        weight_to_adjust REAL,
        advice_text TEXT,
        bmi_image TEXT
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 3) {
      await _addColumnIfNotExists(db, 'tbUsers', 'bmi', 'REAL');
      await _addColumnIfNotExists(db, 'tbUsers', 'bmi_type', 'TEXT');
    }
    if (oldVersion < 4) {
      await _addColumnIfNotExists(db, 'tbUsers', 'normal_weight', 'REAL');
      await _addColumnIfNotExists(db, 'tbUsers', 'weight_to_adjust', 'REAL');
      await _addColumnIfNotExists(db, 'tbUsers', 'advice_text', 'TEXT');
      await _addColumnIfNotExists(db, 'tbUsers', 'bmi_image', 'TEXT');
    }
    await updateAllBmi(database: db);
  }

  Future<void> _addColumnIfNotExists(
    Database db,
    String table,
    String column,
    String type,
  ) async {
    final columns = await db.rawQuery('PRAGMA table_info($table)');
    final exists = columns.any((c) => c['name'] == column);
    if (!exists) {
      await db.execute('ALTER TABLE $table ADD COLUMN $column $type');
    }
  }

  Future<int> insertUser(User user) async {
    final database = await db;
    return database.insert('tbUsers', user.toMap());
  }

  Future<List<Map<String, dynamic>>> queryAllUsers() async {
    final database = await db;
    return database.query('tbUsers');
  }

  Future<List<User>> getUser({Database? database}) async {
    final currentDb = database ?? await db;
    final userMap = await currentDb.query('tbUsers');
    return userMap.map((map) => User.fromMap(map)).toList();
  }

  Future<int> updateUser(User user) async {
    final database = await db;
    return database.update(
      'tbUsers',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final database = await db;
    return database.delete('tbUsers', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAllUsers() async {
    final database = await db;
    await database.delete('tbUsers');
  }

  Future<void> updateAllBmi({Database? database}) async {
    final currentDb = database ?? await db;
    final users = await getUser(database: currentDb);

    for (final user in users) {
      final bmi = User.calculateBmi(user.weight, user.height);
      final bmiType = User.determineBmiType(bmi);

      final hMeter = user.height / 100.0;
      final minNormal = 18.5 * hMeter * hMeter;
      final maxNormal = 24.9 * hMeter * hMeter;

      double normalWeight;
      double weightToAdjust;
      String adviceText;

      if (bmi < 18.5) {
        normalWeight = minNormal;
        weightToAdjust = minNormal - user.weight;
        adviceText =
            'ต้องเพิ่มน้ำหนัก ${weightToAdjust.toStringAsFixed(1)} กก. เพื่ออยู่ในเกณฑ์ Normal';
      } else if (bmi > 24.9) {
        normalWeight = maxNormal;
        weightToAdjust = user.weight - maxNormal;
        adviceText =
            'ต้องลดน้ำหนัก ${weightToAdjust.toStringAsFixed(1)} กก. เพื่ออยู่ในเกณฑ์ Normal';
      } else {
        normalWeight = user.weight;
        weightToAdjust = 0;
        adviceText = 'น้ำหนักอยู่ในเกณฑ์ Normal';
      }

      final bmiImage = _bmiImagePath(bmi);

      await currentDb.update(
        'tbUsers',
        {
          'bmi': bmi,
          'bmi_type': bmiType,
          'normal_weight': normalWeight,
          'weight_to_adjust': weightToAdjust,
          'advice_text': adviceText,
          'bmi_image': bmiImage,
        },
        where: 'id = ?',
        whereArgs: [user.id],
      );
    }
  }

  String _bmiImagePath(double bmi) {
    if (bmi < 18.5) return 'assets/images/bmi-1.png';
    if (bmi <= 22.9) return 'assets/images/bmi-2.png';
    if (bmi <= 24.9) return 'assets/images/bmi-3.png';
    if (bmi <= 29.9) return 'assets/images/bmi-4.png';
    return 'assets/images/bmi-5.png';
  }

  Future<void> initializeUsers() async {
    // ใส่ user เริ่มต้นได้ถ้าต้องการ
  }
}
