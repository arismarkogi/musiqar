<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'widgets/start_button.dart';
import 'chapter_page.dart';
import 'profile_page.dart';
import 'menu_page.dart';
import 'widgets/purple_button.dart';
import 'multiple_choice.dart';






class StartQuiz extends StatelessWidget {

  final int userId;
  final int courseId;

  StartQuiz({required this.userId, required this.courseId, Key? key}) : super(key: key);

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
              Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage(userId: userId)));
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
                    'Are you ready to start your quiz?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
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
                  "Start Quiz",
                   () {
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => QuestionMultiple(userId: userId, courseId: courseId)),
                     );
                   }
                )
            ),

            SizedBox(height: 150),
            Center(
              child: PurpleButton(
                "Chapter Page",
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChapterPage(userId: userId, courseId: courseId,)),
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
=======
import 'package:flutter/material.dart';
import 'widgets/start_button.dart';
import 'chapter_page.dart';
import 'profile_page.dart';
import 'menu_page.dart';
import 'widgets/purple_button.dart';
import 'multiple_choice.dart';






class StartQuiz extends StatelessWidget {

  final int userId;
  final int courseId;

  StartQuiz({required this.userId, required this.courseId, Key? key}) : super(key: key);

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
              Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage(userId: userId)));
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
                    'Are you ready to start your quiz?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
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
                  "Start Quiz",
                   () {
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => QuestionMultiple(userId: userId, courseId: courseId)),
                     );
                   }
                )
            ),

            SizedBox(height: 150),
            Center(
              child: PurpleButton(
                "Chapter Page",
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChapterPage(userId: userId, courseId: courseId,)),
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
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
