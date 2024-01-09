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
    var db = await openDatabase(path, version: 2, onCreate: _onCreate, );
    return db;
  } catch (e) {
    print('Error initializing database: $e');
    rethrow; 
  }
}

/*void _onUpgrade(Database db, int oldVersion, int newVersion) async {
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
}*/

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
      question_type TEXT,
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
    CREATE TABLE Question (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      chapter_id INTEGER,
      type TEXT,
      title TEXT,
      FOREIGN KEY(chapter_id) REFERENCES Chapter(id)
    )
    """);

    await db.execute("""
    CREATE TABLE Answer (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      question_id INTEGER,
      text TEXT,
      is_correct BOOLEAN,
      FOREIGN KEY(question_id) REFERENCES Question(id)
    )
    """);

    int insertedId0 = await insertUser({
      'email': '1@1.1',
      'password': '1',
      'name': 'Admin',
      'surname': 'Admin',
      'dateofbirth': '2002-01-01',
      'bio': 'Bio',
      'points': 100
    });

    int insertedId1 = await insertUser({
      'email': 'user2@example.com',
      'password': 'password',
      'name': 'Name2',
      'surname': 'Surname2',
      'dateofbirth': '2002-01-10',
      'bio': 'My short nbbbio',
      'points': 20
    });

    int insertedId2 = await insertUser({
      'email': 'user2@example.com',
      'password': 'password',
      'name': 'Name2',
      'surname': 'Surname3',
      'dateofbirth': '2002-01-10',
      'bio': 'My short bio',
      'points': 25
    });

    int insertedId3 = await insertUser({
      'email': 'user3@example.com',
      'password': 'password',
      'name': 'Name3',
      'surname': 'Surname3',
      'dateofbirth': '2002-01-10',
      'bio': 'My bio-3',
      'points': 15
    });

    print('Inserted ID: $insertedId1');
  }


Future<void> dropAndRecreateTables() async {
  final databasesPath = await getDatabasesPath();
  final path = join(databasesPath, 'musiqar.db');

  var db = await openDatabase(path);


  await db.execute('DROP TABLE IF EXISTS question');
  await db.execute('DROP TABLE IF EXISTS has_question');

  db = await openDatabase(path, version: 1, onCreate: (db, version) async {
    await db.execute('''
      CREATE TABLE Question (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        chapter_id INTEGER,
        type TEXT,
        title TEXT,
        FOREIGN KEY(chapter_id) REFERENCES Chapter(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE Answer (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question_id INTEGER,
        text TEXT,
        is_correct BOOLEAN,
        FOREIGN KEY(question_id) REFERENCES Question(id)
      )
    ''');
  });

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

Future<int> newChapter(Map<String, dynamic> chapter, int courseId) async {
  var dbClient = await db;
  int chapterId = await dbClient.insert('chapter', chapter);

  await dbClient.rawInsert('''
    INSERT INTO has_chapter(chapter_id, course_id)
    VALUES(?, ?)
  ''', [chapterId, courseId]);

  return chapterId;
}

Future<int> newQuestion(Map<String, dynamic> question) async {
  var dbClient = await db;
  int questionId = await dbClient.insert('question', question);

  return questionId;
}


  Future<void> newhas_chapter(Map<String, dynamic> has_chapter) async{
    var dbClient = await db;
    await dbClient.insert('has_chapter', has_chapter);
  }

  Future<void> deleteAllUsers() async {
    final db = await this.db;
    await db.delete('users');
  }


  Future<void> deleteAllCourses() async {
    final db = await this.db;
    await db.delete('course');
  }

  Future<void> deleteAllhas() async {
    final db = await this.db;
    await db.delete('has_chapter');
  }

  Future<void> deleteallchapt() async {
    final db = await this.db;
    await db.delete('chapter');
  }


  Future<List<Map<String, dynamic>>> getAllUsers() async {
    var dbClient = await db;
    return await dbClient.query('users');
  }

  Future<List<Map<String, dynamic>>> getAllCourses() async {
    var dbClient = await db;
    return await dbClient.query('course');
  }

  Future<List<Map<String, dynamic>>> getAllCChapters() async {
    var dbClient = await db;
    return await dbClient.query('chapter');
  }

  Future<List<Map<String, dynamic>>> getAllQuestions() async {
    var dbClient = await db;
    return await dbClient.query('Question');
  }

  Future<int> updateUser(Map<String, dynamic> user) async {
    var dbClient = await db;
    return await dbClient.update('users', user,
        where: 'id = ?', whereArgs: [user['id']]);
  }

  Future<int> updatechapter(Map<String, dynamic> chapter) async {
    var dbClient = await db;
    return await dbClient.update('chapter', chapter,
        where: 'id = ?', whereArgs: [chapter['id']]);
  }

  Future<void> updateChapterPdf(int chapterId, String filename, String pdfPath) async {
    var dbClient = await db;
    await dbClient.rawUpdate('''
      UPDATE chapter
      SET pdf = ?,
      pdf_name = ?
      WHERE id = ?
    ''', [pdfPath, filename, chapterId]);
  }

  Future<bool> isPdfNull(int chapterId) async {
  var dbClient = await db;
  var result = await dbClient.query('chapter', where: 'id = ?', whereArgs: [chapterId]);

  if (result != null && result.isNotEmpty) {
    return result.first['pdf'] == null;
  } else {
    return true; 
  }
}


  Future<void> updateChapterQuestionType(int chapterId, String question_type) async {
    var dbClient = await db;
    await dbClient.rawUpdate('''
      UPDATE chapter
      SET question_type = ?
      WHERE id = ?
    ''', [question_type, chapterId]);
  }

  Future<void> updatechaptertitle(int chapterId, String title) async {
    var dbClient = await db;
    await dbClient.rawUpdate('''
      UPDATE chapter
      SET title = ?
      WHERE id = ?
    ''', [title, chapterId]);
  }

  Future<int> deleteUser(int id) async {
    var dbClient = await db;
    return await dbClient.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteCourse(int id) async {
    var dbClient = await db;
    return await dbClient.delete('course', where: 'id = ?', whereArgs: [id]);
  }

Future<List<String>> getTables() async {
  Database database = await openDatabase(
    join(await getDatabasesPath(), 'musiqar.db'),
  );

  List<Map<String, dynamic>> tables = await database.rawQuery(
    "SELECT name FROM sqlite_master WHERE type='table';",
  );

  List<String> tableNames =
      tables.map((table) => table['name'] as String).toList();

  await database.close();

  return tableNames;
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

  Future<List<Map<String, dynamic>>> getChaptersForCourse(int courseId) async {
    var dbClient = await db;
    return await dbClient.rawQuery('''
      SELECT c.id, c.title
      FROM chapter c
      INNER JOIN has_chapter hc ON c.id = hc.chapter_id
      WHERE hc.course_id = ?
    ''', [courseId]);
  }

  Future<List<Map<String, dynamic>>> getQuestionsForChapter(int chapterId) async {
    var dbClient = await db;
    return await dbClient.rawQuery('''
      SELECT id, title, type
      FROM question 
      WHERE chapter_id = ?
    ''', [chapterId]);
  }

final String createQuestionTableQuery = '''
  CREATE TABLE IF NOT EXISTS Question (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    chapter_id INTEGER,
    type TEXT,
    title TEXT,
    FOREIGN KEY(chapter_id) REFERENCES Chapter(id)
  )
''';



Future<void> createQuestionTable() async {
  Database database = await openDatabase(
    join(await getDatabasesPath(), 'musiqar.db'),
  );

  await database.execute(createQuestionTableQuery);

  await database.close();
}




Future<void> addchapterr() async{
  var dbClient = await db;
  await dbClient.execute("""
   ALTER TABLE chapter ADD COLUMN question_type TEXT
    """);
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
        question_type TEXT,
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
    case 'Question':
      await dbClient.execute("""
      CREATE TABLE Question (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        chapter_id INTEGER,
        type TEXT,
        title TEXT,
        FOREIGN KEY(chapter_id) REFERENCES Chapter(id)
      )
      """);
      break;
    case 'Answer':
      await dbClient.execute("""
      CREATE TABLE Answer (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question_id INTEGER,
        text TEXT,
        is_correct BOOLEAN,
        FOREIGN KEY(question_id) REFERENCES Question(id)
      )
      """);
      break;

    default:
      print('Unsupported table name: $tableName');
  }
}


Future<void> addTestData() async {
  Database database = await openDatabase(
    join(await getDatabasesPath(), 'musiqar.db'),
  );

  await database.rawInsert('''
    INSERT INTO users (email, password, name, surname, dateofbirth, bio, points)
    VALUES ('test@email.com', 'testpassword', 'John', 'Doe', '2000-01-01', 'Bio text', 10)
  ''');

  int courseId = await database.rawInsert('''
    INSERT INTO course (title, description, category, instructor)
    VALUES ('Test Course', 'Course description', 'Test Category', 1)
  ''');

  int chapterId = await database.rawInsert('''
    INSERT INTO chapter (title, question_type, pdf_name)
    VALUES ('Chapter 1', 'LorR', 'chapter1.pdf')
  ''');

  await database.rawInsert('''
    INSERT INTO has_chapter (chapter_id, course_id)
    VALUES (?, ?)
  ''', [chapterId, courseId]);

  await database.rawInsert('''
    INSERT INTO Question (chapter_id, type, title)
    VALUES (?, 'LorR', 'What is the answer?')
  ''', [chapterId]);

  await database.close();
}

}




