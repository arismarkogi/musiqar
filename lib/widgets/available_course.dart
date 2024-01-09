import 'package:flutter/material.dart';
import 'purple_button.dart';


Widget AvailableCourse(String courseName, String instructorName, String courseInfo, String imageURL, VoidCallback onPressed) {
  return Container(
    width: 240,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(12),
        bottomRight: Radius.circular(12),
      ),
      border: Border(
        left: BorderSide(width: 1, color: Color(0xFFCAC4D0)),
        right: BorderSide(width: 1, color: Color(0xFFCAC4D0)),
        top: BorderSide(width: 1, color: Color(0xFFCAC4D0)),
        bottom: BorderSide(width: 1, color: Color(0xFFCAC4D0)),
      ),
    ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: 240,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageURL),
                fit: BoxFit.contain,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  courseName,
                  style: TextStyle(
                    color: Color(0xFF1D1B20),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  instructorName,
                  style: TextStyle(
                    color: Color(0xFF49454F),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 140.25,
            width: 240,
            padding: EdgeInsets.symmetric(horizontal: 12.0), // Adjust horizontal padding as needed
            child: Center(
              child: Text(
                courseInfo,
                textAlign: TextAlign.center, // Center horizontally
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 1.5, // Adjust the line height as needed
                  letterSpacing: 0.25,
                ),
              ),
            ),
          ),
          SizedBox(height: 8), // Add some space between the course details and the button
          Align(
            alignment: Alignment.center,
            child: PurpleButton("Enroll",onPressed),
          ),
        ],
      ),
    );
}
