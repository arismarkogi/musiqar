import 'package:flutter/material.dart';
import 'package:musIQAR/question_draw.dart';
import 'package:musIQAR/widgets/gyroscope_answer.dart';
import 'widgets/quiz_question.dart';
import 'widgets/purple_button.dart';
import 'multiple_choice.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';

class QuestionGyroscope extends StatefulWidget {
  final int userId;
  final int courseId;
  final int chapterId;

  QuestionGyroscope({required this.userId, required this.courseId, required this.chapterId, Key? key})
      : super(key: key);

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

        double threshold = 2.0;
        if (_gyroY < -threshold) {
          gyroscopeSubscription.cancel();
          print("left");
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QuestionMultiple(
                      userId: widget.userId,
                      courseId: widget.courseId,
                      chapterId: widget.chapterId,
                    )),
          );
        } else if (_gyroY > threshold) {
          gyroscopeSubscription.cancel();
          print("right");
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QuestionDraw(
                      userId: widget.userId,
                      courseId: widget.courseId,
                      chapterId: widget.chapterId,
                    )),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    gyroscopeSubscription.cancel();
    super.dispose();
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
        children: [
          SizedBox(height: 20),
          Center(
            child: question(
              42,
              'Here is the text for the question i want to test if it works with two lines properly',
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    gyrAnswer(
                        "Here is the text for the answer of the left option"),
                    SizedBox(width: 30),
                    gyrAnswer(
                        "Here is the text for the answer of the right option"),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 100),
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
                              builder: (context) => QuestionMultiple(
                                  userId: widget.userId,
                                  courseId: widget.courseId,
                                  chapterId: widget.chapterId)),
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
                              builder: (context) => QuestionDraw(
                                    userId: widget.userId,
                                    courseId: widget.courseId,
                                    chapterId: widget.chapterId,
                                  )),
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
