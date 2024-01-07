import 'dart:ffi';

import 'package:flutter/material.dart';
import 'menu_page.dart';
import 'homepage.dart';
import 'widgets/ranking.dart';
import 'profile_page.dart';
import 'data/database_helper.dart'; 
class RankingsPage extends StatelessWidget {
  final int userId;

  RankingsPage({required this.userId});

  Future<List<Map<String, dynamic>>> _fetchUserData() async {
    List<Map<String, dynamic>> users = await DatabaseHelper().getAllUsers();
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.primaryDelta! > 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => 
            MenuPage(userId: userId)),
          );
        }
      },
      child: Scaffold(
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage(userId: userId)));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(userId: userId)));
            },
          ),
        ],
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage(userId: userId)));
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: _fetchUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No users found.');
                    } else {
                      List<Map<String, dynamic>> users = snapshot.data!;
                      List<Widget> rankingWidgets = [];
                      for (int i = 0; i < users.length; i++) {
                        rankingWidgets.add(
                          ranking(
                            i + 1,
                            users[i]['name'],
                            users[i]['points'],
                            isCurrentUser: users[i]['id'] == userId,
                          ),
                        );
                      }
                      return Column(children: rankingWidgets);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}
