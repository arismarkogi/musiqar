import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
  if (_db != null) {
    return _db!;
  }
  _db = await initDb();
  return _db!;
}


  DatabaseHelper.internal();

  Future<Database> initDb() async {
  String databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'musiqar.db');

  try {
    var db = await openDatabase(path, version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  } catch (e) {
    print('Error initializing database: $e');
    rethrow; 
  }
}

void _onUpgrade(Database db, int oldVersion, int newVersion) async {
  if (oldVersion < 3) {
    await db.execute('''
      CREATE TABLE course (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      description TEXT, 
      category TEXT,
      instructor INTEGER
    )
    ''');

    await db.execute('''
      CREATE TABLE chapter (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      pdf TEXT,
      pdf_name TEXT
    )
    ''');

    await db.execute("""
    CREATE TABLE has_chapter (
      chapter_id INTEGER PRIMARY KEY,
      course_id INTEGER PRIMARY KEY
    )
    """);

    await db.execute("""
    CREATE TABLE question (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      type TEXT,
      title TEXT
    )
    """);

    await db.execute("""
    CREATE TABLE has_question (
      chapter_id INTEGER PRIMARY KEY,
      question_id INTEGER PRIMARY KEY
    )
    """);
  }
}

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      email TEXT,
      password TEXT, 
      name TEXT,
      surname TEXT,
      dateofbirth TEXT,
      bio TEXT,
      image BLOB,
      points INTEGER DEFAULT 0
    )
    ''');

    await db.execute('''
      CREATE TABLE course (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      description TEXT, 
      category TEXT,
      instructor INTEGER
    )
    ''');

    await db.execute('''
      CREATE TABLE chapter (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      pdf TEXT,
      pdf_name TEXT
    )
    ''');

    await db.execute("""
    CREATE TABLE has_chapter (
      chapter_id INTEGER,
      course_id INTEGER,
      PRIMARY KEY (chapter_id, course_id)
    )
    """);

    await db.execute("""
    CREATE TABLE question (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      type TEXT,
      title TEXT
    )
    """);

    await db.execute("""
    CREATE TABLE has_question (
      chapter_id INTEGER,
      question_id INTEGER,
      PRIMARY KEY(chapter_id, question_id)
    )
    """);


  }

  Future<int> insertUser(Map<String, dynamic> user) async {
  var dbClient = await db;
  int userId = await dbClient.insert('users', user);
  return userId;
  }

  Future<int> newcourse(Map<String, dynamic> course) async {
  var dbClient = await db;
  int courseId = await dbClient.insert('course', course);
  return courseId;
  }

  Future<void> deleteAllUsers() async {
    final db = await this.db;
    await db.delete('users');
  }


  Future<List<Map<String, dynamic>>> getAllUsers() async {
    var dbClient = await db;
    return await dbClient.query('users');
  }

  Future<List<Map<String, dynamic>>> getAllCourses() async {
    var dbClient = await db;
    return await dbClient.query('course');
  }

  Future<int> updateUser(Map<String, dynamic> user) async {
    var dbClient = await db;
    return await dbClient.update('users', user,
        where: 'id = ?', whereArgs: [user['id']]);
  }

  Future<int> deleteUser(int id) async {
    var dbClient = await db;
    return await dbClient.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteCourse(int id) async {
    var dbClient = await db;
    return await dbClient.delete('course', where: 'id = ?', whereArgs: [id]);
  }

  
  Future<bool> doesTableExist(String tableName) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery('''
      SELECT name
      FROM sqlite_master
      WHERE type='table' AND name=?
    ''', [tableName]);

    return result.isNotEmpty;
  }

  Future<void> checkAndCreateTables() async {
  List<String> tableNames = ['users', 'course', 'chapter', 'has_chapter', 'question', 'has_question'];

  for (String tableName in tableNames) {
    bool tableExists = await doesTableExist(tableName);
    if (!tableExists) {
      print('$tableName table does not exist, creating...');
      await _createTable(tableName);
      print('$tableName table created successfully');
    } else {
      print('$tableName table already exists');
    }
  }
}

Future<void> _createTable(String tableName) async {
  var dbClient = await db;

  switch (tableName) {
    case 'users':
      await dbClient.execute('''
        CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          email TEXT,
          password TEXT, 
          name TEXT,
          surname TEXT,
          dateofbirth TEXT,
          bio TEXT,
          image BLOB,
          points INTEGER DEFAULT 0
        )
      ''');
      break;
    case 'course':
      await dbClient.execute('''
        CREATE TABLE course (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          description TEXT, 
          category TEXT,
          instructor INTEGER
        )
      ''');
      break;
    case 'chapter':
      await dbClient.execute('''
        CREATE TABLE chapter (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        pdf TEXT,
        pdf_name TEXT
      )
      ''');
      break;
    case 'has_chapter':
      await dbClient.execute("""
      CREATE TABLE has_chapter (
        chapter_id INTEGER,
        course_id INTEGER,
        PRIMARY KEY (chapter_id, course_id)
      )
      """);
      break;
    case 'question':
      await dbClient.execute("""
        CREATE TABLE question (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          type TEXT,
          title TEXT
        )
      """);
      break;
    case 'has_question':
      await dbClient.execute("""
      CREATE TABLE has_question (
        chapter_id INTEGER ,
        question_id INTEGER,
        PRIMARY KEY (chapter_id, question_id)
      )
      """);
      break;

    default:
      print('Unsupported table name: $tableName');
  }
}

}




