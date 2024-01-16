import 'package:flutter/material.dart';
import 'package:musIQAR/data/database_helper.dart';
import 'widgets/chapter.dart';
import 'widgets/course_in_chapter.dart';
import 'profile_page.dart';
import 'menu_page.dart';
import 'chapter_page.dart';

class CoursePage extends StatefulWidget {
  final int userId;
  final int courseId;

  CoursePage({required this.userId, required this.courseId, Key? key})
      : super(key: key);

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  String courseName = "";
  String instructorName = "";
  String imageURL = "";
  List<Map<String, dynamic>> chapters = [];

  @override
  void initState() {
    super.initState();
    fetchCourseInfo();
    fetchChapters();
  }

  Future<void> fetchCourseInfo() async {
    List<Map<String, dynamic>> courseInfo =
        await DatabaseHelper().getCourseInfo(widget.courseId);

    setState(() {
      if (courseInfo.isNotEmpty) {
        courseName = courseInfo[0]['title'];
        instructorName = courseInfo[0]['name'];
        imageURL = courseInfo[0]['image_url'];
      }
    });
  }

  Future<void> fetchChapters() async {
    List<Map<String, dynamic>> fetchedChapters =
        await DatabaseHelper().getChapters(widget.courseId, widget.userId);

    setState(() {
      chapters = fetchedChapters;
    });
  }

  Future<bool> isChapterCompleted(int chapterId) async {
    bool completed =
        await DatabaseHelper().isChapterCompleted(widget.userId, chapterId);

    return completed;
  }

  Future<void> changeHasCompleted(int chapterId) async {
    bool isCompleted =
        await DatabaseHelper().isChapterCompleted(widget.userId, chapterId);
    await DatabaseHelper()
        .updateHasCompleted(widget.userId, chapterId, isCompleted);
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
                builder: (context) => MenuPage(userId: widget.userId),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(userId: widget.userId),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Align(
              alignment: Alignment.center,
              child: chapterCourse(courseName, instructorName, imageURL),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemCount: chapters.length,
              separatorBuilder: (context, _) => SizedBox(height: 8),
              itemBuilder: (context, index) => SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: chapter(
                    chapters[index]['chapter_title'],
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChapterPage(
                            userId: widget.userId,
                            courseId: widget.courseId,
                            chapterId: chapters[index]['id'],
                          ),
                        ),
                      );
                    },
                    isChapterCompleted(chapters[index]['id']),
                    (bool? newValue) =>
                        changeHasCompleted(chapters[index]['id']),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
