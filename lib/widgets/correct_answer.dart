import 'package:flutter/material.dart';

// correctAnswer and yourAnswer are URLs when isImage is true
Widget correctAnswer(int index, String correctAnswer, String yourAnswer, bool isImage){
  return Column(
    children: [
      Container(
        width: 340,
        height: (isImage)?50:100,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: SizedBox(
                width: 238,
                height: 36,
                child: Text(
                  'Question $index',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            if(!isImage)
              Positioned(
                left: 0,
                top: 80,
                child: SizedBox(
                  width: 238,
                  height: 36,
                  child: Text(
                    'Correct Answer: $correctAnswer',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.15,
                    ),
                  ),
                ),
              ),
            if(!isImage)
            Positioned(
                left: 0,
                top: 39,
                child: SizedBox(
                  width: 238,
                  height: 36,
                  child: Text(
                    'Your Answer: $yourAnswer',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.15,
                    ),
                  ),
                ),
              ),

          ],
        ),
      ),
      if(isImage)
        Positioned(
          left: 0,
          top: 80,
          child: SizedBox(
            width: 340,
            height: 36,
            child: Text(
              'Correct Answer:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.15,
              ),
            ),
          ),
        ),
      if(isImage)
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(correctAnswer),
              fit: BoxFit.fitHeight, // Adjusted fit
              //alignment: Alignment.topCenter,
            ),
          ),
        ),
      if (isImage)
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 30.0, top: 20.0), // Adjust left padding as needed
            child: SizedBox(
              width: 238,
              height: 36,
              child: Text(
                'Your Answer:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15,
                ),
              ),
            ),
          ),
        ),
        if(isImage)
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(yourAnswer),
                fit: BoxFit.fitHeight, // Adjusted fit
                //alignment: Alignment.topCenter,
              ),
            ),
          ),

    ],
  );
}