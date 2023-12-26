import 'package:flutter/material.dart';
import 'new_course_page2.dart';
import 'widgets/cancel_button.dart';
import 'widgets/add_question.dart';
import 'question_type.dart';


Widget inputQuestion(String labelText, TextEditingController controller, BuildContext context, {bool isPassword = false}) {
  TextEditingController controller = TextEditingController(); 
  return Container(
    width: 390,
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
                    Column(
                      children: [
                        SizedBox(height: 8),
                        Text(
                          'Edit question',
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
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Questiontype()),
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

class _NewCoursePage3State extends State<NewCoursePage3> {
  List<Widget> chapterInputs = []; 


  TextEditingController Questions = TextEditingController();

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
              'Add Questions',
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
                child: chapterInputs[index],
              ),
            ),
            SizedBox(height: 20),
            AddQuestion(
              onPressed: () {
                setState(() {
                  chapterInputs.add(inputQuestion('Add Question', Questions, context));
                });
              },
              buttonText: '+      Add Question',
            ),
            SizedBox(height: 20),
            CancelButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage2()));
              },
              buttonText: 'Cancel',
            ),
          ],
        ),
      ),
      ),
    );
  }
}


class NewCoursePage3 extends StatefulWidget {
  @override
  _NewCoursePage3State createState() => _NewCoursePage3State();
}


