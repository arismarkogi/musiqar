import 'package:flutter/material.dart';
import 'drawpage.dart';
import 'new_course_page2.dart';
import 'widgets/cancel_button.dart';
import 'widgets/add_question.dart';
import 'question_type.dart';
import 'new_course_page4.dart';
import 'new_course_page5.dart';
import 'new_course_page6.dart';
import 'data/database_helper.dart';
import 'package:vibration/vibration.dart';

class QuestionInfo {
  TextEditingController controller;
  String title;

  QuestionInfo({required this.controller, required this.title});
}

class _NewCoursePage3State extends State<NewCoursePage3> {
  List<QuestionInfo> questionInputs = [];
  List<Map<String, dynamic>> existingQuestions = [];
  var questionId;

  @override
  void initState() {
    super.initState();
    loadExistingQuestions();
  }

  Future<void> loadExistingQuestions() async {
    var dbHelper = DatabaseHelper();
    existingQuestions = await dbHelper.getQuestionsForChapter(widget.chapterId);
    setState(() {});
  }

  TextEditingController Questions = TextEditingController();

  Future<int> insertQuestion(int courseId, String title) async {
    var dbHelper = DatabaseHelper();
    int questionId = await dbHelper.newQuestion({
      'title': title,
      'chapter_id': widget.chapterId,
      'type': widget.questionType
    });

    print("the questionId is equal to");
    print(questionId);
    if (questionId == -1) {
      print('Failed to insert question into the database');
      return -1;
    }
    return questionId;
  }

  Future<void> deleteAllQuestionsForChapter() async {
    var dbHelper = DatabaseHelper();
    await dbHelper.deleteQuestionsForChapter(widget.chapterId);
    setState(() {
      existingQuestions = []; 
    });
  }

  bool validateInputs() {
    for (QuestionInfo question in questionInputs) {
      if (question.controller.text.trim().isEmpty) {
        Vibration.vibrate(duration: 500);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please fill in all fields'),
            duration: Duration(seconds: 2),
          ),
        );
        return false;
      }
    }
    return true;
  }

  Widget inputQuestion(
      String labelText, TextEditingController controller, BuildContext context,
      {bool isPassword = false, int? questionId}) {
    //TextEditingController controller = TextEditingController();
    return Container(
      width: 390,
      height: 58,
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                color: Color(0xFFE0E0E0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      obscureText: isPassword,
                      controller: controller,
                      onChanged: (text) {
                        var existingInfo = questionInputs.firstWhere(
                          (info) => info.controller == controller,
                          orElse: () =>
                              QuestionInfo(controller: controller, title: ''),
                        );

                        existingInfo.title = text.trim();
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: labelText,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 8),
                          Text(
                            'Edit question',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF6750A4),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              height: 0.16,
                              letterSpacing: 0.10,
                            ),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              if (validateInputs()) {
                                if (widget.questionType == "Draw") {
                                  insertQuestion(
                                          widget.chapterId, controller.text)
                                      .then((result) {
                                    setState(() {
                                      questionId = result;
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewCoursePage6(
                                                userId: widget.userId,
                                                courseId: widget.courseId,
                                                chapterId: widget.chapterId,
                                                questionId: questionId ?? 0,
                                              )),
                                    );
                                  });
                                } else if (widget.questionType == "Select") {
                                  insertQuestion(
                                          widget.chapterId, controller.text)
                                      .then((result) {
                                    setState(() {
                                      questionId = result;
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewCoursePage4(
                                              userId: widget.userId,
                                              courseId: widget.courseId,
                                              chapterId: widget.chapterId,
                                              questionId: questionId ?? 0)),
                                    );
                                  });
                                } else if (widget.questionType == "LorR") {
                                  insertQuestion(
                                          widget.chapterId, controller.text)
                                      .then((result) {
                                    setState(() {
                                      questionId = result;
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewCoursePage5(
                                              userId: widget.userId,
                                              courseId: widget.courseId,
                                              chapterId: widget.chapterId,
                                              questionId: questionId ?? 0)),
                                    );
                                  });
                                }
                                /*Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Questiontype(userId: widget.userId, courseId: widget.courseId)),
                            );*/
                              }
                              ;
                            },
                            child: Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Add Questions',
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
              SizedBox(height: 30),
              ListView.builder(
                shrinkWrap: true,
                itemCount: existingQuestions.length,
                itemBuilder: (context, index) => Container(
                  width: 200,
                  child: inputQuestion(
                      'Existing Questions',
                      TextEditingController(
                          text: existingQuestions[index]['title']),
                      context,
                      questionId: existingQuestions[index]['id'] as int),
                ),
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: questionInputs.length,
                itemBuilder: (context, index) => Container(
                  width: 200,
                  child: inputQuestion(
                    'New Question',
                    questionInputs[index].controller,
                    context,
                  ),
                ),
              ),
              SizedBox(height: 20),
              AddQuestion(
                onPressed: () {
                  setState(() {
                    TextEditingController newController =
                        TextEditingController();
                    QuestionInfo newQuestion =
                        QuestionInfo(controller: newController, title: '');
                    questionInputs.add(newQuestion);
                  });
                },
                buttonText: '+ Add Question',
              ),
              SizedBox(height: 20),
              CancelButton(
                onPressed: () async {
                  await deleteAllQuestionsForChapter();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Questiontype(
                              userId: widget.userId,
                              courseId: widget.courseId,
                              chapterId: widget.chapterId)));
                },
                buttonText: 'Cancel',
              ),
              SizedBox(height: 20),
              CancelButton(
                onPressed: () {
                  if (validateInputs()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewCoursePage2(
                                userId: widget.userId,
                                courseId: widget.courseId)));
                  }
                },
                buttonText: 'Save',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewCoursePage3 extends StatefulWidget {
  final int userId;
  final int courseId;
  final String questionType;
  final int chapterId;

  NewCoursePage3(
      {required this.userId,
      required this.courseId,
      required this.chapterId,
      required this.questionType});

  @override
  _NewCoursePage3State createState() => _NewCoursePage3State();
}
