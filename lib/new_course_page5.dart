import 'package:flutter/material.dart';
import 'homepage.dart';
import 'menu_page.dart';
import 'widgets/custom_input.dart';
import 'widgets/cancel_button.dart';
import 'question_type.dart';
import 'new_course_page2.dart';


class NewCoursePage5 extends StatefulWidget {
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage()));
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
                      padding: EdgeInsets.all(12.0), // Add padding around the text
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200, // Add a light gray background color
                        borderRadius: BorderRadius.circular(8.0), // Add rounded corners
                      ),
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Colors.black, // Change text color
                          fontSize: 16.0, // Change font size
                          fontWeight: FontWeight.w400, // Change font weight
                          fontFamily: 'Roboto', // Change font family
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 70),

              CancelButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Questiontype()));
                },
                buttonText: 'Cancel',
              ),
              SizedBox(height: 20),
              CancelButton(
                onPressed: () {
                  if(selectedAnswer == "Left"){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage2()));
                    print("Left");
                  }
                  else if(selectedAnswer == "Right"){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage2()));
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
