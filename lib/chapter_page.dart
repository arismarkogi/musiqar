import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'menu_page.dart';
import 'widgets/chapter_element.dart';
import 'widgets/purple_button.dart';
import 'course_page.dart';
import 'start_quiz.dart';
import 'data/database_helper.dart';
import 'dart:io';


String chapterName = "chapterName";
String pdfURL = "assets/dummy.pdf";



class ChapterPage extends StatefulWidget {
  final int userId;
  final int courseId;
  final int chapterId;

  ChapterPage({required this.userId, required this.courseId, required this.chapterId, Key? key}) : super(key: key);

  @override
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  String chapterName = "";
  String pdfURL = "";
  String pdfName = "";
  Widget pdfViewerWidget = Container();


  @override
  void initState() {
    super.initState();
    fetchChapterInfo();
  }

  Future<void> fetchChapterInfo() async {
    // Use your database function to get chapter information
    var chapterInfo = await DatabaseHelper().getChapterInfo(widget.chapterId);

    // Update the widget state with the fetched data
    setState(() {
      chapterName = chapterInfo[0]['title'];
      pdfURL = chapterInfo[0]['pdf_url'];
      pdfName = chapterInfo[0]['pdf_name'];

      if (pdfURL.isNotEmpty) {
        if (pdfURL.startsWith('assets')) {
          pdfViewerWidget = SfPdfViewer.asset(pdfURL);
        } else if (pdfURL.startsWith('http') || pdfURL.startsWith('https')) {
          // Assuming pdfURL is a valid network URL
          pdfViewerWidget = SfPdfViewer.network(pdfURL);
        } else {
          // Assuming pdfURL is a local file path
          pdfViewerWidget = SfPdfViewer.file(File(pdfURL));
        }
      }
    });
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
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage(userId : widget.userId)));
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(userId : widget.userId)));
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                chapterName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 50),
            Center(
              child: chapterElement(
                pdfName,
                "assets/pdf.png",
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => pdfViewerWidget,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: chapterElement(
                "Tap to use the AR tools",
                "assets/ar.png",
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CoursePage(userId: widget.userId, courseId: widget.courseId,)),
                  );

                },
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: chapterElement(
                "Tap to take the quiz",
                "assets/quiz.png",
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StartQuiz(userId: widget.userId, courseId: widget.courseId, chapterId: widget.chapterId)),
                  );

                },
              ),
            ),
            SizedBox(height: 50),
            Center(
              child: PurpleButton(
                "Course Page",
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CoursePage(userId : widget.userId, courseId: widget.courseId,)),
                  );

                },
              ),
            ),
          ],
        )

    );
  }
}
