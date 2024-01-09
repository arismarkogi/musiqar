import 'package:flutter/material.dart';
Widget Bio(String bio) {
  return Container(
    width: 355,
    height: 195,
    padding: const EdgeInsets.all(16), // Adjust the padding as needed
    clipBehavior: Clip.antiAlias,
    decoration: ShapeDecoration(
      color: Color(0xFFEDEDED),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            '$bio ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              height: 1.5, // Adjust the line spacing as needed
              letterSpacing: 0.10,
            ),
          ),
        ),
      ],
    ),
  );
}
