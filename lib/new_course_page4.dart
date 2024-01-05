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

class NewCoursePage4 extends StatefulWidget {
  final int userId;
  final int courseId;

  NewCoursePage4({required this.userId, required this.courseId});

  @override
  _NewCoursePage4State createState() => _NewCoursePage4State();
}

class _NewCoursePage4State extends State<NewCoursePage4> {
  List<Widget> textInputs = []; 

  List<TextEditingController> answerscontroller = [];
  List<TextEditingController> newanswerscontroller = [];

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
              ListView.builder(
                shrinkWrap: true,
                itemCount: textInputs.length,
                itemBuilder: (context, index) => Container(
                  width: 200,
                  child: textInputs[index],
                ),
              ),
              SizedBox(height: 20),
              AddAnswer(
                onPressed: () {
                  TextEditingController newController = TextEditingController();
                  answerscontroller.add(newController);
                  TextEditingController newansController = TextEditingController();
                  newanswerscontroller.add(newansController);
                  setState(() {
                    textInputs.add(CustomBox(
                      textController: newansController,
                      onSelect: (isSelected) {
                        if (isSelected) {
                          print('Selected!');
                        } else {
                          print('Unselected!');
                        }
                      },
                    ));
                  });
                },
                buttonText: '+      Add Answer',
              ),
              SizedBox(height: 20),
              CancelButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage3(userId: widget.userId, courseId: widget.courseId)));
                },
                buttonText: 'Cancel',
              ),
              SizedBox(height: 20),
              CancelButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage3(userId: widget.userId, courseId: widget.courseId)));
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

  CustomBox({
    required this.textController,
    required this.onSelect,
  });

  @override
  _CustomBoxState createState() => _CustomBoxState();
}

class _CustomBoxState extends State<CustomBox> {
  bool isSelected = false;
  String? imagePath;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

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
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: 114,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200],
                image: imagePath != null
                    ? DecorationImage(
                        image: FileImage(File(imagePath!)),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: imagePath == null
                  ? Icon(Icons.add_a_photo)
                  : null,
            ),
          ),
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
            icon: Icon(isSelected ? Icons.check_circle : Icons.radio_button_unchecked),
            onPressed: () {
              setState(() {
                isSelected = !isSelected;
              });
              widget.onSelect(isSelected);
            },
            color: isSelected ? Colors.green : Colors.grey,
          ),
        ],
      ),
    );
  }
}