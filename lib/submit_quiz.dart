import 'package:flutter/material.dart';
import 'package:musIQAR/question_draw.dart';
import 'widgets/start_button.dart';
import 'widgets/purple_button.dart';
import 'correct_answers.dart';
import 'package:vibration/vibration.dart';
import 'multiple_choice.dart';
import 'question_gyroscope.dart';

class SubmitQuiz extends StatelessWidget {
  final int userId;
  final int courseId;
  final int chapterId;
  final List<Map<String, dynamic>> questions;
  final int counter;
  final List<Map<String, dynamic>> answers;

  SubmitQuiz({
    required this.userId,
    required this.courseId,
    required this.chapterId,
    required this.questions,
    required this.counter,
    required this.answers,
    Key? key,
  }) : super(key: key);

  bool allQuestionsAnswered() {
    for (int i = 0; i < questions.length; i++) {
      if (!answers[i].containsKey('answer')) {
        return false;
      }
    }
    return true;
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
                  'Are you ready to submit your answers?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          Center(
            child: startButton(
              "Submit Answers",
              () {
                print("widget $answers");
                if (allQuestionsAnswered()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CorrectAnswers(
                              userId: userId,
                              courseId: courseId,
                              chapterId: chapterId,
                              answers: answers,
                              questions: questions,
                            )),
                  );
                } else {
                  Vibration.vibrate(duration: 500);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Please answer all questions before submitting.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
          ),
          SizedBox(height: 150),
          Center(
            child: PurpleButton(
              "Previous Questions",
              () {
                if (counter >= 0) {
                  String questionType = questions[counter]['type'];
                  switch (questionType) {
                    case "TorF":
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionGyroscope(
                            userId: userId,
                            courseId: courseId,
                            chapterId: chapterId,
                            questions: questions,
                            counter: counter,
                            answers: answers,
                          ),
                        ),
                      );
                      break;
                    case "Draw":
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionDraw(
                            userId: userId,
                            courseId: courseId,
                            chapterId: chapterId,
                            questions: questions,
                            counter: counter,
                            answers: answers,
                          ),
                        ),
                      );
                      break;
                    case "Select":
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionMultiple(
                            userId: userId,
                            courseId: courseId,
                            chapterId: chapterId,
                            questions: questions,
                            counter: counter,
                            answers: answers,
                          ),
                        ),
                      );
                      break;
                    default:
                      break;
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
