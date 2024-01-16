import 'package:flutter/material.dart';
import 'widgets/available_course.dart';
import 'profile_page.dart';
import 'menu_page.dart';
import 'widgets/category.dart';
import 'data/database_helper.dart';

class InstructorCourse extends StatefulWidget {
  final int userId;

  InstructorCourse({required this.userId});

  @override
  _InstructorCourseState createState() => _InstructorCourseState();
}

class _InstructorCourseState extends State<InstructorCourse> {
  late Future<List<Map<String, dynamic>>> allCourses;

  int courseToAdd = -1;

  void _deleteCourses() {
    if (this.courseToAdd != -1)
      DatabaseHelper().enrollUserInCourse(widget.userId, this.courseToAdd);

    this.courseToAdd = -1;
    setState(() {
      this.allCourses = DatabaseHelper().getInstructorCourses(
        widget.userId
      );
    });
    print("available courses");
    print(allCourses);
  }

  @override
  void initState() {
    super.initState();
    allCourses = DatabaseHelper().getInstructorCourses(widget.userId);
  }

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
              print("AVAILABLE");
              allCourses.then((courses) {
                print('Available Courses:');
                for (var course in courses) {
                  print('Course ID: ${course['id']}');
                  print('Title: ${course['title']}');
                  print('Description: ${course['description']}');
                  print('Instructor: ${course['name']}');
                  print('Image URL: ${course['image_url']}');
                  print('------------------------');
                }
              }).catchError((error) {
                print('Error fetching available courses: $error');
              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MenuPage(userId: widget.userId)));
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProfilePage(userId: widget.userId)));
              },
            ),
          ],
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'My courses as instructor',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: allCourses,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Map<String, dynamic>> courses = snapshot.data ?? [];

                return Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Container(
                    height: 460,
                    child: courses.isNotEmpty
                        ? ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: courses.length,
                            separatorBuilder: (context, _) =>
                                SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              if (index < courses.length) {
                                return AvailableCourse(
                                  courses[index]['title'],
                                  courses[index]['name'] ?? " ",
                                  courses[index]['description'],
                                  courses[index]['image_url'],
                                  () {
                                    this.courseToAdd = courses[index]['id'];
                                    _deleteCourses();
                                  },
                                );
                              } else {
                                return Container();
                              }
                            },
                          )
                        : Container(),
                  ),
                );
              }
            },
          ),
        ]));
  }
}
