import 'package:flutter/material.dart';
import 'course_page.dart';
import 'widgets/available_course.dart';
import 'profile_page.dart';
import 'menu_page.dart';
import 'widgets/category.dart';

// Default values for AvailableCourse
String courseName = "Course Name";
String instructorName = "Instructor Name";
String courseInfo = "Short description of the course, probably mentions the prerequisites, if exist, and define the learning outcome";
String imageURL = "assets/course.jpg";




class AvailableCourses extends StatelessWidget {

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
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
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
            padding: EdgeInsets.only(left: 16.0), // Adjust left padding as needed
            child: Container(
              height: 460,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                separatorBuilder: (context, _) => SizedBox(width: 8),
                itemBuilder: (context, index) => AvailableCourse(courseName, instructorName, courseInfo, imageURL,() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CoursePage()),
                  );

                }
                ),
              ),
            ),
          ),
          SizedBox(height: 60),
          Padding(
            padding: EdgeInsets.only(left: 16.0), // Adjust left padding as needed
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
                          // Action for first button in column
                          print('Button ${index * 2 + 1} pressed');
                        }),
                        SizedBox(height: 8),
                        Category('Category ${index * 2 + 2}', () {
                          // Action for second button in column
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
    // Other widgets or sections in the body can be added below
  }
}
