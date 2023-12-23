
import 'package:flutter/material.dart';
import 'signin_page.dart';
import 'menu_page.dart';
import 'swipe_right_page.dart';




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