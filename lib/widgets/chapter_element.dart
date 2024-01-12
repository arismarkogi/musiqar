<<<<<<< HEAD
import 'package:flutter/material.dart';

Widget chapterElement(String descText, String imageURL, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 340,
      height: 107,
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        children: [
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 220,
                  child: Text(
                    descText,
                    style: TextStyle(
                      color: Color(0xFF1D1B20),
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                      letterSpacing: 0.15,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageURL),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
    ),
  );
}
=======
import 'package:flutter/material.dart';


Widget chapterElement(String descText, String imageURL, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 340,
      height: 107,
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(15.0),

      ),
      child: Row(
        children: [
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 220, 
                  child: Text(
                    descText,
                    style: TextStyle(
                      color: Color(0xFF1D1B20),
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                      letterSpacing: 0.15,
                    ),
                    softWrap: true, 
                    overflow: TextOverflow.visible, 
                  ),
                ),

              ],
            ),
          ),
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageURL),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SizedBox(width: 8),

        ],
      ),
    ),
  );
}
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
