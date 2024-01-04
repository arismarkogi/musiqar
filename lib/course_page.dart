import 'package:flutter/material.dart';
import 'widgets/chapter.dart';
import 'widgets/course_in_chapter.dart';
import 'profile_page.dart';
import 'menu_page.dart';
import 'chapter_page.dart';

// Default values for AvailableCourse
String courseName = "Course Name";
String instructorName = "Instructor Name";
String imageURL = "assets/course.jpg";
String chapterName = "chapterName";



class CoursePage extends StatelessWidget {

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
                itemCount: 20,
                separatorBuilder: (context, _) => SizedBox(height: 8),
                itemBuilder: (context, index) => SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8, // Or any desired width
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20), // Adjust horizontal padding if needed
                      child: chapter(chapterName, () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChapterPage()));
                      } )
                  ),
                ),
              )
            )
    ],
        )
    );
  }
}
