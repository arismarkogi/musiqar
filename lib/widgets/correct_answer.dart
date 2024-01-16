import 'package:flutter/material.dart';
import 'dart:io';

Widget correctAnswer(
  int index,
  String question,
  String correctAnswerURL,
  String yourAnswerURL,
  bool isImage,
  bool isCorrect,
) {
  ImageProvider<Object> correctAnswerImageProvider;
  ImageProvider<Object> yourAnswerImageProvider;

  if (correctAnswerURL.startsWith('assets')) {
    correctAnswerImageProvider = AssetImage(correctAnswerURL);
  } else {
    correctAnswerImageProvider = FileImage(File(correctAnswerURL));
  }

  if (yourAnswerURL.startsWith('assets')) {
    yourAnswerImageProvider = AssetImage(yourAnswerURL);
  } else {
    yourAnswerImageProvider = FileImage(File(yourAnswerURL));
  }

  Color backgroundColor = isCorrect ? Colors.green : Colors.red;

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Question $index',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.underline,
          ),
        ),
        SizedBox(height: 12),
        Text(
          question,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
          ),
        ),
        SizedBox(height: 12),
        if (!isImage) ...[
          _buildAnswerRow('Correct Answer:', correctAnswerURL),
          _buildAnswerRow('Your Answer:', yourAnswerURL),
        ],
        if (isImage) ...[
          _buildImageRow('Correct Answer:', correctAnswerImageProvider),
          _buildImageRow('Your Answer:', yourAnswerImageProvider),
        ],
      ],
    ),
  );
}

Widget _buildAnswerRow(String label, String answer) {
  return Text(
    '$label $answer',
    style: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
  );
}

Widget _buildImageRow(String label, ImageProvider<Object> imageProvider) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
      ),
      SizedBox(
        height: 8,
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image(
          image: imageProvider,
          height: 100,
          width: 150,
          fit: BoxFit.cover,
        ),
      ),
    ],
  );
}
