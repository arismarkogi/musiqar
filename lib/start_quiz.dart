import 'package:flutter/material.dart';
import 'widgets/start_button.dart';
import 'chapter_page.dart';
import 'profile_page.dart';
import 'menu_page.dart';
import 'widgets/purple_button.dart';
import 'multiple_choice.dart';
import 'question_gyroscope.dart';
import 'question_draw.dart';
import 'data/database_helper.dart';

class StartQuiz extends StatefulWidget {
  final int userId;
  final int courseId;
  final int chapterId;

  StartQuiz(
      {required this.userId,
      required this.courseId,
      required this.chapterId,
      Key? key})
      : super(key: key);

  @override
  _StartQuizState createState() => _StartQuizState();
}

class _StartQuizState extends State<StartQuiz> {
  List<Map<String, dynamic>> questions = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<Map<String, dynamic>> fetchedQuestions =
        await DatabaseHelper().getQuestionsForChapter(widget.chapterId);
    setState(() {
      questions = fetchedQuestions;
    });
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
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProfilePage(userId: widget.userId)));
              },
            ),
          ],
        ),
        body: Column(
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
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                ],
              ),
            ),
            SizedBox(height: 100),
            Center(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: Future.value(questions),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    List<Map<String, dynamic>> questionsData = snapshot.data!;
                    String quizType = questionsData.isNotEmpty
                        ? questionsData[0]['type'].toString()
                        : 'Unknown';

                    List<Map<String, dynamic>> answers =
                        List.filled(questionsData.length, {});

                    return startButton(
                      "Start Quiz",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              if (quizType == 'Select') {
                                return QuestionMultiple(
                                  userId: widget.userId,
                                  courseId: widget.courseId,
                                  chapterId: widget.chapterId,
                                  questions: questionsData,
                                  counter: 0,
                                  answers: answers,
                                );
                              } else if (quizType == 'TorF') {
                                return QuestionGyroscope(
                                  userId: widget.userId,
                                  courseId: widget.courseId,
                                  chapterId: widget.chapterId,
                                  questions: questionsData,
                                  counter: 0,
                                  answers: answers,
                                );
                              } else if (quizType == 'Draw') {
                                return QuestionDraw(
                                  userId: widget.userId,
                                  courseId: widget.courseId,
                                  chapterId: widget.chapterId,
                                  questions: questionsData,
                                  counter: 0,
                                  answers: answers,
                                );
                              } else {
                                return QuestionMultiple(
                                  userId: widget.userId,
                                  courseId: widget.courseId,
                                  chapterId: widget.chapterId,
                                  questions: questionsData,
                                  counter: 0,
                                  answers: answers,
                                );
                              }
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
            SizedBox(height: 100),
            Container(
              width: 324,
              padding: EdgeInsets.all(16.0),
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: Future.value(questions),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    List<Map<String, dynamic>> questionsData = snapshot.data!;
                    String quizType = questionsData.isNotEmpty
                        ? questionsData[0]['type'].toString()
                        : 'Unknown';
                    if (quizType == 'Select') {
                      quizType = "Multiple Choice";
                    } else if (quizType == "TorF") {
                      quizType = "True or False";
                    } else if (quizType == "Draw") {
                      quizType = "Drawing";
                    } else {
                      quizType = "Undetermined";
                    }
                    return Text(
                      'Quiz type: $quizType',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    );
                  } else {
                    return Text(
                      'Loading...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 120),
            Center(
              child: PurpleButton(
                "Chapter Page",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChapterPage(
                              userId: widget.userId,
                              chapterId: widget.chapterId,
                              courseId: widget.courseId,
                            )),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
