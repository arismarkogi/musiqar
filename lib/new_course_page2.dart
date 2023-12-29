import 'package:flutter/material.dart';
import 'menu_page.dart';
import 'homepage.dart';
import 'new_course_page1.dart';
import 'new_course_page3.dart';
import 'widgets/add_chapter.dart';
import 'widgets/cancel_button.dart';
import 'course_settings.dart';


class ChapterInfo {
  TextEditingController controller;
  String title;

  ChapterInfo({required this.controller, required this.title});
}


class _NewCoursePage2State extends State<NewCoursePage2> {
  List<ChapterInfo> chapterInputs = [];

  Widget inputChapter(String labelText, TextEditingController controller, BuildContext context, {bool isPassword = false}) {
    return Container(
      width: 400,
      height: 58,
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                color: Color(0xFFE0E0E0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      obscureText: isPassword,
                      controller: controller,
                      onChanged: (text) {
                        setState(() {
                          // Update the title in the ChapterInfo
                          chapterInputs.firstWhere((info) => info.controller == controller).title = text;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: labelText,
                      ),
                    ),
                  ),
                  SizedBox(width: 8), 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Edit info',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF6750A4),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              height: 0.16,
                              letterSpacing: 0.10,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FileUploadPage()),
                              );
                            },
                            child: Icon(Icons.edit),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Edit quiz',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF6750A4),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              height: 0.16,
                              letterSpacing: 0.10,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => NewCoursePage3()),
                              );
                            },
                            child: Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Add Chapters',
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
              ListView.builder(
                shrinkWrap: true,
                itemCount: chapterInputs.length,
                itemBuilder: (context, index) => Container(
                  width: 200,
                  child: inputChapter('New Chapter', chapterInputs[index].controller, context),
                ),
              ),
              SizedBox(height: 20),
              AddChapter(
                onPressed: () {
                  setState(() {
                    TextEditingController newController = TextEditingController();
                    chapterInputs.add(ChapterInfo(controller: newController, title: ''));
                  });
                },
                buttonText: '+      Add Chapter',
              ),
              SizedBox(height: 20),
              CancelButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage1()));
                },
                buttonText: 'Cancel',
              ),
              SizedBox(height: 20),
              CancelButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage()));
                },
                buttonText: 'Save',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewCoursePage2 extends StatefulWidget {
  @override
  _NewCoursePage2State createState() => _NewCoursePage2State();
}


