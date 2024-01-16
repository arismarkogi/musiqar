import 'package:flutter/material.dart';
import 'widgets/quiz_question.dart';
import 'widgets/purple_button.dart';
import 'submit_quiz.dart';
import 'drawpage_answer.dart';

class QuestionDraw extends StatefulWidget {
  final int userId;
  final int courseId;
  final int chapterId;
  final List<Map<String, dynamic>> questions;
  final int counter;
  final List<Map<String, dynamic>> answers;

  QuestionDraw({
    required this.userId,
    required this.courseId,
    required this.chapterId,
    required this.questions,
    required this.counter,
    required this.answers,
    Key? key,
  }) : super(key: key);

  @override
  _QuestionDrawState createState() => _QuestionDrawState();
}

class _QuestionDrawState extends State<QuestionDraw> {
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
                          userId: widget.userId,
                          courseId: widget.courseId,
                          chapterId: widget.chapterId,
                          answers: widget.answers,
                          questions: widget.questions,
                          counter: widget.counter,
                        ),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.edit,
                    size: 30,
                    color: Colors.blue,
                  ),
                ),
              ])),
          SizedBox(height: 240),
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
                          builder: (context) => QuestionDraw(
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
                      print(widget.answers);
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
                      print("answers:");
                      print(widget.answers);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionDraw(
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
