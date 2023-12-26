import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'course_settings_with_file.dart';
import 'widgets/custom_input.dart';

class FileUploadPage extends StatefulWidget {
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
                  setState(() {
                    filePath = result.files.single.path!;
                  });

                  // Navigate to the second page after file upload
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FileOpenPage(filePath: filePath),
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
