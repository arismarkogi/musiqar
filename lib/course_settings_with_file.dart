import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'course_settings.dart';
import 'new_course_page2.dart';
import 'widgets/custom_input.dart';
import 'widgets/cancel_button.dart';


class FileOpenPage extends StatelessWidget {
  final String filePath;
  TextEditingController filename = TextEditingController();

  FileOpenPage({required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Open'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FileUploadPage()),
            );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'File path',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF6750A4),
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 0.10,
                  letterSpacing: 0.10,
                ),
              ),
            SizedBox(height: 8),
            Text(filePath),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _openFile(filePath);
              },
              child: Text('Open File'),
            ),
            SizedBox(height: 30),
            Text(
              'Enter the name of the file',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF6750A4),
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                height: 0.10,
                letterSpacing: 0.10,
              ),
            ),
            SizedBox(height: 30),
            customInput('Filename', filename, context: context),
            SizedBox(height: 50, width: 150),
            CancelButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage2()));
              },
              buttonText: 'Save',
            ),
          ],
        ),
      ),
    );
  }

  void _openFile(String filePath) async {
    final result = await OpenFile.open(filePath);

    if (result.type == ResultType.done) {
      print('File opened successfully');
    } else {
      print('Error opening file: ${result.message}');
    }
  }

}