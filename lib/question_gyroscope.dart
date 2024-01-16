import 'package:flutter/material.dart';
import 'package:musIQAR/widgets/gyroscope_answer.dart';
import 'widgets/quiz_question.dart';
import 'widgets/purple_button.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import 'submit_quiz.dart';

class QuestionGyroscope extends StatefulWidget {
  final int userId;
  final int courseId;
  final int chapterId;
  final List<Map<String, dynamic>> questions;
  final int counter;
  final List<Map<String, dynamic>> answers;

  QuestionGyroscope({
    required this.userId,
    required this.courseId,
    required this.chapterId,
    required this.questions,
    required this.counter,
    required this.answers,
    Key? key,
  }) : super(key: key);

  @override
  _QuestionGyroscopeState createState() => _QuestionGyroscopeState();
}

class _QuestionGyroscopeState extends State<QuestionGyroscope> {
  double _gyroY = 0.0;

  late StreamSubscription<GyroscopeEvent> gyroscopeSubscription;

  @override
  void initState() {
    super.initState();
    startGyroscope();
  }

  void startGyroscope() {
    gyroscopeSubscription =
        gyroscopeEventStream().listen((GyroscopeEvent event) {
          setState(() {
            _gyroY = event.y;

            double threshold = 3.0;
            if (_gyroY < -threshold) {
              gyroscopeSubscription.cancel();
              print("left");
              widget.answers[widget.counter] = {'answer': 1};
              navigateToQuestion(widget.counter + 1);
            } else if (_gyroY > threshold) {
              gyroscopeSubscription.cancel();
              print("right");
              widget.answers[widget.counter] = {'answer': 2};
              navigateToQuestion(widget.counter + 1);
            }
          });
        });
  }

  void navigateToQuestion(int newCounter) {
    print(widget.answers);
    if (newCounter < 0) {
      // If counter is negative, go to the first question
      newCounter = 0;
    } else if (newCounter >= widget.questions.length) {
      // If counter exceeds the number of questions, go to SubmitQuiz
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SubmitQuiz(
            userId: widget.userId,
            courseId: widget.courseId,
            chapterId: widget.chapterId,
            questions: widget.questions,
            counter: widget.counter,
            answers: widget.answers,
          ),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionGyroscope(
          userId: widget.userId,
          courseId: widget.courseId,
          chapterId: widget.chapterId,
          questions: widget.questions,
          counter: newCounter,
          answers: widget.answers,
        ),
      ),
    );
  }

  @override
  void dispose() {
    gyroscopeSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String currentQuestionText = widget.questions[widget.counter]['title'].toString();
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
              widget.counter + 1,
              currentQuestionText,
              ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    gyrAnswer("False","Tilt your device to the left to select False"),
                    SizedBox(width: 30),
                    gyrAnswer("True","Tilt your device to the right to select True"),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 170),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Visibility(
                  visible: widget.counter != 0, // Hide when counter is 0
                  child: SizedBox(
                    width: 133,
                    child: PurpleButton("Previous", () {
                      // If not on the first question, navigate to the previous question
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionGyroscope(
                            userId: widget.userId,
                            courseId: widget.courseId,
                            chapterId: widget.chapterId,
                            questions: widget.questions,
                            counter: widget.counter - 1,
                            answers: widget.answers,
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                SizedBox(width: 50),
                SizedBox(
                  width: 133,
                  child: PurpleButton("Next", () {
                    if (widget.counter == widget.questions.length - 1) {
                      // If on the last question, navigate to SubmitQuiz page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubmitQuiz(
                            userId: widget.userId,
                            courseId: widget.courseId,
                            chapterId: widget.chapterId,
                            questions: widget.questions,
                            counter: widget.counter,
                            answers: widget.answers,
                          ),
                        ),
                      );
                    } else {
                      // If not on the last question, navigate to the next question
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionGyroscope(
                            userId: widget.userId,
                            courseId: widget.courseId,
                            chapterId: widget.chapterId,
                            questions: widget.questions,
                            counter: widget.counter + 1,
                            answers: widget.answers,
                          ),
                        ),
                      );
                    }
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
