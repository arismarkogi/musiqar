import 'package:flutter/material.dart';
import 'homepage.dart';
import 'menu_page.dart';
import 'widgets/custom_input.dart';
import 'widgets/cancel_button.dart';
import 'widgets/custom_desc.dart';
import 'new_course_page2.dart';



class NewCoursePage1 extends StatelessWidget {



  TextEditingController coursename = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController description = TextEditingController();


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
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
        ],
      ),
      body:
      Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Course name',
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
            customInput('Course name', coursename, context: context),
            SizedBox(height: 40),
            Text(
              'Category',
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
            customInput('Category', category, context: context),
            SizedBox(height: 40),
            Text(
              'Short Desctription',
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
            customdesc('Short Description', description),
            SizedBox(height:70),
            CancelButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage()));
              },
              buttonText: 'Cancel',
            ),
            SizedBox(height:20),
            CancelButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage2()));
              },
              buttonText: 'Continue',
            ),
          ],
        ),
      ),
    );
  }
}