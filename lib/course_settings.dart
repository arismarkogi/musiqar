import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'course_settings_with_file.dart';
import 'widgets/custom_input.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'course_settings_with_file.dart';
import 'widgets/custom_input.dart';

class FileUploadPage extends StatefulWidget {
  final int userId;
  final int courseId;
  final int chapterId;

  FileUploadPage(
      {required this.userId, required this.courseId, required this.chapterId});

  @override
  _FileUploadPageState createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  String filePath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles();

                if (result != null) {
                  final file = File(result.files.single.path!);
                  final appDocumentDir =
                      await getApplicationDocumentsDirectory();
                  final localFilePath =
                      '${appDocumentDir.path}/${result.files.single.name}';
                  await file.copy(localFilePath);

                  // Store the file path in the database
                  // You need to implement the appropriate method in your DatabaseHelper
                  // to store the file path associated with the user ID
                  // For example: DatabaseHelper().storeFilePath(widget.userId, localFilePath);

                  setState(() {
                    filePath = localFilePath;
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FileOpenPage(
                          filePath: filePath,
                          userId: widget.userId,
                          courseId: widget.courseId,
                          chapterId: widget.chapterId),
                    ),
                  );
                }
              },
              child: Text('Upload File'),
            ),
          ],
        ),
      ),
    );
  }
}
