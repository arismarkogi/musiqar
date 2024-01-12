<<<<<<< HEAD
import 'package:flutter/material.dart';

Widget CancelButton({
  required VoidCallback onPressed,
  required String buttonText,
  Widget? child,
}) {
  return Container(
    width: 120,
    height: 40,
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Color(0xFF681F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0.10,
                letterSpacing: 0.10,
              ),
            ),
            if (child != null) SizedBox(width: 6),
            if (child != null) child,
          ],
        ),
      ),
    ),
  );
}
=======
import 'package:flutter/material.dart';

Widget CancelButton({
  required VoidCallback onPressed,
  required String buttonText,
  Widget? child,
}) {
  return Container(
    width: 120, // Increase the width as needed
    height: 40,
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Color(0xFF681F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4), // Adjust padding
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0.10,
                letterSpacing: 0.10,
              ),
            ),
            if (child != null) SizedBox(width: 6),
            if (child != null) child,
          ],
        ),
      ),
    ),
  );
}
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
