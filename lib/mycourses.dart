import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'menu_page.dart';
import 'widgets/mycourse.dart';
import 'course_page.dart';

// Default values for AvailableCourse
String courseName = "Course Name";
String instructorName = "Instructor Name";
String imageURL = "assets/course.jpg";




class MyCourses extends StatelessWidget {

  final int userId;

  MyCourses({required this.userId});

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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MenuPage(userId: userId)));
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage(userId: userId)));
              },
            ),
          ],
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'My Courses',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                  child: ListView.separated(
                    itemCount: 20,
                    separatorBuilder: (context, _) => SizedBox(height: 8),
                    itemBuilder: (context, index) => SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8, 
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20), 
                          child: myCourse(courseName, instructorName, imageURL, 0.42,() {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CoursePage(userId: userId, courseId: 0,)));
                          } )
                      ),
                    ),
                  )
              )
            ]
        )
    );
  }
}