import 'package:flutter/material.dart';
import 'homepage.dart';
import 'menu_page.dart';
import 'widgets/custom_input.dart';
import 'widgets/cancel_button.dart';
import 'widgets/custom_desc.dart';
import 'new_course_page2.dart';
import 'profile_page.dart';
import 'course_info_provider.dart';
import 'package:provider/provider.dart';
import 'data/database_helper.dart';


class NewCoursePage1 extends StatefulWidget {
  final int userId;
  final int courseId;

  NewCoursePage1({required this.userId, required this.courseId});

  @override
  _NewCoursePage1State createState() => _NewCoursePage1State();
}

class _NewCoursePage1State extends State<NewCoursePage1> {
  //final int userId;
  //final int courseId;

  //NewCoursePage1({required this.userId, required this.courseId});

  TextEditingController coursename = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController instructor = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCourseData();
  }

  Future<Map<String, dynamic>> _fetchUserData() async {
  List<Map<String, dynamic>> users = await DatabaseHelper().getAllUsers();
  return users.firstWhere((user) => user["id"] == widget.userId) ?? {};
}

Future<void> _fetchCourseData() async {
  print("to prospatho");
  if (widget.courseId == -1){
    setState((){
      coursename.text = "";
      category.text = "";
      description.text = "";
  });
  }
  else {
    List<Map<String, dynamic>> courses = await DatabaseHelper().getAllCourses();
    Map<String, dynamic> courseData = courses.firstWhere((course) => course['id'] == widget.courseId);
    setState((){
      coursename.text = courseData['title'] ?? "";
      category.text = courseData['category'] ?? "";
      description.text = courseData['description'] ?? "";
  });
  }
  
}



  @override
  Widget build(BuildContext context) {
   /* if (courseId == -1) {
      coursename.text = "";
      category.text = "";
      description.text = "";
    } else {
      _fetchCourseData().then((courseData) {
        coursename.text = courseData['courseName'] ?? "";
        category.text = courseData['category'] ?? "";
        description.text = courseData['description'] ?? "";
      });
    }*/
    _fetchUserData();
    _fetchCourseData();
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage(userId: widget.userId)));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(userId: widget.userId)));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Course name',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF6750A4),
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 0.10,
                  letterSpacing: 0.10,
                ),
              ),
              SizedBox(height: 30),
              customInput('Course name', coursename, context: context),
              SizedBox(height: 40),
              Text(
                'Category',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF6750A4),
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 0.10,
                  letterSpacing: 0.10,
                ),
              ),
              SizedBox(height: 30),
              customInput('Category', category, context: context),
              SizedBox(height: 40),
              Text(
                'Short Desctription',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF6750A4),
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 0.10,
                  letterSpacing: 0.10,
                ),
              ),
              SizedBox(height: 30),
              customdesc('Short Description', description),
              SizedBox(height: 70),
              CancelButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage(userId: widget.userId)));
                },
                buttonText: 'Cancel',
              ),
              SizedBox(height: 20),

              /*CancelButton(
                onPressed: () {
                  Future<void> yourFunctionName() async {
                 Map<String, dynamic> userData = await _fetchUserData();

                String instructorText = userData['name'] + ' ' + userData['surname'];
                print("instructor");
                print(instructorText);

                int courseId = await DatabaseHelper().newcourse({
                  'title': coursename,
                  'category': category,
                  'description': description,
                  'instructor': instructorText,
                });
                print("the courseId is equal to");
                print(courseId);
                if (courseId == -1) {
                  print('Failed to insert course into the database');
                  return;
                }

              }
                  /*courseProvider.updateCourseInfo(
                    coursename.text,
                    category.text,
                    description.text,
                  );*/

                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage2(userId: userId, courseId: courseId)));
                },
                buttonText: 'Continue',
              ),*/
              CancelButton(
                onPressed: () async {
                  int newcourseid = await insertcourse(); 
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage2(userId: widget.userId, courseId: newcourseid)));
                },
                buttonText: 'Continue',
              ),
            ],
          ),
        ),
      ),
    );
  }

  
Future<int> insertcourse() async {
  Map<String, dynamic> userData = await _fetchUserData();

  String instructorText = userData['name'] + ' ' + userData['surname'];
  print("instructor");
  print(instructorText);

  int courseId = await DatabaseHelper().newcourse({
    'title': coursename.text,
    'category': category.text,
    'description': description.text,
    'instructor': instructorText,
  });
  print("the courseId is equal to");
  print(courseId);
  if (courseId == -1) {
    print('Failed to insert course into the database');
    return -1;
  }
  return courseId;
}
}
