import 'package:flutter/material.dart';
import 'profile_settings.dart';
import 'homepage.dart';
import 'menu_page.dart';
import 'widgets/bio.dart';
import 'widgets/info.dart';

class ProfilePage extends StatelessWidget {

  final Map<String, dynamic> userData;

  ProfilePage({required this.userData});

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
          if (details.primaryVelocity! > 0) {
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
                info(userData['name']),
                SizedBox(height: 100),
                Bio(userData['bio']),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileSettings(userData: userData,)));
        },
        child: Icon(Icons.mode_edit),
        backgroundColor: Colors.white, 
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }


}