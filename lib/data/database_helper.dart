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
    String path = join(databasesPath, 'your_database_name.db');

    // Open the database
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    // Create tables, initialize your database schema here
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        email TEXT,
        password TEXT, 
        name TEXT,
        surname TEXT,
        dateofbirth TEXT,
        bio TEXT
      )
    ''');
  }

  // Insert a user into the database
  Future<int> insertUser(Map<String, dynamic> user) async {
    var dbClient = await db;
    return await dbClient.insert('users', user);
  }

  // Get all users from the database
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    var dbClient = await db;
    return await dbClient.query('users');
  }

  // Update a user in the database
  Future<int> updateUser(Map<String, dynamic> user) async {
    var dbClient = await db;
    return await dbClient.update('users', user,
        where: 'id = ?', whereArgs: [user['id']]);
  }

  // Delete a user from the database
  Future<int> deleteUser(int id) async {
    var dbClient = await db;
    return await dbClient.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
