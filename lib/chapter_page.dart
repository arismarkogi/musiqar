import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'menu_page.dart';
import 'widgets/chapter_element.dart';
import 'widgets/purple_button.dart';
import 'course_page.dart';

String chapterName = "chapterName";
String pdfURL = "assets/dummy.pdf";



class ChapterPage extends StatelessWidget {

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
              Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage()));
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
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
                "Tap to download and open the chapter",
                "assets/pdf.png",
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SfPdfViewer.asset(pdfURL),
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
                    MaterialPageRoute(builder: (context) => CoursePage()),
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
                    MaterialPageRoute(builder: (context) => CoursePage()),
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
                    MaterialPageRoute(builder: (context) => CoursePage()),
                  );

                },
              ),
            ),
          ],
        )

    );
  }
}
