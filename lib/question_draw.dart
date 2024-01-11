import 'package:flutter/material.dart';
import 'question_gyroscope.dart';
import 'widgets/quiz_question.dart';
import 'widgets/purple_button.dart';
import 'drawpage.dart';
import 'submit_quiz.dart';
import 'drawpage_answer.dart';

class QuestionDraw extends StatelessWidget {
  final int userId;
  final int courseId;

  QuestionDraw({required this.userId, required this.courseId, Key? key})
      : super(key: key);

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
      body: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: question(
              42,
              'Here is the text for the question i want to test if it works with two lines properly',
            ),
          ),
          Center(
              child: Column(children: <Widget>[
            SizedBox(height: 150),
            Text(
              'Insert Drawing',
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
            SizedBox(height: 40),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DrawpageAns(
                              userId: userId,
                              courseId: courseId,
                            )));
              },
              child: Icon(
                Icons.edit,
                size: 30,
                color: Colors.blue,
              ),
            ),
          ])),
          SizedBox(height: 240),
          SizedBox(
            height: 100,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 133,
                    child: PurpleButton(
                      "Previous",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionGyroscope(
                                  userId: userId, courseId: courseId)),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 50),
                  SizedBox(
                    width: 133,
                    child: PurpleButton(
                      "Next",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SubmitQuiz(
                                  userId: userId, courseId: courseId)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
