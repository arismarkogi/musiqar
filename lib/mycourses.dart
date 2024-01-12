import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'menu_page.dart';
import 'widgets/mycourse.dart';
import 'course_page.dart';
import 'data/database_helper.dart'; // Import your database helper class

class MyCourses extends StatefulWidget {
  final int userId;

  MyCourses({required this.userId});

  @override
  _MyCoursesState createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  late Future<List<Map<String, dynamic>>> enrolledCourses;

  @override
  void initState() {
    super.initState();
    enrolledCourses = DatabaseHelper().getEnrolledCourses(widget.userId);
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MenuPage(userId: widget.userId),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(userId: widget.userId),
                ),
              );
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
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: enrolledCourses,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No enrolled courses'));
                } else {
                  return ListView.separated(
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (context, _) => SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      var course = snapshot.data![index];
                      print('Building course item: $course');
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: myCourse(
                            course['title'],
                            course['name'],
                            course['image_url'],
                            course['completed_chapters'] / course['total_chapters'].toDouble(),
                                () {
                              print('Tapped on course: $course');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CoursePage(
                                    userId: widget.userId,
                                    courseId: course['id'],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },

                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
