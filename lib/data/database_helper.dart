import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'insertions.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  String courseTable =
      '''
      CREATE TABLE course (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      description TEXT, 
      category TEXT,
      instructor INTEGER,
      image_url TEXT
    );
    ''';

  String chapterTable =
      '''
      CREATE TABLE chapter (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      pdf_url TEXT,
      pdf_name TEXT
    );
    ''';

  String hasChapter =
      """
    CREATE TABLE has_chapter (
    chapter_id INTEGER,
    course_id INTEGER,
    PRIMARY KEY (chapter_id, course_id)  
    );
    """;

  String usersTable =
      '''
      CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      email TEXT,
      password TEXT, 
      name TEXT,
      surname TEXT,
      dateofbirth TEXT,
      bio TEXT,
      image_url TEXT,
      points INTEGER DEFAULT 0
    );
    ''';

  String hasEnrolled =
      '''
    CREATE TABLE has_enrolled (
      course_id INTEGER,
      user_id INTEGER,
      PRIMARY KEY (user_id, course_id)
  );
  ''';

  String hasCompleted =
      '''
    CREATE TABLE has_completed (
      chapter_id INTEGER,
      user_id INTEGER,
      PRIMARY KEY (user_id, chapter_id)
    );
    ''';

  String question =
      """
    CREATE TABLE Question (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      chapter_id INTEGER,
      type TEXT,
      title TEXT,
      answers TEXT,
      correct_answer INT
    );
    """;

  String answer =
      """
    CREATE TABLE Answer (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      question_id INTEGER,
      text TEXT,
      is_correct BOOLEAN
    );
    """;

  DatabaseHelper.internal();

  bool _databaseInitialized = false;

  Future<Database> initDb() async {
    if (_databaseInitialized) {
      return _db!;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool databaseInitialized = prefs.getBool('databaseInitialized') ?? false;

    if (databaseInitialized) {
      _databaseInitialized = true;
      return _db!;
    }

    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'musiqar.db');

    try {
      _db = await openDatabase(path, version: 1, onCreate: _onCreate);
      bool tablesEmpty = await areTablesEmpty();

      if (tablesEmpty) {
        await checkAndCreateTables();
        await _executeInsertStatements();
      }
      _databaseInitialized = true;
      return _db!;
    } catch (e) {
      print('Error initializing database: $e');
      rethrow;
    }
  }

  Future<bool> areTablesEmpty() async {
    try {
      for (String tableName in ['users', 'course', 'chapter']) {
        List<Map<String, dynamic>> result =
            await _db!.rawQuery('SELECT * FROM $tableName LIMIT 1');
        if (result.isNotEmpty) {
          return false;
        }
      }
      return true;
    } catch (e) {
      print('Error checking if tables are empty: $e');
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
    await db.execute(courseTable);
    await db.execute(chapterTable);
    await db.execute(usersTable);
    await db.execute(hasChapter);
    await db.execute(question);
    await db.execute(answer);
    await db.execute(hasEnrolled);
    await db.execute(hasCompleted);
    //await _executeInsertStatements();  // Move this line here
  }

  Future<void> dropAndRecreateTables() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'musiqar.db');

    var db = await openDatabase(path);

    await db.execute('DROP TABLE IF EXISTS question');
    await db.execute('DROP TABLE IF EXISTS has_question');

    db = await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(question);

      await db.execute(answer);
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

    await dbClient.rawInsert(
        '''
    INSERT INTO has_chapter(chapter_id, course_id)
    VALUES(?, ?)
  ''',
        [chapterId, courseId]);

    return chapterId;
  }

  Future<int> newQuestion(Map<String, dynamic> question) async {
    var dbClient = await db;
    int questionId = await dbClient.insert('question', question);

    return questionId;
  }

  Future<void> newhas_chapter(Map<String, dynamic> has_chapter) async {
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

  Future<List<Map<String, dynamic>>> getEnrolledCourses(int userId) async {
    var dbClient = await db;
    return await dbClient.rawQuery(
        '''
    SELECT c.title, u.name,c.image_url FROM course c
    INNER JOIN has_enrolled he ON c.id = he.course_id
    INNer JOIN users u ON u.id = c.instructor
    WHERE he.user_id = ?
  ''',
        [userId]);
  }

  Future<int> updateUser(Map<String, dynamic> user) async {
    var dbClient = await db;
    return await dbClient
        .update('users', user, where: 'id = ?', whereArgs: [user['id']]);
  }

  Future<int> updatechapter(Map<String, dynamic> chapter) async {
    var dbClient = await db;
    return await dbClient.update('chapter', chapter,
        where: 'id = ?', whereArgs: [chapter['id']]);
  }

  Future<void> updateChapterPdf(
      int chapterId, String filename, String pdfPath) async {
    var dbClient = await db;
    await dbClient.rawUpdate(
        '''
      UPDATE chapter
      SET pdf_url = ?,
      pdf_name = ?
      WHERE id = ?
    ''',
        [pdfPath, filename, chapterId]);
  }

  Future<bool> isPdfNull(int chapterId) async {
    var dbClient = await db;
    var result = await dbClient
        .query('chapter', where: 'id = ?', whereArgs: [chapterId]);

    if (result != null && result.isNotEmpty) {
      return result.first['pdf_url'] == null;
    } else {
      return true;
    }
  }

  Future<void> updateChapterQuestionType(
      int chapterId, String question_type) async {
    var dbClient = await db;
    await dbClient.rawUpdate(
        '''
      UPDATE chapter
      SET question_type = ?
      WHERE id = ?
    ''',
        [question_type, chapterId]);
  }

  Future<void> updatechaptertitle(int chapterId, String title) async {
    var dbClient = await db;
    await dbClient.rawUpdate(
        '''
      UPDATE chapter
      SET title = ?
      WHERE id = ?
    ''',
        [title, chapterId]);
  }

  Future<void> addanswers(int questionId, String answers, int correct_answer) async {
    var dbClient = await db;
    await dbClient.rawUpdate(
        '''
      UPDATE question
      SET answers = ?, 
      correct_answer = ?
      WHERE id = ?
    ''',
        [answers, correct_answer, questionId]);
  }

  Future<int> deleteUser(int id) async {
    var dbClient = await db;
    return await dbClient.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteCourse(int courseId) async {
    var dbClient = await db;

    try {
      await dbClient.delete('course', where: 'id = ?', whereArgs: [courseId]);
      await dbClient.delete('chapter', where: 'id = ?', whereArgs: [courseId]);
      await dbClient.delete('question', where: 'chapter_id IN (SELECT id FROM chapter WHERE course_id = ?', whereArgs: [courseId]);
    } catch (e) {
      print('Error deleting course: $e');
    }
  }

  Future<void> deleteQuestionsForChapter(int chapterId) async {
    final dbc = await db;
    await dbc.delete(
      'Question',
      where: 'chapter_id = ?',
      whereArgs: [chapterId],
    );
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
    var result = await dbClient.rawQuery(
        '''
      SELECT name
      FROM sqlite_master
      WHERE type='table' AND name=?
    ''',
        [tableName]);

    return result.isNotEmpty;
  }

  Future<void> checkAndCreateTables() async {
    List<String> tableNames = [
      'users',
      'course',
      'chapter',
      'has_chapter',
      'question',
      'has_completed',
      'has_enrolled',
      'answer'
    ];

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
    return await dbClient.rawQuery(
        '''
      SELECT c.id, c.title
      FROM chapter c
      INNER JOIN has_chapter hc ON c.id = hc.chapter_id
      WHERE hc.course_id = ?
    ''',
        [courseId]);
  }

  Future<List<Map<String, dynamic>>> getQuestion(int questionId) async {
    var dbClient = await db;
    return await dbClient.rawQuery(
        '''
      SELECT *
      FROM question 
      WHERE id = ?
    ''',
        [questionId]);
  }

  Future<List<Map<String, dynamic>>> getQuestionsForChapter(
      int chapterId) async {
    var dbClient = await db;
    return await dbClient.rawQuery(
        '''
      SELECT id, title, type
      FROM question 
      WHERE chapter_id = ?
    ''',
        [chapterId]);
  }

  final String createQuestionTableQuery =
      '''
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

  Future<void> addchapterr() async {
    var dbClient = await db;
    await dbClient.execute(
        """
   ALTER TABLE chapter ADD COLUMN question_type TEXT
    """);
  }

  Future<void> _createTable(String tableName) async {
    var dbClient = await db;

    switch (tableName) {
      case 'users':
        await dbClient.execute(usersTable);
        break;
      case 'course':
        await dbClient.execute(courseTable);
        break;
      case 'chapter':
        await dbClient.execute(chapterTable);
        break;
      case 'has_chapter':
        await dbClient.execute(hasChapter);
        break;
      case 'has_enrolled':
        await dbClient.execute(hasEnrolled);
        break;
      case 'has_completed':
        await dbClient.execute(hasCompleted);
        break;
      case 'Question':
        await dbClient.execute(question);
        break;
      case 'Answer':
        await dbClient.execute(answer);
        break;

      default:
        print('Unsupported table name: $tableName');
    }
  }

  Future<void> _executeInsertStatements() async {
    List<String> insertStatements =
        Insertions.generateInserts(Insertions().insertions);

    if (insertStatements.isNotEmpty) {
      final Batch batch = _db!.batch();
      try {
        for (String insertion in insertStatements) {
          print('Adding to batch: $insertion');
          batch.rawInsert(insertion);
        }
      } catch (e) {
        print('Error during insert: $e');
      }
      await batch.commit();
      print('Batch committed successfully');
    } else {
      print('No insert statements to process');
    }
  }
}
