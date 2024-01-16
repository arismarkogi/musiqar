import 'dart:io';

import 'package:flutter/material.dart';
import 'purple_button.dart';

Widget AvailableCourse(
  String courseName,
  String instructorName,
  String courseInfo,
  String imageURL,
  VoidCallback onPressed,
) {
  ImageProvider<Object> imageProvider;

  if (imageURL.startsWith('assets')) {
    imageProvider = AssetImage(imageURL);
  } else {
    imageProvider = FileImage(File(imageURL));
  }

  return Container(
    width: 240,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(width: 1, color: Color(0xFFCAC4D0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 150,
          width: 240,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
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
                "Instructor: $instructorName",
                style: TextStyle(
                  color: Color(0xFF49454F),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Center(
              child: Text(
                courseInfo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  letterSpacing: 0.25,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.bottomCenter,
          child: PurpleButton("Delete", onPressed),
        ),
        SizedBox(height: 4)
      ],
    ),
  );
}
