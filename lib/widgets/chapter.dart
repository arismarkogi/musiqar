<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'checkbox.dart';

Widget chapter(String chapterName, VoidCallback onTap) {
  bool isChecked = false;

  return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 330,
        decoration: BoxDecoration(color: const Color(0xFFCAC4D0)),
        child: Row(
          children: [
            SizedBox(width: 8),
            CheckboxCustom(initialValue: false),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  chapterName,
                  style: TextStyle(
                    color: Color(0xFF1D1B20),
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    letterSpacing: 0.15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ));
}
=======
import 'package:flutter/material.dart';
import 'checkbox.dart'; // Assuming CheckboxExample resides in checkbox.dart

Widget chapter(String chapterName,VoidCallback onTap) {
  bool isChecked = false; // Track the state of the checkbox

  return GestureDetector(
    onTap: onTap,
    child: Container(
    width: 330,
    decoration: BoxDecoration(color: const Color(0xFFCAC4D0)),
    child: Row(
      children: [
        SizedBox(width: 8),
        CheckboxCustom(initialValue: false),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              chapterName,
              style: TextStyle(
                color: Color(0xFF1D1B20),
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                height: 1.2,
                letterSpacing: 0.15,
              ),
            ),
          ],
        ),
      ],
    ),
    )
  );
}
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
