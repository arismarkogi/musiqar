import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'course_settings.dart';
import 'new_course_page2.dart';
import 'widgets/custom_input.dart';
import 'widgets/cancel_button.dart';
import 'course_info_provider.dart';
import 'package:provider/provider.dart';
import 'new_course_page2.dart';
import 'new_course_page1.dart';


class FileOpenPage extends StatefulWidget {
  final int userId;
  final String filePath;
  final int courseId;

  FileOpenPage({required this.userId, required this.courseId, required this.filePath, Key? key})
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
    var courseProvider = context.watch<CourseInfoProvider>();

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
                MaterialPageRoute(builder: (context) => FileUploadPage(userId: widget.userId, courseId: widget.courseId)),
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
            ElevatedButton(
              onPressed: () {
                _openFile(widget.filePath);
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
            SizedBox(height: 50),
            CancelButton(
              onPressed: () {
                courseProvider.addChapter(ChapterInfo(controller: filename, title: filename.text));
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewCoursePage2(userId: widget.userId, courseId: widget.courseId)));
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

      // Implement the method to delete the file path from the database
      // For example: DatabaseHelper().deleteFilePath(widget.userId);

      print('File deleted successfully');
    } catch (e) {
      print('Error deleting file: $e');
    }
  }
}
