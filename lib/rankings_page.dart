import 'package:flutter/material.dart';
import 'menu_page.dart';
import 'homepage.dart';
import 'widgets/ranking.dart';



class RankingsPage extends StatelessWidget {




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