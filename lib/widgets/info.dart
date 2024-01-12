import 'package:flutter/material.dart';

Widget info(String name) {
  return Container(
    width: 340,
    height: 144.24,
    child: Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            width: 106,
            height: 108,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('sax.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Positioned(
          left: 92.24,
          top: 71.76,
          child: Transform(
            transform: Matrix4.identity()
              ..translate(0.0, 0.0)
              ..rotateZ(0.28),
            child: Container(
              width: 54,
              height: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/piano.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 137,
          top: 2,
          child: Container(
            width: 197,
            height: 86,
            decoration: ShapeDecoration(
              color: Color(0xFFFAFAFA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(43.0),
                side: BorderSide(
                  width: 1,
                  color: Colors.black,
                  style: BorderStyle.solid,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 137,
          top: 2,
          child: Container(
            width: 197,
            height: 86,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                  letterSpacing: 0.50,
                ),
                softWrap: true,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
