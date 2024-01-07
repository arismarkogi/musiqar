
import 'package:flutter/material.dart';
import 'signin_page.dart';
import 'menu_page.dart';
import 'swipe_right_page.dart';
import 'data/database_helper.dart';
import 'homepage.dart';
//import 'earth_ar.dart';
import 'ar2.dart';
import 'dart:async';
import 'dart:io';
import 'camera.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'extra_page.dart';
import 'arsaxo.dart';
import 'earth_ar.dart';





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
        if (details.primaryDelta! > 0) {
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
              SizedBox(height: 20),
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
              ),
                ElevatedButton(
                onPressed: () async {
                  //List<Map<String, dynamic>> users = await dbHelper.getAllUsers();
                  //print(users);
                   //List<Map<String, dynamic>> courses = await dbHelper.getAllCourses();
                   //print(courses);
                   List<Map<String, dynamic>> chapters = await dbHelper.getAllCChapters();
                   print(chapters);
                  //await DatabaseHelper().checkAndCreateTables();

                },
                child: Text('See data'),
              ),
              ElevatedButton(
                  onPressed: () async {
                    // Get cameras when the button is pressed
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
                ElevatedButton(
                  onPressed: () async {
                    // Get cameras when the button is pressed
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
                



            ],
          ),
        ),
      ),
      ),
    );
  }
}