import 'package:flutter/material.dart';
import 'checkbox.dart';

Widget chapter(String chapterName, VoidCallback onTap, Future<bool> isCompleted,
    void Function(bool?)? onCheckboxChanged) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 330,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFCAC4D0), Color(0xFFE1DCE3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 16),
          CheckboxCustom(
            isCompleted: isCompleted,
            onChanged: onCheckboxChanged,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                chapterName,
                style: TextStyle(
                  color: Color(0xFF1D1B20),
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.15,
                  shadows: [
                    Shadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 2,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              )
            ),
          ),
        ],
      ),
    ),
  );
}
