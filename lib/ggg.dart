import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';
import 'package:flutter_drawing_board/paint_extension.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'new_course_page2.dart';
import 'widgets/save_button.dart';
import 'ViewDrawingPage.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/rendering.dart';

class Triangle extends PaintContent {
  Triangle();

  Triangle.data({
    required this.startPoint,
    required this.A,
    required this.B,
    required this.C,
    required Paint paint,
  }) : super.paint(paint);

  factory Triangle.fromJson(Map<String, dynamic> data) {
    return Triangle.data(
      startPoint: jsonToOffset(data['startPoint'] as Map<String, dynamic>),
      A: jsonToOffset(data['A'] as Map<String, dynamic>),
      B: jsonToOffset(data['B'] as Map<String, dynamic>),
      C: jsonToOffset(data['C'] as Map<String, dynamic>),
      paint: jsonToPaint(data['paint'] as Map<String, dynamic>),
    );
  }

  Offset startPoint = Offset.zero;

  Offset A = Offset.zero;
  Offset B = Offset.zero;
  Offset C = Offset.zero;

  @override
  void startDraw(Offset startPoint) => this.startPoint = startPoint;

  @override
  void drawing(Offset nowPoint) {
    A = Offset(
        startPoint.dx + (nowPoint.dx - startPoint.dx) / 2, startPoint.dy);
    B = Offset(startPoint.dx, nowPoint.dy);
    C = nowPoint;
  }

  @override
  void draw(Canvas canvas, Size size, bool deeper) {
    final Path path = Path()
      ..moveTo(A.dx, A.dy)
      ..lineTo(B.dx, B.dy)
      ..lineTo(C.dx, C.dy)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  Triangle copy() => Triangle();

  @override
  Map<String, dynamic> toContentJson() {
    return <String, dynamic>{
      'startPoint': startPoint.toJson(),
      'A': A.toJson(),
      'B': B.toJson(),
      'C': C.toJson(),
      'paint': paint.toJson(),
    };
  }
}


class Drawpage extends StatefulWidget {
  const Drawpage({Key? key}) : super(key: key);

  @override
  State<Drawpage> createState() => _Drawpage();
}

class _Drawpage extends State<Drawpage> {
  final GlobalKey _repaintKey = GlobalKey();
  final DrawingController _drawingController = DrawingController();
  final ScreenshotController _screenshotController = ScreenshotController();


  @override
  void dispose() {
    _drawingController.dispose();
    super.dispose();
  }


  Future<void> _getImageData(BuildContext context) async {
  print('Calling _getImageData');
  final Uint8List? data = (await _drawingController.getImageData())?.buffer.asUint8List();
  if (data == null) {
    debugPrint('Error getting image data');
    return;
  }

  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/drawing_image.png';

  try {
    await File(filePath).writeAsBytes(data);
    debugPrint('Image saved at: $filePath');

    // Navigate to a new page to view the saved drawing
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewDrawingPage(imagePath: filePath),
      ),
    );
  } catch (e) {
    debugPrint('Error saving image: $e');
  }
}

  Future<void> _getJson(BuildContext context) async {
    showDialog<void>(
      context: context,
      builder: (BuildContext c) {
        return Center(
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () => Navigator.pop(c),
              child: Container(
                constraints:
                const BoxConstraints(maxWidth: 500, maxHeight: 800),
                padding: const EdgeInsets.all(20.0),
                child: SelectableText(
                  const JsonEncoder.withIndent('  ')
                      .convert(_drawingController.getJsonList()),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

Future<void> _saveImage(BuildContext context) async {
  final Uint8List? data = await _takeScreenshot();
  if (data == null) {
    debugPrint('Error capturing screenshot');
    return;
  }

  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/drawing_image.png';

  try {
    await File(filePath).writeAsBytes(data);
    debugPrint('Image saved at: $filePath');

    // Navigate to the new page after saving
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewDrawingPage(imagePath: filePath),
      ),
    );
  } catch (e) {
    debugPrint('Error saving image: $e');
  }
}

Future<Uint8List?> _takeScreenshot() async {
  try {
    RenderRepaintBoundary boundary = _repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    
    if (byteData != null) {
      Uint8List screenshot = byteData.buffer.asUint8List();
      return screenshot;
    } else {
      debugPrint('Error capturing screenshot: ByteData is null');
      return null;
    }
  } catch (e) {
    debugPrint('Error capturing screenshot: $e');
    return null;
  }
}







  
  @override
Widget build(BuildContext context) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
    backgroundColor: Colors.grey,
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: Color(0xFFFEF7FF),
      title: Center(
        child: Image.asset(
          'assets/logo.png',
          width: 150,
          height: 50,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () {
            _getImageData(context);
          },
        ),
      ],
    ),
    body: Column(
      children: <Widget>[
        Expanded(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return DrawingBoard(
                controller: _drawingController,
                background: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  color: Colors.white,
                ),
                showDefaultActions: true,
                showDefaultTools: true,
                defaultToolsBuilder: (Type t, _) {
                  return DrawingBoard.defaultTools(t, _drawingController)
                    ..insert(
                      1,
                      DefToolItem(
                        icon: Icons.change_history_rounded,
                        isActive: t == Triangle,
                        onTap: () =>
                            _drawingController.setPaintContent(Triangle()),
                      ),
                    );
                },
              );
            },
          ),
        ),
      ],
    ),
  );
}


}