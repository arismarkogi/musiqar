<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> f7f5704 (add)
import 'package:flutter/material.dart';
import 'signin_page.dart';
import 'menu_page.dart';
import 'swipe_right_page.dart';
import 'data/database_helper.dart';

class AdminPage extends StatelessWidget {
  final int userId;

  AdminPage({required this.userId});

  final DatabaseHelper dbHelper = DatabaseHelper();

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
                    MaterialPageRoute(
                        builder: (context) => MenuPage(userId: userId)),
                  );
                },
                child: Text('Menu'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
<<<<<<< HEAD
=======
                  // Inside a button's onPressed handler or another relevant part of your app
>>>>>>> f7f5704 (add)
                  List<Map<String, dynamic>> users =
                      await dbHelper.getAllUsers();
                  print(users);
                },
                child: Text('See data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
<<<<<<< HEAD
=======
import 'package:flutter/material.dart';
import 'signin_page.dart';
import 'menu_page.dart';
import 'swipe_right_page.dart';
import 'data/database_helper.dart';

class AdminPage extends StatelessWidget {
  final int userId;

  AdminPage({required this.userId});

  final DatabaseHelper dbHelper = DatabaseHelper();

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
                    MaterialPageRoute(
                        builder: (context) => MenuPage(userId: userId)),
                  );
                },
                child: Text('Menu'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Inside a button's onPressed handler or another relevant part of your app
                  List<Map<String, dynamic>> users =
                      await dbHelper.getAllUsers();
                  print(users);
                },
                child: Text('See data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
=======
>>>>>>> f7f5704 (add)
