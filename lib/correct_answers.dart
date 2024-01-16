import 'package:flutter/material.dart';
import 'widgets/correct_answer.dart';
import 'profile_page.dart';
import 'menu_page.dart';
import 'course_page.dart';
import 'widgets/purple_button.dart';

class CorrectAnswers extends StatefulWidget {
  final int userId;
  final int courseId;
  final int chapterId;
  final List<Map<String, dynamic>> questions;
  final List<Map<String, dynamic>> answers;

  CorrectAnswers({
    required this.userId,
    required this.courseId,
    required this.chapterId,
    required this.questions,
    required this.answers,
  });

  @override
  _CorrectAnswersState createState() => _CorrectAnswersState();
}

class _CorrectAnswersState extends State<CorrectAnswers> {
  int score = 0;

  String getAnswerURL(String questionType, dynamic answer, String answers) {
    if (questionType == 'TorF') {
      return (answer == 1) ? 'False' : 'True';
    } else if (questionType == 'Select') {
      List<String> answerOptions = answers.split('/**/');
      int selectedAnswerIndex = int.parse(answer.toString());

      if (selectedAnswerIndex >= 1 && selectedAnswerIndex <= answerOptions.length) {
        return answerOptions[selectedAnswerIndex - 1];
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              MaterialPageRoute(builder: (context) => MenuPage(userId: widget.userId)),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage(userId: widget.userId)),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Center(
            child: PurpleButton(
              "Course Page",
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CoursePage(userId: widget.userId, courseId: widget.courseId)),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Visibility(
            visible: widget.questions.any((question) => question['type'] != 'Draw'),
            child: Text(
              'Score: $score/${widget.questions.length}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: widget.questions.length,
              separatorBuilder: (context, _) => SizedBox(height: 8),
              itemBuilder: (context, index) {
                Map<String, dynamic> question = widget.questions[index];
                Map<String, dynamic> answer = widget.answers[index];

                if (question['type'] == 'Draw') {
                  return correctAnswer(
                    index + 1,
                    question['title'],
                    question['answers'], // Assuming this is the correct answer image URL
                    answer['answer'], // Assuming this is the user's answer image URL
                    true,
                    false
                  );
                } else if (question['type'] == 'TorF' || question['type'] == 'Select') {

                  bool isCorrect = question['correct_answer'] == answer['answer'];
                  if (isCorrect) {
                    score++;
                  }

                  return correctAnswer(
                    index + 1,
                    question['title'],
                    getAnswerURL(question['type'], question['correct_answer'], question['answers']), // Provide the correct answer based on type
                    getAnswerURL(question['type'], answer['answer'], question['answers']), // Provide the user's answer based on type
                    false,
                    isCorrect
                  );
                }

                return Container(); // Placeholder for other question types
              },
            ),
          ),
        ],
      ),
    );
  }
}