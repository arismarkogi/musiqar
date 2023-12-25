import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';

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
              child: Text('Upload and Open File'),
            ),
          ],
        ),
      ),
    );
  }
}

class FileOpenPage extends StatelessWidget {
  final String filePath;

  FileOpenPage({required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Open'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('File Path: $filePath'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _openFile(filePath);
              },
              child: Text('Open File'),
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