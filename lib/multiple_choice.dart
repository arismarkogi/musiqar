import 'package:flutter/material.dart';
import 'widgets/mul_choice_answer.dart';
import 'widgets/quiz_question.dart';
import 'widgets/purple_button.dart';
import 'start_quiz.dart';
import 'question_gyroscope.dart';

class QuestionMultiple extends StatelessWidget {
  final int userId;
  final int courseId;
  final int chapterId;

  QuestionMultiple({required this.userId, required this.courseId, required this.chapterId, Key? key})
      : super(key: key);

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
        body: Column(children: [
          SizedBox(height: 20),
          Center(
            child: question(42,
                'Here is the text for the question i want to test if it works with two lines properly'),
          ),
          Expanded(
              child: ListView.separated(
            itemCount: 4,
            separatorBuilder: (context, _) => SizedBox(height: 8),
            itemBuilder: (context, index) => SizedBox(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomMultipleChoiceWidget(
                      answer: "text for the answer",
                      imageURL: "assets/course.jpg",
                      onTap: () {})),
            ),
          )),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 133,
                  child: PurpleButton("Previous", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StartQuiz(
                                  userId: userId,
                                  courseId: courseId,
                                  chapterId: chapterId,
                                )));
                  }),
                ),
                SizedBox(width: 50),
                SizedBox(
                  width: 133,
                  child: PurpleButton("Next", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuestionGyroscope(
                                userId: userId, courseId: courseId, chapterId: chapterId)));
                  }),
                ),
              ],
            ),
          ),
          SizedBox(height: 40)
        ]));
  }
}
