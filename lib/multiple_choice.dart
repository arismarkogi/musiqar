import 'package:flutter/material.dart';
import 'widgets/mul_choice_answer.dart';
import 'widgets/quiz_question.dart';
import 'widgets/purple_button.dart';
import 'start_quiz.dart';
import 'submit_quiz.dart';

class QuestionMultiple extends StatefulWidget {
  final int userId;
  final int courseId;
  final int chapterId;
  final List<Map<String, dynamic>> questions;
  final int counter;
  final List<Map<String, dynamic>> answers;

  QuestionMultiple({
    required this.userId,
    required this.courseId,
    required this.chapterId,
    required this.questions,
    required this.counter,
    required this.answers,
    Key? key,
  }) : super(key: key);

  @override
  _QuestionMultipleState createState() => _QuestionMultipleState();
}

class _QuestionMultipleState extends State<QuestionMultiple> {

  late List<bool> areSelected = [false, false, false, false]; // Initialize with false values

  @override
  void initState() {
    super.initState();

    // Initialize areSelected based on the stored answer in widget.answers
    int selectedAnswer = widget.answers[widget.counter]['answer'] ?? -1;
    areSelected = List.generate(4, (index) => (index + 1) == selectedAnswer);
  }

  bool areAnySelected() {
    return areSelected.any((selected) => selected);
  }

  void _handleSelect(int selectedIndex) {
    setState(() {
      for (int i = 0; i < areSelected.length; i++) {
        areSelected[i] = (i == selectedIndex);
      }

      // Store the selected answer in widget.answers
      int selectedAnswer = selectedIndex + 1; // Convert 0-based index to 1-based answer
      widget.answers[widget.counter] = {'answer': selectedAnswer};

      print("areSelected: $areSelected");
      print("widget.answers: ${widget.answers}");
    });
  }



  int getSelected() {
    for (int i = 1; i <= areSelected.length; i++) {
      if (areSelected[i - 1]) {
        return i;
      }
    }
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    List<String> answerOptions = widget.questions[widget.counter]['answers'].toString().split('/**/');
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
            child: question(
              widget.counter+1,
                widget.questions[widget.counter]['title'].toString()
                ),
          ),
          SizedBox(height: 60),
          Expanded(
            child: ListView.separated(
              itemCount: answerOptions.length,
              separatorBuilder: (context, _) => SizedBox(height: 8),
              itemBuilder: (context, index) => SizedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomMultipleChoiceWidget(
                    answer: answerOptions[index],
                    onTap: () {
                      _handleSelect(index); // Handle tap if needed
                    },
                    isSelected: areSelected[index],
                  ),
                ),
              ),
            ),
          ),
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
                          builder: (context) => QuestionMultiple(
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
                          builder: (context) => QuestionMultiple(
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
          SizedBox(height: 40)
        ]));
  }
}
