import 'package:flutter/material.dart';

Widget myCourse(String courseName, String instructorName, String imageURL,
    double completionRate, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 340,
      height: 142,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: 340,
          height: 80,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 1, color: Color(0xFFCAC4D0)),
              left: BorderSide(width: 1, color: Color(0xFFCAC4D0)),
              right: BorderSide(width: 1, color: Color(0xFFCAC4D0)),
              bottom: BorderSide.none,
            ),
          ),
          child: Row(
            children: [
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
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        courseName,
                        style: TextStyle(
                          color: const Color(0xFF1D1B20),
                          fontSize: 20,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          height: 0.06,
                          letterSpacing: 0.15,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        instructorName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF1D1B20),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 0.10,
                          letterSpacing: 0.25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 340,
          height: 62,
          decoration: BoxDecoration(
            color: Color(0xFFF0F0F0),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            border: Border(
              left: BorderSide(width: 1, color: Color(0xFFCAC4D0)),
              right: BorderSide(width: 1, color: Color(0xFFCAC4D0)),
              top: BorderSide.none,
              bottom: BorderSide(width: 1, color: Color(0xFFCAC4D0)),
            ),
          ),
          child: Column(children: [
            SizedBox(height: 20),
            SizedBox(
              width: 111,
              height: 19,
              child: Text(
                '${(completionRate * 100).toStringAsFixed(0)}% Completed',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 0.10,
                  letterSpacing: 0.10,
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              width: 320,
              child: LinearProgressIndicator(
                value: completionRate,
                backgroundColor: Color(0xFFE6E0E9),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6750A4)),
              ),
            )
          ]),
        ),
      ]),
    ),
  );
}
