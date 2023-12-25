import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';
import 'package:flutter_drawing_board/paint_extension.dart';

import 'package:flutter/rendering.dart';
import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Figma to Flutter Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
/*
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

  // Inside your DatabaseHelper class
  Future<void> insertInitialUsers() async {
  // Check if any users exist in the database
  List<Map<String, dynamic>> users = await getAllUsers();

  if (users.isEmpty) {
    // If no users exist, insert some initial users
    await insertUser({'email': 'user1@user.com', 'password': 'password1', 'name':'Name1', 'surname':'Surname1', 'dateofbirth': DateTime(2002, 11, 11).toIso8601String(),'bio':'boo boo emm memm'});
    await insertUser({'username': 'user2@user.com', 'password': 'password2', 'name':'Name2', 'surname':'Surname2', 'dateofbirth': DateTime(2002, 12, 12).toIso8601String(),'bio':'bo boo emm4 memm'});
    await insertUser({'username': 'user3@user.com', 'password': 'password3', 'name':'Name3', 'surname':'Surname3', 'dateofbirth': DateTime(2002, 10, 10).toIso8601String(),'bio':'boo bo emm memm'});
  }
}

  // Example: Insert a user into the database
  Future<int> insertUser(Map<String, dynamic> user) async {
    var dbClient = await db;
    return await dbClient.insert('users', user);
  }

  // Example: Get all users from the database
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    var dbClient = await db;
    return await dbClient.query('users');
  }
}





void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Figma to Flutter Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          // Check if the drag was from left to right
          if (details.primaryDelta! > 0) {
            // Navigate to the SwipeRightPage
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
                    MaterialPageRoute(builder: (context) => MenuPage()),
                  );
                },
                child: Text('Menu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class SwipeRightPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swipe Right Page'),
      ),
      body: Center(
        child: Text(
          'Swipe right to go back!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}


class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true, // Center the title
        title: Center(
          child: Image.asset(
            'assets/logo.png',
            width: 120, // Adjust the width as needed
            height: 40, // Adjust the height as needed
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to the Second Page!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the Home Page
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Widget menuItem() {
    return Container(
    width: 48,
    height: 48,
    child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Container(
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                    ),
                ),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Container(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                    Container(
                                        width: 24,
                                        height: 24,
                                        child: Stack(children: [
                                        
                                        ]),
                                    ),
                                ],
                            ),
                        ),
                    ],
                ),
            ),
        ],
    ),
);
}

Widget  sline(){
  return Container(
    width: 288,
    decoration: ShapeDecoration(
    shape: RoundedRectangleBorder(
    side: BorderSide(
    width: 1,
    strokeAlign: BorderSide.strokeAlignCenter,
    color: Color(0xFFCAC4D0),
    ),
    ),
    ),
    );
}

Widget menulogo() {
  return Container(
    width: 48,
    height: 48,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      child: Stack(children: [
                        // Add your menu icon here
                        IconButton(
                          icon: Icon(Icons.menu), // You can use a different menu icon if needed
                          onPressed: () {
                            // Handle menu button press
                          },
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Center(
        child: menulogo(),
      ),
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 45),
        buildMenuItem(context, 'My Courses', ProfileSettings()),
        const SizedBox(height: 25),
        sline(),
        const SizedBox(height: 45),
        buildMenuItem(context, 'Available Courses', Drawpage()),
        const SizedBox(height: 25),
        sline(),
        const SizedBox(height: 45),
        buildMenuItem(context, 'Rankings', RankingsPage()), // Replace RankingsPage() with the actual page widget
        const SizedBox(height: 25),
        sline(),
        const SizedBox(height: 45),
        buildMenuItem(context, 'User profile', SignInPage()), // Replace UserProfilePage() with the actual page widget
        const SizedBox(height: 25),
        sline(),
        const SizedBox(height: 45),
        buildMenuItem(context, 'New course', NewCoursePage1()), // Replace NewCoursePage() with the actual page widget
        const SizedBox(height: 25),
        sline(),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Image.asset(
                'assets/logo.png',
                width: 120,
                height: 40,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}


Widget buildMenuItem(BuildContext context, String title, Widget page) {
  return InkWell(
    onTap: () {
      // Navigate to the specified page
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    },
    child: Container(
      width: double.infinity, // Take the full width of the parent
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF6750A4),
              fontSize: 28,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              height: 0.05,
              letterSpacing: 0.10,
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    ),
  );
}
}


class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController signInEmailController = TextEditingController();
  TextEditingController signInPasswordController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpConfirmPasswordController = TextEditingController();

 Widget customInput(String labelText, TextEditingController controller, {bool isPassword = false}) {
  return Container(
    width: 210,
    height: 56,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 210,
          height: 56,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    color: Color(0xFFE0E0E0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Add TextField for input
                      Expanded(
                        child: TextField(
                          obscureText: isPassword,
                          controller: controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: labelText, // Use the provided labelText
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFF49454F),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


Widget  sline(){
  return Container(
    width: 288,
    decoration: ShapeDecoration(
    shape: RoundedRectangleBorder(
    side: BorderSide(
    width: 1,
    strokeAlign: BorderSide.strokeAlignCenter,
    color: Color(0xFFCAC4D0),
    ),
    ),
    ),
    );
}

Widget singinbutton({required VoidCallback onPressed, required String buttonText, Widget? child}) {
  return Container(
    width: 92,
    height: 40,
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Color(0xFFB3261E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0.10,
                letterSpacing: 0.10,
              ),
            ),
            if (child != null) SizedBox(width: 6), // Add some space between text and additional child
            if (child != null) child,
          ],
        ),
      ),
    ),
  );
}

 void signIn(BuildContext context) async {
    String email = signInEmailController.text;
    String password = signInPasswordController.text;

    // Check the database for the user
    List<Map<String, dynamic>> users = await DatabaseHelper().getAllUsers();
    print('kati egine');
    bool isUserValid = users.any((user) =>
        user['username'] == email && user['password'] == password);

    if (isUserValid) {
      // Navigate to the profile page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    } else {
      // Show an error message or handle invalid credentials
    }
  }

  void signUp(BuildContext context) async {
    String email = signUpEmailController.text;
    String password = signUpPasswordController.text;
    String cpassword = signUpConfirmPasswordController.text;

    // Check if the password and confirm password match
    if (password != cpassword) {
      // Show an error message or handle password mismatch
      return;
    }
    print('kati egine');
    // Check if the user already exists
    List<Map<String, dynamic>> users = await DatabaseHelper().getAllUsers();
    bool isUserExists = users.any((user) => user['username'] == email);

    if (isUserExists) {
      // Show an error message or handle existing user
      return;
    }

    // Insert the new user into the database
    await DatabaseHelper().insertUser({'username': email, 'password': password});

    // Navigate to the profile page after successful sign-up
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  }

@override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Color(0xFFFEF7FF),
      title: Center(
        child: Image.asset(
          'assets/logo.png',
          width: 150,
          height: 50,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage()));
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ],
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          // Check if the drag was from left to right
          if (details.primaryVelocity! > 0) {
            // Navigate to the menu page
            Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage()));
          }
        },
       child:Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SIGN IN',
                textAlign: TextAlign.center,
                style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                height: 0.04,
                letterSpacing: 0.50,
              ),
              ),
              SizedBox(height: 30),
              // Input boxes
              customInput('Email', signInEmailController),
              SizedBox(height: 16),
              customInput('Password', signInPasswordController, isPassword: true),
              SizedBox(height: 16),
              // Sign-in button
              singinbutton(
                onPressed: () => signIn(context),
                buttonText: 'Sign in',
              ),              
              SizedBox(height: 16),
              sline(),
              const SizedBox(height: 25),

              Text(
                'SIGN UP',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 0.04,
                  letterSpacing: 0.50,                ),
              ),
              SizedBox(height: 30),
              // Input boxes
              customInput('Email', signUpEmailController),
              SizedBox(height: 16),
              customInput('Password', signUpPasswordController, isPassword: true),
              SizedBox(height: 16),
              customInput('Confirm Password', signUpConfirmPasswordController, isPassword: true),
              SizedBox(height: 16),
              // Sign-up button
              singinbutton(
                onPressed: () => signUp(context),
                buttonText: 'Sign up',
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}


class RankingsPage extends StatelessWidget {

Widget ranking(int rank, String name, int points) {
  return Container(
    width: 338,
    height: 56,
    child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Text(
                '$rank ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0.09,
                    letterSpacing: 0.50,
                ),
            ),
            Container(
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Container(
                            width: 299,
                            height: 56,
                            padding: const EdgeInsets.only(top: 8, left: 16, right: 24, bottom: 8),
                            decoration: ShapeDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment(0.00, -1.00),
                                    end: Alignment(0, 1),
                                    colors: [Color(0xFFB5B5B5), Color(0x8EB1C5C8), Color(0x00FFCDCD)],
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                ),
                            ),
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                    Container(
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                            ],
                                        ),
                                    ),
                                    Expanded(
                                        child: Container(
                                            height: double.infinity,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(),
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                    SizedBox(
                                                        width: double.infinity,
                                                        child: Text(
                                                            '$name ',
                                                            style: TextStyle(
                                                                color: Color(0xFF1D1B20),
                                                                fontSize: 16,
                                                                fontFamily: 'Roboto',
                                                                fontWeight: FontWeight.w400,
                                                                height: 0.09,
                                                                letterSpacing: 0.50,
                                                            ),
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                                    ),
                                    Text(
                                        '$points points',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            height: 0.09,
                                            letterSpacing: 0.50,
                                        ),
                                    ),
                                ],
                            ),
                        ),
                    ],
                ),
            ),
        ],
    ),
  );
}


  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Color(0xFFFEF7FF),
      title: Center(
        child: Image.asset(
          'assets/logo.png',
          width: 150,
          height: 50,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage()));
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ],
    ),
    body: GestureDetector(
      onHorizontalDragEnd: (details) {
        // Check if the drag was from left to right
        if (details.primaryVelocity! > 0) {
          // Navigate to the menu page
          Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage()));
        }
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.all(0), // Set padding to zero
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40),
              ranking(1, 'user1', 11),
              ranking(2, 'user2', 10),
              ranking(3, 'user3', 9),
              ranking(4, 'user4', 8),
            ],
          ),
        ),
      ),
    ),
  );
}

}



class ProfilePage extends StatelessWidget {

Widget info(String name) {
  return Container(
    width: 340,
    height: 144.24,
    child: Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            width: 106,
            height: 108,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('sax.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Positioned(
          left: 92.24,
          top: 71.76,
          child: Transform(
            transform: Matrix4.identity()
              ..translate(0.0, 0.0)
              ..rotateZ(0.28),
            child: Container(
              width: 54,
              height: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/piano.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 137,
          top: 2,
          child: Container(
            width: 197,
            height: 86,
            decoration: ShapeDecoration(
              color: Color(0xFFFAFAFA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(43.0), // Half of height for oval shape
                side: BorderSide(
                  width: 1,
                  color: Colors.black,
                  style: BorderStyle.solid,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 137,
          top: 2,
          child: Container(
            width: 197,
            height: 86,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 1.2, // Adjust the line spacing as needed
                  letterSpacing: 0.50,
                ),
                softWrap: true, // This property should be set here
              ),
            ),
          ),
        ),
      ],
    ),
  );
}


Widget Bio(String bio) {
  return Container(
    width: 355,
    height: 195,
    padding: const EdgeInsets.all(16), // Adjust the padding as needed
    clipBehavior: Clip.antiAlias,
    decoration: ShapeDecoration(
      color: Color(0xFFEDEDED),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            '$bio ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              height: 1.5, // Adjust the line spacing as needed
              letterSpacing: 0.10,
            ),
          ),
        ),
      ],
    ),
  );
}


String bio = "We can solve any instance of the minimum-cost circulation problem using a natural generalization of the Ford-Fulkerson augmenting path algorithm called cycle canceling.This algorithm is normally attributed to Morton Klein in 1967, but the key insights date back at least to A. N. Tolstoy’s studies of railway transportation networks in the late 1920s.";

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Color(0xFFFEF7FF),
      title: Center(
        child: Image.asset(
          'assets/logo.png',
          width: 150,
          height: 50,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage()));
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ],
    ),
    body: GestureDetector(
      onHorizontalDragEnd: (details) {
        // Check if the drag was from left to right
        if (details.primaryVelocity! > 0) {
          // Navigate to the menu page
          Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage()));
        }
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.all(0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40),
              info('user2user'),
              SizedBox(height: 100),
              Bio(bio),
            ],
          ),
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        // Navigate to the home page
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileSettings()));
      },
      child: Icon(Icons.mode_edit),
      backgroundColor: Colors.white, // Adjust the color as needed
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
  );
}


}



class ProfileSettings extends StatelessWidget {

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dobController = TextEditingController();

 Widget customInput(String labelText, TextEditingController controller, {bool isPassword = false, bool isDate = false, required BuildContext context}) {
    return Container(
      width: 210,
      height: 56,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 210,
            height: 56,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: ShapeDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Use a TextFormField for input
                        Expanded(
                          child: TextFormField(
                            obscureText: isPassword,
                            controller: controller,
                            onTap: () {
                              if (isDate) {
                                // Pass context to the _selectDate function
                                _selectDate(context, controller);
                              }
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: labelText, // Use the provided labelText
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFF49454F),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != DateTime.now()) {
      controller.text = picked.toLocal().toString().split(' ')[0];
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Color(0xFFFEF7FF),
      title: Center(
        child: Image.asset(
          'assets/logo.png',
          width: 150,
          height: 50,
        ),
      ),

    ),
      body: Stack(
        children: [
          // Image at the top-left
          Positioned(
            left: 10,
            top: 10,
            child: Image.asset(
              'assets/piano.jpg', // Replace with your image path
              height: 94,
              width: 87,
              fit: BoxFit.cover, // Adjust as needed
            ),
          ),
          // Container with edit icon at the bottom-right corner
          Positioned(
            top: 90,
            left: 90,
            child: EditIconContainer(),
          ),
          Positioned(
              top: 150,
              left: 150,
              child: customInput('Name', nameController, context: context),
            ),
            Positioned(
              top: 210,
              left: 150,
              child: customInput('Surname', surnameController, context: context),
            ),
            Positioned(
              top: 270,
              left: 150,
              child: customInput('Email', emailController, context: context),
            ),
            Positioned(
              top: 330,
              left: 150,
              child: customInput('New Password', passwordController, isPassword: true, context: context),
            ),
            Positioned(
              top: 390,
              left: 150,
              child: customInput('Date of Birth', dobController, isDate: true, context: context),
            ),
          Positioned(
          bottom: 10,
          left: 185,
          right: 185,
          child: Save_button(
            onPressed: () {
              print('Changes saved');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            buttonText: 'Save Changes',
          ),
        ),
        
        ],
      ),
    );
  }
}


Widget Save_button({
  required VoidCallback onPressed,
  required String buttonText,
  Widget? child,
}) {
  return Container(
    constraints: BoxConstraints(minWidth: 92),
    child: Expanded(
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Color(0xFF6750A4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0.10,
                letterSpacing: 0.10,
              ),
            ),
            if (child != null) SizedBox(width: 6), 
            if (child != null) child,
          ],
        ),
      ),
    ),
    ),
  );
}


class EditIconContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the home page
        Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage()));
      },
      child: Stack(
        children: [
          Container(
            width: 37,
            height: 40,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border(
                left: BorderSide(),
                top: BorderSide(),
                right: BorderSide(width: 8),
                bottom: BorderSide(width: 7),
              ),
            ),
          ),
          Positioned(
        bottom: 10,
        right: 10,
        child: Center(
          child: Icon(Icons.mode_edit),
        ),
      ),
        ],
      ),
    );
  }
}




class NewCoursePage1 extends StatelessWidget {



    TextEditingController coursename = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController description = TextEditingController();

 Widget customInput(String labelText, TextEditingController controller, {bool isPassword = false}) {
  return Container(
    width: 210,
    height: 56,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 210,
          height: 56,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    color: Color(0xFFE0E0E0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Add TextField for input
                      Expanded(
                        child: TextField(
                          obscureText: isPassword,
                          controller: controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: labelText, // Use the provided labelText
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFF49454F),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


Widget customdesc(String labelText, TextEditingController controller, {bool isPassword = false}) {
  return Container(
    width: 210,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 210,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: Color(0xFFE0E0E0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: TextField(
                        obscureText: isPassword,
                        controller: controller,
                        style: TextStyle(fontSize: 20),
                        maxLines: null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: labelText,
                          contentPadding: EdgeInsets.all(12.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFF49454F),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}





Widget CancelButton({
  required VoidCallback onPressed,
  required String buttonText,
  Widget? child,
}) {
  return Container(
    width: 120, // Increase the width as needed
    height: 40,
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Color(0xFF681F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4), // Adjust padding
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0.10,
                letterSpacing: 0.10,
              ),
            ),
            if (child != null) SizedBox(width: 6),
            if (child != null) child,
          ],
        ),
      ),
    ),
  );
}



    @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Color(0xFFFEF7FF),
      title: Center(
        child: Image.asset(
          'assets/logo.png',
          width: 150,
          height: 50,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage()));
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ],
    ),
    body: 
        Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Course name',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF6750A4),
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 0.10,
                  letterSpacing: 0.10,
                ),
            ),
            SizedBox(height: 30),
            customInput('Course name', coursename),
            SizedBox(height: 40),
            Text(
                'Category',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFF6750A4),
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0.10,
                    letterSpacing: 0.10,
                ),
            ),
            SizedBox(height: 30),
            customInput('Category', category),
            SizedBox(height: 40),
            Text(
                'Short Desctription',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFF6750A4),
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0.10,
                    letterSpacing: 0.10,
                ),
            ),
            SizedBox(height: 30),
            customdesc('Short Description', description),
            SizedBox(height:70),
            CancelButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage()));
              },
              buttonText: 'Cancel',
            ),
            SizedBox(height:20),
            CancelButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage2()));
              },
              buttonText: 'Continue',
            ),
          ], 
        ),
        ),    
  );
}
}

class _NewCoursePage2State extends State<NewCoursePage2> {
  List<Widget> chapterInputs = []; // List to store dynamically added CustomInputs


  TextEditingController Chapters = TextEditingController();



Widget customInput(String labelText, TextEditingController controller, BuildContext context, {bool isPassword = false}) {
  return Container(
    width: 400,
    height: 58,
    child: Row(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: ShapeDecoration(
              color: Color(0xFFE0E0E0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Add TextField for input
                Expanded(
                  child: TextField(
                    obscureText: isPassword,
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: labelText,
                    ),
                  ),
                ),
                SizedBox(width: 8), // Add some spacing between the input field and additional content
                // Use a Column for the text and icons
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Add the first line of text with clickable icon
                    Row(
                      children: [
                        Text(
                            'Edit info',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF6750A4),
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                height: 0.16,
                                letterSpacing: 0.10,
                            ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to the homepage
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            );
                          },
                          child: Icon(Icons.edit),
                        ),
                      ],
                    ),
                    // Add the second line of text with clickable icon
                    Row(
                      children: [
                        Text(
                            'Edit quiz',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF6750A4),
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                height: 0.16,
                                letterSpacing: 0.10,
                            ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to the homepage
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NewCoursePage3()),
                            );
                          },
                          child: Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}


Widget AddChapter({
  required VoidCallback onPressed,
  required String buttonText,
  Widget? child,
}) {
  return Container(
    height: 40,
    child: TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Color.fromARGB(255, 32, 11, 125), width: 2),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: TextStyle(
                color: Color.fromARGB(255, 32, 11, 125),
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0.12,
                letterSpacing: 0.10,
              ),
            ),
            if (child != null) SizedBox(width: 12),
            if (child != null) child,
          ],
        ),
      ),
    ),
  );
}

Widget CancelButton({
  required VoidCallback onPressed,
  required String buttonText,
  Widget? child,
}) {
  return Container(
    width: 92,
    height: 40,
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Color(0xFF681F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0.10,
                letterSpacing: 0.10,
              ),
            ),
            if (child != null) SizedBox(width: 6),
            if (child != null) child,
          ],
        ),
      ),
    ),
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Color(0xFFFEF7FF),
      title: Center(
        child: Image.asset(
          'assets/logo.png',
          width: 150,
          height: 50,
        ),
      ),
    ),
    body: Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            'Add Chapters',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF6750A4),
              fontSize: 20,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              height: 0.10,
              letterSpacing: 0.10,
            ),
          ),
          SizedBox(height: 30),
          //customInput('Chapter', Chapters, context),
          //SizedBox(height: 20),
          // Dynamically added CustomInputs
          ListView.builder(
            shrinkWrap: true,
            itemCount: chapterInputs.length,
            itemBuilder: (context, index) => Container(
              width: 200, // Set a fixed width for the dynamically added items
              child: chapterInputs[index],
            ),
          ),
          SizedBox(height: 20),
          AddChapter(
            onPressed: () {
              setState(() {
                chapterInputs.add(customInput('New Chapter', Chapters, context));
              });
            },
            buttonText: '+      Add Chapter',
          ),
          SizedBox(height: 20),
          CancelButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage1()));
            },
            buttonText: 'Cancel',
          ),
        ],
      ),
    ),
  );
}
}


class NewCoursePage2 extends StatefulWidget {
  @override
  _NewCoursePage2State createState() => _NewCoursePage2State();
}


class _NewCoursePage3State extends State<NewCoursePage3> {
  List<Widget> chapterInputs = []; // List to store dynamically added CustomInputs


  TextEditingController Questions = TextEditingController();



Widget customInput(String labelText, TextEditingController controller, BuildContext context, {bool isPassword = false}) {
  return Container(
    width: 390,
    height: 58,
    child: Row(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: ShapeDecoration(
              color: Color(0xFFE0E0E0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Add TextField for input
                Expanded(
                  child: TextField(
                    obscureText: isPassword,
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: labelText,
                    ),
                  ),
                ),
                SizedBox(width: 8), // Add some spacing between the input field and additional content
                // Use a Column for the text and icons
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Add the first line of text with clickable icon
                    Column(
                      children: [
                        SizedBox(height:8),
                        Text(
                            'Edit question',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF6750A4),
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                height: 0.16,
                                letterSpacing: 0.10,
                            ),
                        ),
                        SizedBox(height:10),
                        GestureDetector(
                          onTap: () {
                            // Navigate to the homepage
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Questiontype()),
                            );
                          },
                          child: Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}


Widget AddQuestion({
  required VoidCallback onPressed,
  required String buttonText,
  Widget? child,
}) {
  return Container(
    height: 40,
    child: TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Color.fromARGB(255, 32, 11, 125), width: 2),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: TextStyle(
                color: Color.fromARGB(255, 32, 11, 125),
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0.12,
                letterSpacing: 0.10,
              ),
            ),
            if (child != null) SizedBox(width: 12),
            if (child != null) child,
          ],
        ),
      ),
    ),
  );
}


Widget CancelButton({
  required VoidCallback onPressed,
  required String buttonText,
  Widget? child,
}) {
  return Container(
    width: 92,
    height: 40,
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Color(0xFF681F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0.10,
                letterSpacing: 0.10,
              ),
            ),
            if (child != null) SizedBox(width: 6),
            if (child != null) child,
          ],
        ),
      ),
    ),
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Color(0xFFFEF7FF),
      title: Center(
        child: Image.asset(
          'assets/logo.png',
          width: 150,
          height: 50,
        ),
      ),
    ),
    body: Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            'Add Questions',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF6750A4),
              fontSize: 20,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              height: 0.10,
              letterSpacing: 0.10,
            ),
          ),
          SizedBox(height: 30),
          ListView.builder(
            shrinkWrap: true,
            itemCount: chapterInputs.length,
            itemBuilder: (context, index) => Container(
              width: 200, // Set a fixed width for the dynamically added items
              child: chapterInputs[index],
            ),
          ),
          SizedBox(height: 20),
          AddQuestion(
            onPressed: () {
              setState(() {
                chapterInputs.add(customInput('Add Question', Questions, context));
              });
            },
            buttonText: '+      Add Question',
          ),
          SizedBox(height: 20),
          CancelButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage2()));
            },
            buttonText: 'Cancel',
          ),
        ],
      ),
    ),
  );
}
}


class NewCoursePage3 extends StatefulWidget {
  @override
  _NewCoursePage3State createState() => _NewCoursePage3State();
}



class Questiontype extends StatefulWidget {
  @override
  _Questiontype createState() => _Questiontype();
}

class _Questiontype extends State<Questiontype> {


    TextEditingController Questions = TextEditingController();


 Widget customInput(String labelText, TextEditingController controller, {bool isPassword = false}) {
  return Container(
    width: 210,
    height: 56,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 300,
          height: 56,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    color: Color(0xFFE0E0E0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          obscureText: isPassword,
                          controller: controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: labelText, // Use the provided labelText
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFF49454F),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


Widget CancelButton({
  required VoidCallback onPressed,
  required String buttonText,
  Widget? child,
}) {
  return Container(
    width: 92,
    height: 40,
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Color(0xFF681F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0.10,
                letterSpacing: 0.10,
              ),
            ),
            if (child != null) SizedBox(width: 6),
            if (child != null) child,
          ],
        ),
      ),
    ),
  );
}


  String selectedQuestionType = 'Select question type';
  TextEditingController question = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Color(0xFFFEF7FF),
      title: Center(
        child: Image.asset(
          'assets/logo.png',
          width: 150,
          height: 50,
        ),
      ),
    ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Add question',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFF6750A4),
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0.10,
                    letterSpacing: 0.10,
                ),
            ),
            SizedBox(height: 20),
            customInput('Question', question),
            SizedBox(height: 50),
            Text(
                'Select type of question',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFF6750A4),
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0.10,
                    letterSpacing: 0.10,
                ),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedQuestionType,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedQuestionType = newValue;
                  });
                }
              },
              items: <String>[
                'Select question type',
                'Select correct answer',
                'Left or Right',
                'Draw',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                    padding: EdgeInsets.all(12.0), // Add padding around the text
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200, // Add a light gray background color
                      borderRadius: BorderRadius.circular(8.0), // Add rounded corners
                    ),
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.black, // Change text color
                        fontSize: 16.0, // Change font size
                        fontWeight: FontWeight.w400, // Change font weight
                        fontFamily: 'Roboto', // Change font family
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 50),
            CancelButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage2()));
                print(selectedQuestionType);
              },
              buttonText: 'Cancel',
            ),
            SizedBox(height: 50),
            CancelButton(
              onPressed: () {
                if(selectedQuestionType == "Draw"){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Drawpage()));
                }
                else{
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage3()));
                }
                print(selectedQuestionType);
              },
              buttonText: 'Next',
            ),
          ],
        ),
      ),
    );
  }
}






class Triangle extends PaintContent {
  Triangle();

  Triangle.data({
    required this.startPoint,
    required this.A,
    required this.B,
    required this.C,
    required Paint paint,
  }) : super.paint(paint);

  factory Triangle.fromJson(Map<String, dynamic> data) {
    return Triangle.data(
      startPoint: jsonToOffset(data['startPoint'] as Map<String, dynamic>),
      A: jsonToOffset(data['A'] as Map<String, dynamic>),
      B: jsonToOffset(data['B'] as Map<String, dynamic>),
      C: jsonToOffset(data['C'] as Map<String, dynamic>),
      paint: jsonToPaint(data['paint'] as Map<String, dynamic>),
    );
  }

  Offset startPoint = Offset.zero;

  Offset A = Offset.zero;
  Offset B = Offset.zero;
  Offset C = Offset.zero;

  @override
  void startDraw(Offset startPoint) => this.startPoint = startPoint;

  @override
  void drawing(Offset nowPoint) {
    A = Offset(
        startPoint.dx + (nowPoint.dx - startPoint.dx) / 2, startPoint.dy);
    B = Offset(startPoint.dx, nowPoint.dy);
    C = nowPoint;
  }

  @override
  void draw(Canvas canvas, Size size, bool deeper) {
    final Path path = Path()
      ..moveTo(A.dx, A.dy)
      ..lineTo(B.dx, B.dy)
      ..lineTo(C.dx, C.dy)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  Triangle copy() => Triangle();

  @override
  Map<String, dynamic> toContentJson() {
    return <String, dynamic>{
      'startPoint': startPoint.toJson(),
      'A': A.toJson(),
      'B': B.toJson(),
      'C': C.toJson(),
      'paint': paint.toJson(),
    };
  }
}


class Drawpage extends StatefulWidget {
  const Drawpage({Key? key}) : super(key: key);

  @override
  State<Drawpage> createState() => _Drawpage();
}

class _Drawpage extends State<Drawpage> {
  final DrawingController _drawingController = DrawingController();

  @override
  void dispose() {
    _drawingController.dispose();
    super.dispose();
  }

  Future<void> _getImageData(BuildContext context) async {
    final Uint8List? data =
        (await _drawingController.getImageData())?.buffer.asUint8List();
    if (data == null) {
      debugPrint('beeee');
      return;
    }

    if (mounted) {
      showDialog<void>(
        context: context,
        builder: (BuildContext c) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: () => Navigator.pop(c), child: Image.memory(data)),
          );
        },
      );
    }
  }

  Future<void> _getJson(BuildContext context) async {
    showDialog<void>(
      context: context,
      builder: (BuildContext c) {
        return Center(
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () => Navigator.pop(c),
              child: Container(
                constraints:
                    const BoxConstraints(maxWidth: 500, maxHeight: 800),
                padding: const EdgeInsets.all(20.0),
                child: SelectableText(
                  const JsonEncoder.withIndent('  ')
                      .convert(_drawingController.getJsonList()),
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  
Widget SaveButton({
  required VoidCallback onPressed,
  required String buttonText,
  Widget? child,
}) {
  return Container(
    width: 92,
    height: 40,
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Color(0xFF681F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0.10,
                letterSpacing: 0.10,
              ),
            ),
            if (child != null) SizedBox(width: 6),
            if (child != null) child,
          ],
        ),
      ),
    ),
  );
}


@override
Widget build(BuildContext context) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
    backgroundColor: Colors.grey,
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: Color(0xFFFEF7FF),
      title: Center(
        child: Image.asset(
          'assets/logo.png',
          width: 150,
          height: 50,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage2()));
          },
        ),
      ],
    ),
    body: Column(
      children: <Widget>[
        Expanded(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return DrawingBoard(
                // boardPanEnabled: false,
                // boardScaleEnabled: false,
                controller: _drawingController,
                background: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  color: Colors.white,
                ),
                showDefaultActions: true,
                showDefaultTools: true,
                defaultToolsBuilder: (Type t, _) {
                  return DrawingBoard.defaultTools(t, _drawingController)
                    ..insert(
                      1,
                      DefToolItem(
                        icon: Icons.change_history_rounded,
                        isActive: t == Triangle,
                        onTap: () =>
                            _drawingController.setPaintContent(Triangle()),
                      ),
                    );
                },
              );
            },
          ),
        ),
      ],
    ),
  );
}

}
*/