import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'data/database_helper.dart';
import 'package:open_file/open_file.dart';
import 'course_settings.dart';
import 'new_course_page2.dart';
import 'widgets/custom_input.dart';
import 'widgets/cancel_button.dart';
import 'course_info_provider.dart';
import 'package:provider/provider.dart';
import 'new_course_page2.dart';
import 'new_course_page1.dart';
import 'package:vibration/vibration.dart';

class FileOpenPage extends StatefulWidget {
  final int userId;
  final String filePath;
  final int courseId;
  final int chapterId;

  FileOpenPage(
      {required this.userId,
      required this.courseId,
      required this.chapterId,
      required this.filePath,
      Key? key})
      : super(key: key);

  @override
  _FileOpenPageState createState() => _FileOpenPageState();
}

class _FileOpenPageState extends State<FileOpenPage> {
  TextEditingController filename = TextEditingController();

  @override
  void dispose() {
    filename.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Open'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await _deleteFile();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FileUploadPage(
                        userId: widget.userId,
                        courseId: widget.courseId,
                        chapterId: widget.chapterId)),
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
            Text(widget.filePath),
            SizedBox(height: 20),
            /*ElevatedButton(
              onPressed: () {
                _openFile(widget.filePath);
              },
              child: Text('Open File'),
            ),*/
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
            SizedBox(height: 50),
            CancelButton(
              onPressed: () async {
                String filenameText = filename.text;
                if (filenameText.isNotEmpty) {
                  await DatabaseHelper().updateChapterPdf(
                      widget.chapterId, filenameText, widget.filePath);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewCoursePage2(
                              userId: widget.userId,
                              courseId: widget.courseId)));
                } else {
                  Vibration.vibrate(duration: 500);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter a value for filename.'),
                    ),
                  );
                  print('Filename cannot be empty');
                }
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

  Future<void> _deleteFile() async {
    try {
      final file = File(widget.filePath);
      if (await file.exists()) {
        await file.delete();
      }

      print('File deleted successfully');
    } catch (e) {
      print('Error deleting file: $e');
    }
  }
}
