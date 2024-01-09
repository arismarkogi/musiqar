import 'package:flutter/material.dart';


Widget buildMenuItem(BuildContext context, String title, Widget page) {
  return InkWell(
    onTap: () {
      // Navigate to the specified page
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    },
    child: Container(
      width: double.infinity, // Take the full width of the parent
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF6750A4),
              fontSize: 28,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              height: 0.05,
              letterSpacing: 0.10,
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    ),
  );
}