<<<<<<< HEAD
import 'package:flutter/material.dart';

Widget PurpleButton(String myText, VoidCallback onPressed) {
  return Container(
    constraints: BoxConstraints(minWidth: 100),
    height: 50,
    child: TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF6750A4)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
      child: Text(
        myText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
=======
import 'package:flutter/material.dart';

Widget PurpleButton(String myText,VoidCallback onPressed) {
  return Container(
    constraints: BoxConstraints(minWidth: 100),
    height: 50,
    child: TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF6750A4)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
      child: Text(
        myText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
