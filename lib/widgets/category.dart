import 'package:flutter/material.dart';

Widget Category(String label, VoidCallback onPressed) {
  return Column(
    children: [
      Container(
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFF79747E)),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: InkWell(
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(color: Color(0x146750A4)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF6750A4),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 1.0,
                    letterSpacing: 0.10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
