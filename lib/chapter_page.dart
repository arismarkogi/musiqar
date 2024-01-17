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
import 'dart:math';
import 'earth_ar.dart';
import 'dart:async';
import 'earth_ar.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:audioplayers/audioplayers.dart';

String chapterName = "chapterName";
String pdfURL = "assets/dummy.pdf";

class ChapterPage extends StatefulWidget {
  final int userId;
  final int courseId;
  final int chapterId;

  

  ChapterPage(
      {required this.userId,
      required this.courseId,
      required this.chapterId,
      Key? key})
      : super(key: key);

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

  Future<List<CameraDescription>> getCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await availableCameras();
  }


  void fetchChapterInfo() async {
    var chapterInfo = await DatabaseHelper().getChapterInfo(widget.chapterId);

    setState(() {
      chapterName = chapterInfo[0]['title'];
      pdfURL = chapterInfo[0]['pdf_url'];
      pdfName = chapterInfo[0]['pdf_name'];

      if (pdfURL.isNotEmpty) {
        if (pdfURL.startsWith('assets')) {
          pdfViewerWidget = SfPdfViewer.asset(pdfURL);
        } else if (pdfURL.startsWith('http') || pdfURL.startsWith('https')) {
          pdfViewerWidget = SfPdfViewer.network(pdfURL);
        } else {
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MenuPage(userId: widget.userId)));
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProfilePage(userId: widget.userId)));
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
              child: chapterElement (
                "Tap to use the AR tools",
                "assets/ar.png",
                () async {
                  List<String> mp3Files = [
                    "Blue.mp3",
                    "saxophone.m4a",
                    "tuba.mp3",
                    "violin.mp3",
                    "guitar.mp3"
                  ];
                  List<String> glbFiles = [
                    "Grand.glb",
                    "saxophone.glb",
                    "tuba.glb",
                    "violin.glb",
                    "guitar.glb"
                  ];

                  int randomIndex = Random().nextInt(mp3Files.length);

                  String randomMp3 = mp3Files[randomIndex];
                  String randomGlb = glbFiles[randomIndex];
                  List<CameraDescription> cameras = await getCameras();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CombinedScreen(
                              camera: cameras.first,
                              musicAsset: "$randomMp3",
                              modelAsset: "assets/$randomGlb",
                            )),
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
                    MaterialPageRoute(
                        builder: (context) => StartQuiz(
                            userId: widget.userId,
                            courseId: widget.courseId,
                            chapterId: widget.chapterId)),
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
                    MaterialPageRoute(
                        builder: (context) => CoursePage(
                              userId: widget.userId,
                              courseId: widget.courseId,
                            )),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
