<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'widgets/available_course.dart';
import 'profile_page.dart';
import 'menu_page.dart';
import 'widgets/category.dart';
import 'data/database_helper.dart';

<<<<<<< HEAD
class AvailableCourses extends StatefulWidget {
=======
String courseName = "Course Name";
String instructorName = "Instructor Name";
String courseInfo =
    "Short description of the course, probably mentions the prerequisites, if exist, and define the learning outcome";
String imageURL = "assets/course.jpg";

class AvailableCourses extends StatelessWidget {
>>>>>>> f7f5704 (add)
  final int userId;

  AvailableCourses({required this.userId});

  @override
  _AvailableCoursesState createState() => _AvailableCoursesState();
}

class _AvailableCoursesState extends State<AvailableCourses> {
  late Future<List<Map<String, dynamic>>> availableCourses;
  late Future<List<Map<String, dynamic>>> categories;

  Set<String> Categories = {};
  int courseToAdd = -1;

  void _updateCourses() {
    if (this.courseToAdd != -1)
      DatabaseHelper().enrollUserInCourse(widget.userId, this.courseToAdd);

    this.courseToAdd = -1;
    setState(() {
      this.availableCourses = DatabaseHelper().getAvailableCourses(
        widget.userId,
        this.Categories,
      );
    });
    print("available courses");
    print(availableCourses);
  }

  @override
  void initState() {
    super.initState();
    availableCourses = DatabaseHelper().getAvailableCourses(widget.userId, {});
    categories = DatabaseHelper().getAllCategories();
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
<<<<<<< HEAD
              print("AVAILABLE");
              availableCourses.then((courses) {
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
=======
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MenuPage(userId: userId)));
>>>>>>> f7f5704 (add)
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
<<<<<<< HEAD
                print("AVAILABLE");
                print(availableCourses);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProfilePage(userId: widget.userId)));
=======
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(userId: userId)));
>>>>>>> f7f5704 (add)
              },
            ),
          ],
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Available Courses',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
<<<<<<< HEAD
=======
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
                itemBuilder: (context, index) => AvailableCourse(
                    courseName, instructorName, courseInfo, imageURL, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CoursePage(
                              userId: userId,
                              courseId: 0,
                            )),
                  );
                }),
>>>>>>> f7f5704 (add)
              ),
            ),
          ),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: availableCourses,
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
                                    _updateCourses();
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
          SizedBox(height: 40),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: categories,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Map<String, dynamic>> categories = snapshot.data ?? [];
                print("categories");
                print(categories);
                return Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Container(
                    height: 120,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: (categories.length / 2).ceil(),
                      separatorBuilder: (context, index) => SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              CategoryWidget(
                                  label: categories[2 * index]['category'],
                                  onPressed: () {
                                    if (this.Categories.contains(
                                        categories[2 * index]['category'])) {
                                      this.Categories.remove(
                                          categories[2 * index]['category']);
                                    } else
                                      this.Categories.add(
                                          categories[2 * index]['category']);
                                    _updateCourses();
                                  }),
                              SizedBox(height: 20),
                              CategoryWidget(
                                  label: categories[2 * index + 1]['category'],
                                  onPressed: () {
                                    if (this.Categories.contains(
                                        categories[2 * index + 1]
                                            ['category'])) {
                                      this.Categories.remove(
                                          categories[2 * index + 1]
                                              ['category']);
                                    } else
                                      this.Categories.add(
                                          categories[2 * index + 1]
                                              ['category']);
                                    _updateCourses();
                                  }),
                            ],
                          ),
                        );
                      },
                    ),
<<<<<<< HEAD
                  ),
                );
              }
            },
=======
                  );
                },
              ),
            ),
>>>>>>> f7f5704 (add)
          ),
        ]));
  }
}
=======
import 'package:flutter/material.dart';
import 'widgets/available_course.dart';
import 'profile_page.dart';
import 'menu_page.dart';
import 'widgets/category.dart';
import 'data/database_helper.dart';

class AvailableCourses extends StatefulWidget {
  final int userId;

  AvailableCourses({required this.userId});

  @override
  _AvailableCoursesState createState() => _AvailableCoursesState();
}

class _AvailableCoursesState extends State<AvailableCourses> {
  late Future<List<Map<String, dynamic>>> availableCourses;
  late Future<List<Map<String, dynamic>>> categories;

  Set<String> Categories = {};
  int courseToAdd = -1;

  void _updateCourses() {
    if(this.courseToAdd != -1)
      DatabaseHelper().enrollUserInCourse(widget.userId, this.courseToAdd);

    this.courseToAdd = -1;
    setState(() {
      this.availableCourses = DatabaseHelper().getAvailableCourses(
        widget.userId,
        this.Categories,
      );
    });
  }


  @override
  void initState() {
    super.initState();
    availableCourses = DatabaseHelper().getAvailableCourses(widget.userId, {});
    categories = DatabaseHelper().getAllCategories();
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
                        builder: (context) => ProfilePage(userId: widget.userId)));
              },
            ),
          ],
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          // Display unenrolled courses
          FutureBuilder<List<Map<String, dynamic>>>(
            future: availableCourses,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }else {
                List<Map<String, dynamic>> courses = snapshot.data ?? [];

                return Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Container(
                    height: 460,
                    child: courses.isNotEmpty
                        ? ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: courses.length,
                      separatorBuilder: (context, _) => SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        return AvailableCourse(
                          courses[index]['title'],
                          courses[index]['name'],
                          courses[index]['description'],
                          courses[index]['image_url'],
                              () {
                            this.courseToAdd = courses[index]['id'];
                            _updateCourses();
                          },
                        );
                      },
                    )
                        : Container(), // Empty container if no courses
                  ),
                );
              }
            },
          ),
          SizedBox(height: 40),
          // Display distinct categories
          FutureBuilder<List<Map<String, dynamic>>>(
            future: categories,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Map<String, dynamic>> categories = snapshot.data ?? [];
                print("categories");
                print(categories);
                return Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Container(
                    height: 120,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: (categories.length / 2).ceil(),
                      separatorBuilder: (context, index) => SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        // Use data from the query to build Category widget
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              CategoryWidget(label: categories[2 * index]['category'],onPressed:  () {
                                if(this.Categories.contains(categories[2 * index]['category'])){
                                  this.Categories.remove(categories[2 * index]['category']);
                                }
                                else this.Categories.add(categories[2 * index]['category']);
                                _updateCourses();
                              }),
                              SizedBox(height: 20),
                              CategoryWidget(label: categories[2*index + 1]['category'],onPressed:  () {
                                if(this.Categories.contains(categories[2 * index+1]['category'])){
                                  this.Categories.remove(categories[2 * index+1]['category']);
                                }
                                else this.Categories.add(categories[2 * index+1]['category']);
                                _updateCourses();
                              }),
                            ],
                          ),
                        );


                      },
                    ),
                  ),
                );
              }
            },
          ),
        ]));
  }
}
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
