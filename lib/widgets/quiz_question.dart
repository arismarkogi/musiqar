import 'package:flutter/material.dart';

Widget question(int number, String text){
  return Column(
    children: [
      SizedBox(
        width: 138,
        height: 25,
        child: Text(
          'Question $number',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            height: 0.06,
          ),
        ),
      ),
      SizedBox(height: 20),
      SizedBox(
        width: 350,
        height: 75,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
          ),
          overflow: TextOverflow.ellipsis, // Handles overflow
          maxLines: 5, // Limits to two lines
        ),
      )
    ],
  );
}