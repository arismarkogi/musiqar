import 'package:flutter/material.dart';
import 'drawpage.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:io';

class ViewDrawingPage extends StatelessWidget {
   const ViewDrawingPage({Key? key, required this.imagePath}) : super(key: key);

   final String imagePath;

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
        //automaticallyImplyLeading: false,
        centerTitle: true,
        title: Center(
          child: Image.asset(
            'assets/logo.png',
            width: 120,
            height: 40,
          ),
        ),
      ),
       body: Center(
         child: Image.file(File(imagePath)),
       ),
     );
   }
}

