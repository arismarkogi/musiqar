import 'package:flutter/material.dart';

Widget sline() {
  return Container(
    width: 288,
    decoration: ShapeDecoration(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1,
          strokeAlign: BorderSide.strokeAlignCenter,
          color: Color(0xFFCAC4D0),
        ),
      ),
    ),
  );
}
