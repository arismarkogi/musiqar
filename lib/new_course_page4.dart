import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'widgets/cancel_button.dart';
import 'widgets/add_answer.dart';
import 'new_course_page2.dart';
import 'new_course_page3.dart';
import 'widgets/input_unchangeable.dart';
import 'data/database_helper.dart';
import 'package:vibration/vibration.dart';

class NewCoursePage4 extends StatefulWidget {
  final int userId;
  final int courseId;
  final int chapterId;
  final int questionId;

  NewCoursePage4({
    required this.userId,
    required this.courseId,
    required this.chapterId,
    required this.questionId,
  });

  @override
  _NewCoursePage4State createState() => _NewCoursePage4State();
}

class _NewCoursePage4State extends State<NewCoursePage4> {
  List<TextEditingController> answersController = List.generate(
    4,
    (index) => TextEditingController(),
  );
  List<bool> areSelected = List.generate(4, (index) => false);

  Future<Map<String, dynamic>> _fetchQuestion() async {
    List<Map<String, dynamic>> questions =
        await DatabaseHelper().getAllQuestions();
    return questions
            .firstWhere((question) => question['id'] == widget.questionId) ??
        {};
  }

  Future<void> _fetchAnsdata() async {
    List<Map<String, dynamic>> questions =
        await DatabaseHelper().getAllQuestions();
    Map<String, dynamic> answer =
        questions.firstWhere((answers) => answers['id'] == widget.questionId);
    List<String> answersList =
        (answer['answers'] as String?)?.split('/**/') ?? ['', '', '', ''];

    setState(() {
      answersController[0].text = answersList[0] ?? '';
      answersController[1].text = answersList[1] ?? '';
      answersController[2].text = answersList[2] ?? '';
      answersController[3].text = answersList[3] ?? '';
    });
  }

  bool areAnySelected() {
    return areSelected.any((selected) => selected);
  }

  void _handleSelect(int selectedIndex) {
    setState(() {
      for (int i = 0; i < areSelected.length; i++) {
        areSelected[i] = (i == selectedIndex);
      }
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

  bool validateInputs(BuildContext context) {
    if (answersController[0].text.isEmpty ||
        answersController[1].text.isEmpty ||
        answersController[2].text.isEmpty ||
        answersController[3].text.isEmpty) {
      Vibration.vibrate(duration: 500);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
    return true;
  }

  void _showErrorMessage(BuildContext context) {
    Vibration.vibrate(duration: 500);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Please select at least one answer or fill in all inputs'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  String getCombinedText() {
    return answersController
        .map((controller) => controller.text)
        .join(' /**/ ');
  }

  void _saveButtonPressed(BuildContext context) async {
    if (areAnySelected() && validateInputs(context)) {
      String combinedText = getCombinedText();
      await DatabaseHelper()
          .addanswers(widget.questionId, combinedText, getSelected(), "Select");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewCoursePage3(
                  userId: widget.userId,
                  courseId: widget.courseId,
                  chapterId: widget.chapterId,
                  questionType: 'Select')));
      print('Saving...');
    } else {
      _showErrorMessage(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchQuestion();
    _fetchAnsdata();
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
                'Question',
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
              FutureBuilder<Map<String, dynamic>>(
                future: _fetchQuestion(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error loading question.');
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Text('No question found.');
                  } else {
                    String questionText = snapshot.data?['title'] ?? '';
                    TextEditingController myController =
                        TextEditingController();
                    myController.text = questionText;
                    return customInput_un(questionText, myController,
                        context: context);
                  }
                },
              ),
              SizedBox(height: 40),
              Text(
                'Add Answers',
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
              for (int i = 0; i < 4; i++)
                CustomBox(
                  textController: answersController[i],
                  onSelect: (isSelected) {
                    _handleSelect(i);
                  },
                  isSelected: areSelected[i],
                ),
              SizedBox(height: 20),
              CancelButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewCoursePage3(
                              userId: widget.userId,
                              courseId: widget.courseId,
                              chapterId: widget.chapterId,
                              questionType: 'Select')));
                },
                buttonText: 'Cancel',
              ),
              SizedBox(height: 20),
              CancelButton(
                onPressed: () {
                  _saveButtonPressed(context);
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

class CustomBox extends StatefulWidget {
  final TextEditingController textController;
  final Function(bool isSelected) onSelect;
  final bool isSelected;

  CustomBox({
    required this.textController,
    required this.onSelect,
    required this.isSelected,
  });

  @override
  _CustomBoxState createState() => _CustomBoxState();
}

class _CustomBoxState extends State<CustomBox> {
  bool isSelected = false;
  String? imagePath;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 88,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: widget.textController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter text',
              ),
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            icon: Icon(
              widget.isSelected
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
            ),
            onPressed: () {
              widget.onSelect(!widget.isSelected);
            },
            color: widget.isSelected ? Colors.green : Colors.grey,
          ),
        ],
      ),
    );
  }
}
