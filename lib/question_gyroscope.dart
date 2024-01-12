import 'package:flutter/material.dart';
<<<<<<< HEAD
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

  QuestionGyroscope({required this.userId, required this.courseId, Key? key})
      : super(key: key);
=======
import 'package:flutter_application_1/question_draw.dart';
import 'package:flutter_application_1/widgets/gyroscope_answer.dart';
import 'widgets/quiz_question.dart';
import 'widgets/purple_button.dart';
import 'multiple_choice.dart';
//import 'gyroscope_page.dart';
import 'package:sensors_plus/sensors_plus.dart'; // Import the sensors package
import 'dart:async';


class QuestionGyroscope extends StatefulWidget {

  final int userId;
  final int courseId;

  QuestionGyroscope({required this.userId, required this.courseId, Key? key}) : super(key: key);



>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6

  @override
  _QuestionGyroscopeState createState() => _QuestionGyroscopeState();
}

<<<<<<< HEAD
class _QuestionGyroscopeState extends State<QuestionGyroscope> {
  double _gyroY = 0.0;

=======


class _QuestionGyroscopeState extends State<QuestionGyroscope> {
  // Declare variables to store gyroscope data
  double _gyroY = 0.0;

  // Gyroscope stream subscription
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
  late StreamSubscription<GyroscopeEvent> gyroscopeSubscription;

  @override
  void initState() {
    super.initState();
    startGyroscope();
  }

  void startGyroscope() {
<<<<<<< HEAD
    gyroscopeSubscription =
        gyroscopeEventStream().listen((GyroscopeEvent event) {
=======
    gyroscopeSubscription = gyroscopeEventStream().listen((GyroscopeEvent event) {
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
      setState(() {
        _gyroY = event.y;

        double threshold = 2.0;
<<<<<<< HEAD
=======
        // Check if the absolute value of gyroY exceeds the threshold
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
        if (_gyroY < -threshold) {
          gyroscopeSubscription.cancel();
          print("left");
          Navigator.push(
            context,
<<<<<<< HEAD
            MaterialPageRoute(
                builder: (context) => QuestionMultiple(
                      userId: widget.userId,
                      courseId: widget.courseId,
                    )),
          );
        } else if (_gyroY > threshold) {
=======
            MaterialPageRoute(builder: (context) => QuestionMultiple(userId: widget.userId, courseId: widget.courseId,)),
          );
        }
        else if (_gyroY > threshold) {
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
          gyroscopeSubscription.cancel();
          print("right");
          Navigator.push(
            context,
<<<<<<< HEAD
            MaterialPageRoute(
                builder: (context) => QuestionDraw(
                      userId: widget.userId,
                      courseId: widget.courseId,
                    )),
=======
            MaterialPageRoute(builder: (context) => QuestionDraw(userId: widget.userId, courseId: widget.courseId,)),
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
          );
        }
      });
    });
  }

  @override
  void dispose() {
<<<<<<< HEAD
=======
    // Cancel the gyroscope subscription when the widget is disposed
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
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
<<<<<<< HEAD
=======

>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
<<<<<<< HEAD
                    gyrAnswer(
                        "Here is the text for the answer of the left option"),
                    SizedBox(width: 30),
                    gyrAnswer(
                        "Here is the text for the answer of the right option"),
=======
                    gyrAnswer("Here is the text for the answer of the left option"),
                    SizedBox(width: 30),
                    gyrAnswer("Here is the text for the answer of the right option"),
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 100),
          SizedBox(
<<<<<<< HEAD
            height: 100,
=======
            height: 100, // Adjust the height as needed
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 133,
                    child: PurpleButton(
                      "Previous",
<<<<<<< HEAD
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionMultiple(
                                  userId: widget.userId,
                                  courseId: widget.courseId)),
=======
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => QuestionMultiple(userId: widget.userId, courseId:  widget.courseId)),
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 50),
                  SizedBox(
                    width: 133,
                    child: PurpleButton(
                      "Next",
<<<<<<< HEAD
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionDraw(
                                    userId: widget.userId,
                                    courseId: widget.courseId,
                                  )),
=======
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => QuestionDraw(userId: widget.userId, courseId: widget.courseId,)),
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
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
