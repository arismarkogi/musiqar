import 'package:flutter/material.dart';
import 'homepage.dart';
import 'menu_page.dart';
import 'widgets/custom_input.dart';
import 'widgets/cancel_button.dart';
import 'widgets/custom_desc.dart';
import 'new_course_page2.dart';
import 'profile_page.dart';
import 'data/database_helper.dart';
import 'package:vibration/vibration.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class NewCoursePage1 extends StatefulWidget {
  final int userId;
  final int courseId;

  NewCoursePage1({required this.userId, required this.courseId});

  @override
  _NewCoursePage1State createState() => _NewCoursePage1State();
}

class _NewCoursePage1State extends State<NewCoursePage1> {
  TextEditingController coursename = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController instructor = TextEditingController();
  File? selectedImage;
  String? selectedImagePath;

  bool validateInputs() {
    if (coursename.text.isEmpty ||
        category.text.isEmpty ||
        description.text.isEmpty) {
      Vibration.vibrate(duration: 500);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _fetchCourseData();
  }

  Future<Map<String, dynamic>> _fetchUserData() async {
    List<Map<String, dynamic>> users = await DatabaseHelper().getAllUsers();
    return users.firstWhere((user) => user["id"] == widget.userId) ?? {};
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
        selectedImagePath = pickedFile.path;
      });
    }
  }

  Future<void> _fetchCourseData() async {
    if (widget.courseId == -1) {
      setState(() {
        coursename.text = "";
        category.text = "";
        description.text = "";
      });
    } else {
      List<Map<String, dynamic>> courses =
          await DatabaseHelper().getAllCourses();
      Map<String, dynamic> courseData =
          courses.firstWhere((course) => course['id'] == widget.courseId);
      setState(() {
        coursename.text = courseData['title'] ?? "";
        category.text = courseData['category'] ?? "";
        description.text = courseData['description'] ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _fetchUserData();
    _fetchCourseData();
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.primaryDelta! > 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MenuPage(userId: widget.userId)),
          );
        }
      },
      child: Scaffold(
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
                        builder: (context) =>
                            ProfilePage(userId: widget.userId)));
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
                  'Image',
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
                SizedBox(height: 20),
                Container(
                  width: 200,
                  height: 200,
                  child: selectedImage != null
                      ? Image.file(
                          selectedImage!,
                          height: 94,
                          width: 87,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.add_a_photo,
                          size: 20,
                          color: Colors.blueAccent,
                        ),
                ),
                InkWell(
                  onTap: () => _pickImage(),
                  child: Icon(
                    Icons.edit,
                    size: 25,
                    color: Colors.blueAccent,
                  ),
                ),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MenuPage(userId: widget.userId)));
                  },
                  buttonText: 'Cancel',
                ),
                SizedBox(height: 20),
                CancelButton(
                  onPressed: () async {
                    if (validateInputs()) {
                      int newcourseid = await insertcourse();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewCoursePage2(
                                userId: widget.userId, courseId: newcourseid)),
                      );
                    }
                  },
                  buttonText: 'Continue',
                ),
              ],
            ),
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
      'instructor': userData['id'],//instructorText,
      'image_url' : selectedImagePath
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
