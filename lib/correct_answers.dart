import 'package:flutter/material.dart';
import 'widgets/correct_answer.dart';
import 'profile_page.dart';
import 'menu_page.dart';




class CorrectAnswers extends StatelessWidget {

  final int userId;

  CorrectAnswers({required this.userId});

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
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(userId: userId,)));
              },
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 10),
            /*
            Expanded(
                child: ListView.separated(
                  itemCount: 20,
                  separatorBuilder: (context, _) => SizedBox(height: 8),
                  itemBuilder: (context, index) => SizedBox(
                    child: correctAnswer(42, "Correct Answer", "Your Answer", false)
                  ),
                )
            ),
            */
            Expanded(
                child: ListView.separated(
                  itemCount: 20,
                  separatorBuilder: (context, _) => SizedBox(height: 8),
                  itemBuilder: (context, index) => SizedBox(
                      child: correctAnswer(42, "assets/course.jpg", "assets/quiz.png", true)
                  ),
                )
            )
          ],
        )
    );
  }
}
