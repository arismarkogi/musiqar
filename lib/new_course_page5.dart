import 'package:flutter/material.dart';
import 'homepage.dart';
import 'menu_page.dart';
import 'widgets/custom_input.dart';
import 'widgets/cancel_button.dart';
import 'question_type.dart';
import 'new_course_page3.dart';


class NewCoursePage5 extends StatefulWidget {

  final int userId;
  final int courseId;

  NewCoursePage5({required this.userId, required this.courseId});

  @override
  _NewCoursePage5 createState() => _NewCoursePage5();
}

class _NewCoursePage5 extends State<NewCoursePage5> {

  TextEditingController Questions = TextEditingController();




  String selectedAnswer = 'Select correct answer';

  TextEditingController question = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController description = TextEditingController();

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
            Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage(userId: widget.userId)));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Left or Right',
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
              SizedBox(height: 70),
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
              customInput('Question', question, context: context),
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
              DropdownButton<String>(
                value: selectedAnswer,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedAnswer = newValue;
                    });
                  }
                },
                items: <String>[
                  'Select correct answer',
                  'Left', 
                  'Right',
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
              SizedBox(height: 70),

              CancelButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Questiontype(userId: widget.userId, courseId: widget.courseId)));
                },
                buttonText: 'Cancel',
              ),
              SizedBox(height: 20),
              CancelButton(
                onPressed: () {
                  if(selectedAnswer == "Left"){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage3(userId: widget.userId, courseId: widget.courseId, questionType: 'LorR',)));
                    print("Left");
                  }
                  else if(selectedAnswer == "Right"){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage3(userId: widget.userId, courseId: widget.courseId, questionType: 'LorR')));
                    print("Right");
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Select correct answer.'),
                      ),
                    );
                  }
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
