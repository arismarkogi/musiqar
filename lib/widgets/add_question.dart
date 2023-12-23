import 'package:flutter/material.dart';

Widget AddQuestion({
  required VoidCallback onPressed,
  required String buttonText,
  Widget? child,
}) {
  return Container(
    height: 40,
    child: TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Color.fromARGB(255, 32, 11, 125), width: 2),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: TextStyle(
                color: Color.fromARGB(255, 32, 11, 125),
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0.12,
                letterSpacing: 0.10,
              ),
            ),
            if (child != null) SizedBox(width: 12),
            if (child != null) child,
          ],
        ),
      ),
    ),
  );
}
