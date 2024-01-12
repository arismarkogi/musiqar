import 'package:flutter/material.dart';

Widget gyrAnswer(String text) {
  return Container(
    width: 170,
    height: 320,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      color: Color(0xFFEDEDED),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 5,
        ),
      ),
    ),
  );
}
