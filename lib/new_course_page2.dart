import 'package:flutter/material.dart';
import 'homepage.dart';
import 'new_course_page1.dart';
import 'new_course_page3.dart';
import 'widgets/add_chapter.dart';
import 'widgets/cancel_button.dart';
import 'course_settings.dart';

class _NewCoursePage2State extends State<NewCoursePage2> {
  List<Widget> chapterInputs = []; // List to store dynamically added CustomInputs
  List<String> chaptersTitles = []; // List to store chapter titles/texts


  TextEditingController Chapters = TextEditingController();



  Widget inputChapter(String labelText, TextEditingController controller, BuildContext context,int index, {bool isPassword = false}) {
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
                  // Add TextField for input
                  Expanded(
                    child: TextField(
                      obscureText: isPassword,
                      controller: controller,
                      onChanged: (text) {
                        setState(() {
                          chaptersTitles[index] = text; // Update the text for the specific chapter index
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: labelText,
                      ),
                    ),
                  ),
                  SizedBox(width: 8), // Add some spacing between the input field and additional content
                  // Use a Column for the text and icons
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Add the first line of text with clickable icon
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
                              // Navigate to the homepage
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FileUploadPage()),
                              );
                            },
                            child: Icon(Icons.edit),
                          ),
                        ],
                      ),
                      // Add the second line of text with clickable icon
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
                            onTap: () {
                              // Navigate to the homepage
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => NewCoursePage3()),
                              );
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
              // customInput('Chapter', Chapters, context),
              // SizedBox(height: 20),
              // Dynamically added CustomInputs
              ListView.builder(
                shrinkWrap: true,
                itemCount: chapterInputs.length,
                itemBuilder: (context, index) => Container(
                  width: 200, // Set a fixed width for the dynamically added items
                  child: chapterInputs[index],
                ),
              ),
              SizedBox(height: 20),
              AddChapter(
                onPressed: () {
                  setState(() {
                    TextEditingController newController = TextEditingController();
                    chapterInputs.add(inputChapter('New Chapter', newController, context, chapterInputs.length));
                    chaptersTitles.add(''); // Initialize an empty title for the new chapter
                  });
                },
                buttonText: '+      Add Chapter',
              ),
              SizedBox(height: 20),
              CancelButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage1()));
                },
                buttonText: 'Cancel',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewCoursePage2 extends StatefulWidget {
  @override
  _NewCoursePage2State createState() => _NewCoursePage2State();
}


