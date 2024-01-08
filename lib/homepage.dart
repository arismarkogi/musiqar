import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'select_music.dart';
=======
import 'package:flutter_application_1/select_music.dart';
>>>>>>> 3d15553 (update)
import 'signin_page.dart';
import 'menu_page.dart';
import 'swipe_right_page.dart';
import 'data/database_helper.dart';
import 'homepage.dart';
import 'ar2.dart';
import 'dart:async';
import 'dart:io';
import 'camera.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'extra_page.dart';
import 'arsaxo.dart';
import 'earth_ar.dart';
import 'music.dart';
<<<<<<< HEAD
import 'speech.dart';
=======




>>>>>>> 3d15553 (update)

class HomePage extends StatelessWidget {
  final DatabaseHelper dbHelper = DatabaseHelper();

  Future<List<CameraDescription>> getCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await availableCameras();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.primaryDelta! > 15) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SwipeRightPage()),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Center(
            child: Image.asset(
              'assets/logo.png',
              width: 120,
              height: 40,
            ),
          ),
        ),
<<<<<<< HEAD
        body: GestureDetector(
          onHorizontalDragUpdate: (details) {
            if (details.primaryDelta! > 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SwipeRightPage()),
              );
            }
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  },
                  child: Text('Sign in'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ARR()),
                    );
                  },
                  child: Text('Piano'),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SpeechSampleApp()),
                    );
                  },
                  child: Text('Speech'),
                ),
                /*SizedBox(height: 20),
=======
      ),
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.primaryDelta! > 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SwipeRightPage()),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                },
                child: Text('Sign in'),
              ),
              SizedBox(height: 20),
              /*ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MenuPage(userId:userId)),
                  );
                },
                child: Text('Menu'),
              ),
              */
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ARR()),
                  );
                },
                child: Text('Piano'),
              ),
              /*SizedBox(height: 20),
>>>>>>> 3d15553 (update)
              ElevatedButton(
                onPressed: () async {
                  dbHelper.deleteAllUsers();

                  int insertedId1 = await dbHelper.insertUser({
                    'email': 'user2@example.com',
                    'password': 'password',
                    'name': 'Name2',
                    'surname': 'Surname2',
                    'dateofbirth': '2002-01-10',
                    'bio': 'My short nbbbio',
                    'points': 20
                  });

                  int insertedId2 = await dbHelper.insertUser({
                    'email': 'user2@example.com',
                    'password': 'password',
                    'name': 'Name2',
                    'surname': 'Surname3',
                    'dateofbirth': '2002-01-10',
                    'bio': 'My short bio',
                    'points': 25
                  });

                  int insertedId3 = await dbHelper.insertUser({
                    'email': 'user3@example.com',
                    'password': 'password',
                    'name': 'Name3',
                    'surname': 'Surname3',
                    'dateofbirth': '2002-01-10',
                    'bio': 'My bio-3',
                    'points': 15
                  });

                  print('Inserted ID: $insertedId1');
                },
                child: Text('Add data'),
              ),*/
<<<<<<< HEAD
                ElevatedButton(
                onPressed: () async {
                  List<Map<String, dynamic>> users = await dbHelper.getAllQuestions();
                  print(users);
                  List<Map<String, dynamic>> qq = await dbHelper.getcoursebyinput();
                  print(qq);
                  /*List<Map<String, dynamic>> courses = await dbHelper.getAllCourses();
                  print(courses);
                   List<Map<String, dynamic>> chapters = await dbHelper.getAllCChapters();
                   print(chapters);*/
                  // await dbHelper.createQuestionTable();
                  //await dbHelper.createQuestionTable();
                  //await dbHelper.addTestData();
                 // List<String> tables = await dbHelper.getTables();

                  // Print the list of tables
                  //print('Tables in the database: $tables');
=======
                /*ElevatedButton(
                onPressed: () async {
                  //List<Map<String, dynamic>> users = await dbHelper.getAllUsers();
                  //print(users);
                   //List<Map<String, dynamic>> courses = await dbHelper.getAllCourses();
                   //print(courses);
                   //List<Map<String, dynamic>> chapters = await dbHelper.getAllCChapters();
                   //print(chapters);
                  // await dbHelper.createQuestionTable();
                  await dbHelper.createQuestionTable();
                  await dbHelper.addTestData();
                  List<String> tables = await dbHelper.getTables();

                  // Print the list of tables
                  print('Tables in the database: $tables');
>>>>>>> 3d15553 (update)

                  //await DatabaseHelper().checkAndCreateTables();

                },
<<<<<<< HEAD
                child: Text('See data'),
              ),
                /*ElevatedButton(
=======
                child: Text('See tables'),
              ),*/
              /*ElevatedButton(
>>>>>>> 3d15553 (update)
                onPressed: () async {
                  await dbHelper.dropAndRecreateTables();

                  int insertedId0 = await dbHelper.insertUser({
                  'email': '1@1.1',
                  'password': '1',
                  'name': 'Admin',
                  'surname': 'Admin',
                  'dateofbirth': '2002-01-01',
                  'bio': 'Bio',
                  'points': 100
                });

                int insertedId1 = await dbHelper.insertUser({
                  'email': 'user2@example.com',
                  'password': 'password',
                  'name': 'Name2',
                  'surname': 'Surname2',
                  'dateofbirth': '2002-01-10',
                  'bio': 'My short nbbbio',
                  'points': 20
                });

                int insertedId2 = await dbHelper.insertUser({
                  'email': 'user2@example.com',
                  'password': 'password',
                  'name': 'Name2',
                  'surname': 'Surname3',
                  'dateofbirth': '2002-01-10',
                  'bio': 'My short bio',
                  'points': 25
                });

                int insertedId3 = await dbHelper.insertUser({
                  'email': 'user3@example.com',
                  'password': 'password',
                  'name': 'Name3',
                  'surname': 'Surname3',
                  'dateofbirth': '2002-01-10',
                  'bio': 'My bio-3',
                  'points': 15
                });

                print('Inserted ID: $insertedId1');
                },
                child: Text('Drop DB'),
              ),*/
<<<<<<< HEAD
                ElevatedButton(
=======
              ElevatedButton(
>>>>>>> 3d15553 (update)
                  onPressed: () async {
                    List<CameraDescription> cameras = await getCameras();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TakePictureScreen(
                          camera: cameras.first,
                        ),
                      ),
                    );
                  },
                  child: Text('Camera'),
                ),
                /*ElevatedButton(
                  onPressed: () async {
                    List<CameraDescription> cameras = await getCameras();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CombinedScreen(
                          camera: cameras.first,
                        ),

                      ),
                    );
                  },
                  child: Text('ARR'),
                ),*/
                ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
<<<<<<< HEAD
                        builder: (context) => MusicSelectionScreen(),
=======
                        builder: (context) => MusicSelectionScreen(
                        ),

>>>>>>> 3d15553 (update)
                      ),
                    );
                  },
                  child: Text('Select Music and AR'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ARS(),
                      ),
                    );
                  },
                  child: Text('Saxophone'),
                ),
                ElevatedButton(
                  onPressed: () async {
<<<<<<< HEAD
=======

>>>>>>> 3d15553 (update)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MusicPage(),
                      ),
                    );
                  },
                  child: Text('Music'),
                ),
<<<<<<< HEAD
              ],
            ),
=======
            ],
>>>>>>> 3d15553 (update)
          ),
        ),
      ),
    );
  }
}
