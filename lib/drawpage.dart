import 'package:flutter/material.dart';
import 'package:musIQAR/data/database_helper.dart';
import 'new_course_page7.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'new_course_page7.dart';
import 'package:uuid/uuid.dart';

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
      startPoint: Offset(data['startPoint']['dx'] as double,
          data['startPoint']['dy'] as double),
      A: Offset(data['A']['dx'] as double, data['A']['dy'] as double),
      B: Offset(data['B']['dx'] as double, data['B']['dy'] as double),
      C: Offset(data['C']['dx'] as double, data['C']['dy'] as double),
      paint: Paint()
        ..color = Color(int.parse(data['paint']['color'] as String)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startPoint': {'dx': startPoint.dx, 'dy': startPoint.dy},
      'A': {'dx': A.dx, 'dy': A.dy},
      'B': {'dx': B.dx, 'dy': B.dy},
      'C': {'dx': C.dx, 'dy': C.dy},
      'paint': {'color': paint.color.value.toRadixString(16)},
    };
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
      startPoint.dx + (nowPoint.dx - startPoint.dx) / 2,
      startPoint.dy,
    );
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

extension OffsetExtension on Offset {
  Map<String, dynamic> toJson() {
    return {
      'dx': this.dx,
      'dy': this.dy,
    };
  }
}

extension PaintExtension on Paint {
  Map<String, dynamic> toJson() {
    return {
      'color': this.color.value.toRadixString(16),
    };
  }
}

class Drawpage extends StatefulWidget {
  final int userId;
  final int courseId;
  final int chapterId;
  final int questionId;

  Drawpage(
      {required this.userId,
      required this.courseId,
      required this.chapterId,
      required this.questionId,
      Key? key})
      : super(key: key);

  @override
  State<Drawpage> createState() => _Drawpage();
}

class _Drawpage extends State<Drawpage> {
  final GlobalKey _repaintKey = GlobalKey();
  final DrawingController _drawingController = DrawingController();

  final ScreenshotController _screenshotController = ScreenshotController();

Future<void> _getImageData(BuildContext context) async {
  print('Calling _getImageData');
  try {
    setState(() {});

    await Future.delayed(const Duration(milliseconds: 300));

    Uint8List? data = await _screenshotController.capture();

    if (data != null) {
      final String uniqueId = Uuid().v4(); // Use a unique identifier library
      final Directory directory = await getApplicationDocumentsDirectory();
      final String filePath = '${directory.path}/drawing_image_$uniqueId.png';

      await File(filePath).writeAsBytes(data);
      debugPrint('Image saved at: $filePath');

      DatabaseHelper().addanswers(widget.questionId, filePath, 1, "Draw");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewCoursePage7(
              imagePath: filePath,
              userId: widget.userId,
              courseId: widget.courseId,
              chapterId: widget.chapterId,
              questionId: widget.questionId),
        ),
      );
    } else {
      debugPrint('Error capturing image');
    }
  } catch (e) {
    debugPrint('Error in _getImageData: $e');
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
      body: Screenshot(
        controller: _screenshotController,
        child: Column(
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
      ),
    );
  }
}
