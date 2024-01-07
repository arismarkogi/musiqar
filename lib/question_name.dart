import 'package:flutter/material.dart';
import 'package:flutter_application_1/new_course_page6.dart';
import 'new_course_page3.dart';
import 'new_course_page4.dart';
import 'new_course_page5.dart';
import 'widgets/custom_input.dart';
import 'question_type.dart';
import 'widgets/cancel_button.dart';


import 'drawpage.dart';

class QuestionName extends StatefulWidget {
  final int userId;
  final int courseId;
  final int chapterId;

  QuestionName({required this.userId, required this.courseId, required this.chapterId});

  @override
  _QuestionName createState() => _QuestionName();
}

class _QuestionName extends State<QuestionName> {


  TextEditingController Questions = TextEditingController();




  String selectedQuestionType = 'Select question type';
  TextEditingController question = TextEditingController();

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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add question',
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
            customInput('Question', question, context: context),
            
            SizedBox(height: 50, width: 150),
            CancelButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Questiontype(userId: widget.userId, courseId: widget.courseId, chapterId: widget.chapterId,)));
                print(selectedQuestionType);
              },
              buttonText: 'Cancel',
            ),
            SizedBox(height: 50, width: 150),
            CancelButton(
              onPressed: () {
                if(selectedQuestionType == "Draw"){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage6(userId: widget.userId, courseId: widget.courseId, chapterId: widget.chapterId)));
                }
                else if(selectedQuestionType == "Select correct answer"){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage4(userId: widget.userId, courseId: widget.courseId, chapterId: widget.chapterId)));
                }
                else if(selectedQuestionType == "Left or Right"){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage5(userId: widget.userId, courseId: widget.courseId, chapterId: widget.chapterId)));
                }
                else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Select question type.'),
                      ),
                    );
                }
                print(selectedQuestionType);
              },
              buttonText: 'Next',
            ),
          ],
        ),
      ),
    );
  }
}


