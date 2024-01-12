import 'package:flutter/material.dart';
import 'package:musIQAR/profile_page.dart';
import 'signin_page.dart';
import 'rankings_page.dart';
import 'profile_page.dart';
import 'profile_settings.dart';
import 'drawpage.dart';
import 'new_course_page1.dart';
import 'widgets/menu_item.dart';
import 'widgets/sline.dart';
import 'widgets/menu_logo.dart';
import 'adminpage.dart';
import 'data/database_helper.dart';
import 'available_courses.dart';
import 'mycourses.dart';

class MenuPage extends StatefulWidget {
  final int userId;

  MenuPage({required this.userId});

  Future<Map<String, dynamic>> _fetchUserData() async {
    List<Map<String, dynamic>> users = await DatabaseHelper().getAllUsers();
    return users.firstWhere((user) => user['id'] == userId);
  }

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
          const SizedBox(height: 70),
          buildMenuItem(
              context, 'My Courses', MyCourses(userId: widget.userId)),
          const SizedBox(height: 25),
          sline(),
          const SizedBox(height: 45),
          buildMenuItem(context, 'Available Courses',
              AvailableCourses(userId: widget.userId)),
          const SizedBox(height: 25),
          sline(),
          const SizedBox(height: 45),
          buildMenuItem(
              context, 'Rankings', RankingsPage(userId: widget.userId)),
          const SizedBox(height: 25),
          sline(),
          const SizedBox(height: 45),
          buildMenuItem(
              context,
              'User profile',
              ProfilePage(
                userId: widget.userId,
              )),
          const SizedBox(height: 25),
          sline(),
          const SizedBox(height: 45),
          buildMenuItem(context, 'New course',
              NewCoursePage1(userId: widget.userId, courseId: -1)),
          const SizedBox(height: 25),
          sline(),
          const SizedBox(height: 45),
          buildMenuItem(
              context, 'Admin page', AdminPage(userId: widget.userId)),
          const SizedBox(height: 25),
          sline(),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Image.asset(
                  'assets/logo.png',
                  width: 200,
                  height: 70,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
