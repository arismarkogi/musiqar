import 'package:flutter/material.dart';
import 'select_music.dart';
import 'signin_page.dart';
import 'menu_page.dart';
import 'data/database_helper.dart';
import 'homepage.dart';
import 'dart:async';
import 'dart:io';
import 'camera.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'earth_ar.dart';
import 'music.dart';

class HomePage extends StatelessWidget {
  final DatabaseHelper dbHelper = DatabaseHelper();

  Future<List<CameraDescription>> getCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await availableCameras();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
        body: GestureDetector(
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
                  onPressed: () async {
                    List<Map<String, dynamic>> users =
                        await dbHelper.getAllQuestions();
                    print(users);
                    List<Map<String, dynamic>> qq =
                        await dbHelper.getcoursebyinput();
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

                    //await DatabaseHelper().checkAndCreateTables();
                  },
                  child: Text('See data'),
                ),
                /*ElevatedButton(
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
                ElevatedButton(
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
                        builder: (context) => MusicSelectionScreen(),
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
                        builder: (context) => MusicPage(),
                      ),
                    );
                  },
                  child: Text('Music'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
