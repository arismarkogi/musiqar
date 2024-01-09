import 'package:flutter/material.dart';
import 'homepage.dart';
import 'menu_page.dart';
import 'widgets/custom_input.dart';
import 'widgets/cancel_button.dart';
import 'question_type.dart';
import 'new_course_page3.dart';
import 'widgets/input_unchangeable.dart';
import 'drawpage.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:io';
import 'new_course_page6.dart';
import 'data/database_helper.dart';

class NewCoursePage7 extends StatefulWidget {
  final int userId;
  final String imagePath;
  final int courseId;
  final int chapterId;
  final int questionId;

  NewCoursePage7(
      {required this.userId,
      required this.courseId,
      required this.chapterId,
      required this.imagePath,
      required this.questionId,
      Key? key})
      : super(key: key);

  @override
  _NewCoursePage7State createState() => _NewCoursePage7State();
}

class _NewCoursePage7State extends State<NewCoursePage7> {
  TextEditingController question = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController description = TextEditingController();
  String selectedAnswer = 'Select correct answer';

  Future<Map<String, dynamic>> _fetchQuestion() async {
    List<Map<String, dynamic>> questions =
        await DatabaseHelper().getAllQuestions();
    return questions
            .firstWhere((question) => question['id'] == widget.questionId) ??
        {};
  }

  @override
  void initState() {
    super.initState();
    _fetchQuestion();
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
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Text(
                'Add Question',
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
              FutureBuilder<Map<String, dynamic>>(
                future: _fetchQuestion(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error loading question.');
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Text('No question found.');
                  } else {
                    String questionText = snapshot.data?['title'] ?? '';
                    TextEditingController myController =
                        TextEditingController();
                    myController.text = questionText;
                    return customInput_un(questionText, myController,
                        context: context);
                  }
                },
              ),
              SizedBox(height: 40),
              SizedBox(height: 50),
              Text(
                'Select type of question',
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
              customInput_un('Draw', question, context: context),
              SizedBox(height: 30),
              Container(
                width: 350,
                height: 350,
                child: Image.file(File(widget.imagePath)),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewCoursePage6(
                                userId: widget.userId,
                                courseId: widget.courseId,
                                chapterId: widget.chapterId,
                                questionId: widget.questionId,
                              )));
                },
                child: Icon(
                  Icons.edit,
                  size: 30,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 70),
              CancelButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewCoursePage3(
                              userId: widget.userId,
                              courseId: widget.courseId,
                              chapterId: widget.chapterId,
                              questionType: 'Draw')));
                },
                buttonText: 'Cancel',
              ),
              SizedBox(height: 20),
              CancelButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewCoursePage3(
                              userId: widget.userId,
                              courseId: widget.courseId,
                              chapterId: widget.chapterId,
                              questionType: 'Draw')));
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
