import 'package:flutter/material.dart';
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




  @override
  _QuestionGyroscopeState createState() => _QuestionGyroscopeState();
}



class _QuestionGyroscopeState extends State<QuestionGyroscope> {
  // Declare variables to store gyroscope data
  double _gyroY = 0.0;

  // Gyroscope stream subscription
  late StreamSubscription<GyroscopeEvent> gyroscopeSubscription;

  @override
  void initState() {
    super.initState();
    startGyroscope();
  }

  void startGyroscope() {
    gyroscopeSubscription = gyroscopeEventStream().listen((GyroscopeEvent event) {
      setState(() {
        _gyroY = event.y;

        double threshold = 5.0;
        // Check if the absolute value of gyroY exceeds the threshold
        if (_gyroY < -threshold) {
          gyroscopeSubscription.cancel();
          print("left");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QuestionMultiple(userId: widget.userId, courseId: widget.courseId,)),
          );
        }
        else if (_gyroY > threshold) {
          gyroscopeSubscription.cancel();
          print("right");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QuestionDraw(userId: widget.userId, courseId: widget.courseId,)),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    // Cancel the gyroscope subscription when the widget is disposed
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
                    gyrAnswer("Here is the text for the answer of the left option"),
                    SizedBox(width: 30),
                    gyrAnswer("Here is the text for the answer of the right option"),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 100),
          SizedBox(
            height: 100, // Adjust the height as needed
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
                          MaterialPageRoute(builder: (context) => QuestionMultiple(userId: widget.userId, courseId:  widget.courseId)),
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
                          MaterialPageRoute(builder: (context) => QuestionDraw(userId: widget.userId, courseId: widget.courseId,)),
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
