import 'package:flutter/material.dart';
import 'package:flutter_application_1/question_draw.dart';
import 'widgets/start_button.dart';
import 'profile_page.dart';
import 'menu_page.dart';
import 'widgets/purple_button.dart';
import 'correct_answers.dart';





class SubmitQuiz extends StatelessWidget {

  final int userId;
  final int courseId;

  SubmitQuiz({required this.userId, required this.courseId, Key? key}) : super(key: key);

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
              Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage(userId: userId,)));
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(userId: userId)));
              },
            ),
          ],
        ),
        body:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 324,
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Are you ready to submit your answers?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1.2, // Adjust the height as needed
                    ),
                    overflow: TextOverflow.ellipsis, // Handles overflow
                    maxLines: 5, // Limits to two lines
                  ),
                ],
              ),
            ),


            SizedBox(height: 50),

            Center(
                child: startButton(
                    "Submit Answers",
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CorrectAnswers(userId: userId)),
                      );
                    }
                )
            ),

            SizedBox(height: 150),
            Center(
              child: PurpleButton(
                "Previous Questions",
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuestionDraw(userId: userId, courseId: courseId)),
                  );

                },
              ),
            ),
          ],
        )
    );
    // Other widgets or sections in the body can be added below
  }
}
