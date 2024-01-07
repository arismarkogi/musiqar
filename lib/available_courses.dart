import 'package:flutter/material.dart';
import 'course_page.dart';
import 'widgets/available_course.dart';
import 'profile_page.dart';
import 'menu_page.dart';
import 'widgets/category.dart';

String courseName = "Course Name";
String instructorName = "Instructor Name";
String courseInfo = "Short description of the course, probably mentions the prerequisites, if exist, and define the learning outcome";
String imageURL = "assets/course.jpg";




class AvailableCourses extends StatelessWidget {

  final int userId;

  AvailableCourses({required this.userId});

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
    body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Available Courses',
              style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              ),
            ),
         ),
          Padding(
            padding: EdgeInsets.only(left: 16.0), 
            child: Container(
              height: 460,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                separatorBuilder: (context, _) => SizedBox(width: 8),
                itemBuilder: (context, index) => AvailableCourse(courseName, instructorName, courseInfo, imageURL,() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CoursePage(userId: userId, courseId: 0,)),
                  );

                }
                ),
              ),
            ),
          ),
          SizedBox(height: 60),
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Container(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                separatorBuilder: (context, index) => SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Category('Category ${index * 2 + 1}', () {
                          print('Button ${index * 2 + 1} pressed');
                        }),
                        SizedBox(height: 8),
                        Category('Category ${index * 2 + 2}', () {
                          print('Button ${index * 2 + 2} pressed');
                        }),
                      ],
                    ),
                  );
                },
              ),
            ),


          ),
        ]
      )
    );
  }
}
