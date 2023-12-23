import 'package:flutter/material.dart';
import 'signin_page.dart';
import 'rankings_page.dart';
import 'profile_settings.dart';
import 'drawpage.dart';
import 'new_course_page1.dart';
import 'widgets/menu_item.dart';
import 'widgets/sline.dart';
import 'widgets/menu_logo.dart';


class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
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
          buildMenuItem(context, 'New course', NewCoursePage1()),// Replace NewCoursePage() with the actual page widget
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



}
