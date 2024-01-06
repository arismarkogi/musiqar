import 'package:flutter/material.dart';
import 'package:flutter_application_1/new_course_page6.dart';
import 'new_course_page2.dart';
import 'new_course_page3.dart';
import 'new_course_page4.dart';
import 'new_course_page5.dart';
import 'widgets/custom_input.dart';
import 'widgets/cancel_button.dart';


import 'drawpage.dart';

class Questiontype extends StatefulWidget {
  final int userId;
  final int courseId;

  Questiontype({required this.userId, required this.courseId});

  @override
  _Questiontype createState() => _Questiontype();
}

class _Questiontype extends State<Questiontype> {


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
            /*
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
            SizedBox(height: 50),*/
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
            DropdownButton<String>(
              value: selectedQuestionType,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedQuestionType = newValue;
                  });
                }
              },
              items: <String>[
                'Select question type',
                'Select correct answer',
                'Left or Right',
                'Draw',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                    padding: EdgeInsets.all(12.0), 
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200, 
                      borderRadius: BorderRadius.circular(8.0),  
                    ),
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.black, 
                        fontSize: 16.0,  
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto', 
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 50, width: 150),
            /*CancelButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage3(userId: widget.userId, courseId: widget.courseId)));
                print(selectedQuestionType);
              },
              buttonText: 'Cancel',
            ),*/
            CancelButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage2(userId: widget.userId, courseId: widget.courseId)));
                print(selectedQuestionType);
              },
              buttonText: 'Cancel',
            ),
            SizedBox(height: 50, width: 150),
            /*CancelButton(
              onPressed: () {
                if(selectedQuestionType == "Draw"){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage6(userId: widget.userId, courseId: widget.courseId)));
                }
                else if(selectedQuestionType == "Select correct answer"){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage4(userId: widget.userId, courseId: widget.courseId)));
                }
                else if(selectedQuestionType == "Left or Right"){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage5(userId: widget.userId, courseId: widget.courseId)));
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
            ),*/
            CancelButton(
              onPressed: () {
                if(selectedQuestionType == "Draw"){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage3(userId: widget.userId, courseId: widget.courseId, questionType: "Draw",)));
                }
                else if(selectedQuestionType == "Select correct answer"){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage3(userId: widget.userId, courseId: widget.courseId, questionType: "Select")));
                }
                else if(selectedQuestionType == "Left or Right"){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage3(userId: widget.userId, courseId: widget.courseId, questionType: "RorL",)));
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


