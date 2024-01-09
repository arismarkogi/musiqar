import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/database_helper.dart';
import 'package:flutter_application_1/question_type.dart';
import 'package:sqflite/sqflite.dart';
import 'menu_page.dart';
import 'homepage.dart';
import 'new_course_page1.dart';
import 'new_course_page3.dart';
import 'widgets/add_chapter.dart';
import 'widgets/cancel_button.dart';
import 'course_settings.dart';
import 'course_info_provider.dart';
import 'package:provider/provider.dart';



class ChapterInfo {
  TextEditingController controller;
  String title;

  ChapterInfo({required this.controller, required this.title});
}


class _NewCoursePage2State extends State<NewCoursePage2> {
  List<ChapterInfo> chapterInputs = [];
  List<Map<String, dynamic>> existingChapters = [];
  var chapterId;

  @override
  void initState() {
    super.initState();
    loadExistingChapters();
  }

  Future<void> loadExistingChapters() async {
    var dbHelper = DatabaseHelper();
    existingChapters = await dbHelper.getChaptersForCourse(widget.courseId);
    setState(() {});
  }



/*
  Widget inputChapter(String labelText, TextEditingController controller, BuildContext context, {bool isPassword = false}) {
    return Container(
      width: 400,
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
                        setState(() {
                          var existingInfo = chapterInputs.firstWhere(
                            (info) => info.controller == controller,
                            orElse: () => ChapterInfo(controller: controller, title: ''),
                          );

                          existingInfo.title = text;
                        });
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
                      Row(
                        children: [
                          Text(
                            'Edit info',
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
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                chapterId = insertChapter(widget.courseId);
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FileUploadPage(userId: widget.userId, courseId: widget.courseId, chapterId: chapterId)),
                              );
                            },
                            child: Icon(Icons.edit),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                        Text(
                          'Edit quiz',
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
                        GestureDetector(
                          onTap: () async {
                            bool pdfIsNull = await DatabaseHelper().isPdfNull(chapterId);

                            if (pdfIsNull) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Add info first'),
                                  content: Text('You need to add info before editing the quiz.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Questiontype(userId: widget.userId, courseId: widget.courseId, chapterId: chapterId)),
                              );
                            }
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
  */

Widget inputChapter(String labelText, TextEditingController controller, BuildContext context, {bool isPassword = false, int? chapterId}) {
  return Container(
    width: 400,
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
                      var existingInfo = chapterInputs.firstWhere(
                        (info) => info.controller == controller,
                        orElse: () => ChapterInfo(controller: controller, title: ''),
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
                    Row(
                      children: [
                        Text(
                          'Edit info',
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
                        GestureDetector(
                          onTap: () {
                            if (chapterId == null) {
                              insertChapter(widget.courseId, controller.text).then((result) {
                                setState(() {
                                  chapterId = result;
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => FileUploadPage(userId: widget.userId, courseId: widget.courseId, chapterId: chapterId!)),
                                );
                              });
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FileUploadPage(userId: widget.userId, courseId: widget.courseId, chapterId: chapterId!)),
                              );
                            }
                          },
                          child: Icon(Icons.edit),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Edit quiz',
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
                        GestureDetector(
                          onTap: () async {
                            if (chapterId == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Add pdf first!!!'),
                                ),
                              );
                              return;
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Questiontype(userId: widget.userId, courseId: widget.courseId, chapterId: chapterId!)),
                              );
                            }
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

/*
Widget inputChapter(String labelText, TextEditingController controller, BuildContext context, {bool isPassword = false, int? chapterId}){
  return Container(
    width: 400,
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
                      var existingInfo = chapterInputs.firstWhere(
                        (info) => info.controller == controller,
                        orElse: () => ChapterInfo(controller: controller, title: ''),
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
                      Row(
                        children: [
                          Text(
                            'Edit info',
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
                          GestureDetector(
                            onTap: () async {
                              int newChapterId = await insertChapter(widget.courseId, controller.text);
                              setState(() {
                                chapterId = newChapterId;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FileUploadPage(userId: widget.userId, courseId: widget.courseId, chapterId: chapterId)),
                              );
                            },
                            child: Icon(Icons.edit),
                          ),

                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Edit quiz',
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
                          GestureDetector(
                            onTap: () async {
                              if (chapterId == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Add info first!!!'),
                                  ),
                                );
                                return;
                              }

                              bool pdfIsNull = await DatabaseHelper().isPdfNull(chapterId);

                              if (pdfIsNull) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Add info first'),
                                    content: Text('You need to add info before editing the quiz.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Questiontype(userId: widget.userId, courseId: widget.courseId, chapterId: chapterId)),
                                );
                              }
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
  }*/


  Future<int> insertChapter(int courseId, String title) async  {
    var dbHelper = DatabaseHelper();
    int chapterId = await dbHelper.newChapter({
      'title': title,
    }, courseId);

    print("the chapterId is equal to");
    print(chapterId);
    if (chapterId == -1) {
      print('Failed to insert chapter into the database');
      return -1;
    }
    return chapterId;
  }



/*
Future<int> insertChapter(int courseId) async {
  int chapterId = await DatabaseHelper().newChapter({
  }, courseId);

  print("the chapterId is equal to");
  print(chapterId);
  if (chapterId == -1) {
    print('Failed to insert chapter into the database');
    return -1;
  }
  return chapterId;
}*/



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
                'Add Chapters',
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
                  itemCount: existingChapters.length,
                  itemBuilder: (context, index) => Container(
                    width: 200,
                    child: inputChapter('Existing Chapter', TextEditingController(text: existingChapters[index]['title']), context, chapterId: existingChapters[index]['id'] as int),
                  ),
                ),

              /*AddChapter(
                onPressed: () {
                  setState(() {
                    TextEditingController newController = TextEditingController();
                    ChapterInfo newChapter = ChapterInfo(controller: newController, title: '');
                    chapterInputs.add(newChapter);
                  });
                },
                buttonText: '+      Add Chapter',
              ),*/
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: chapterInputs.length,
                itemBuilder: (context, index) => Container(
                  width: 200,
                  child: inputChapter('New Chapter', chapterInputs[index].controller, context, ),
                ),
              ),

              SizedBox(height: 20),
              AddChapter(
                onPressed: () {
                  setState(() {
                    TextEditingController newController = TextEditingController();
                    ChapterInfo newChapter = ChapterInfo(controller: newController, title: '');
                    chapterInputs.add(newChapter);
                  });
                },
                buttonText: '+      Add Chapter',
              ),
              /*ListView.builder(
                shrinkWrap: true,
                itemCount: existingChapters.length,
                itemBuilder: (context, index) => Container(
                  width: 200,
                  child: inputChapter('Existing Chapter', TextEditingController(text: existingChapters[index]['title']), context),
                ),
              ),*/

              
              /*AddChapter(
                onPressed: () async {
                  TextEditingController newController = TextEditingController();
                  ChapterInfo newChapter = ChapterInfo(controller: newController, title: '');

                  int chapterId = await insertChapter(widget.courseId);
                  newChapter.controller.text = existingChapters.firstWhere((chapter) => chapter['id'] == chapterId)['title'];

                  setState(() {
                    chapterInputs.add(newChapter);
                  });
                },
                buttonText: '+      Add Chapter',
              ),*/
             /*AddChapter(
                onPressed: () {
                  setState(() {
                    TextEditingController newController = TextEditingController();
                    chapterInputs.add(ChapterInfo(controller: newController, title: ''));
                  });
                },
                buttonText: '+      Add Chapter',
              ),*/
              /*
              AddChapter(
                onPressed: () {
                  setState(() {
                    TextEditingController newController = TextEditingController();
                  });
                },
                buttonText: '+      Add Chapter',
              ),*/
              SizedBox(height: 20),
              CancelButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage1(userId: widget.userId, courseId: widget.courseId)));
                },
                buttonText: 'Cancel',
              ),
              SizedBox(height: 20),
              CancelButton(
                onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage(userId: widget.userId)));
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


class NewCoursePage2 extends StatefulWidget {
  final int userId;
  final int courseId;

  NewCoursePage2({required this.userId, required this.courseId});

  @override
  _NewCoursePage2State createState() => _NewCoursePage2State();
}


