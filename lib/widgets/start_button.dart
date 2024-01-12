import 'package:flutter/material.dart';

Widget startButton(String myText, VoidCallback onPressed) {
  return Material(
    clipBehavior: Clip.antiAlias,
    borderRadius: BorderRadius.circular(8),
    color: Color(0xFFE8DEF8),
    elevation: 3,
    shadowColor: Color(0x26000000),
    child: InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 166,
        padding: const EdgeInsets.only(top: 6, left: 8, right: 16, bottom: 6),
        child: Center(
          child: Text(
            myText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF1D192B),
              fontSize: 20,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              letterSpacing: 0.10,
            ),
          ),
        ),
      ),
    ),
  );
}
