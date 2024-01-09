import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class DrawingPage extends StatefulWidget {
  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  List<DrawingPoint?> points = [];
  Color selectedColor = Colors.black;
  double strokeWidth = 5.0;
  GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawing App'),
        actions: [
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: () {
              _pickColor(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.layers_clear),
            onPressed: () {
              _clearDrawing();
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveDrawing();
            },
          ),
        ],
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            points.add(DrawingPoint(
              points: renderBox.globalToLocal(details.globalPosition),
              paint: Paint()
                ..strokeCap = StrokeCap.round
                ..isAntiAlias = true
                ..color = selectedColor
                ..strokeWidth = strokeWidth,
            ));
          });
        },
        onPanEnd: (details) => points.add(null),
        child: RepaintBoundary(
          key: _globalKey,
          child: CustomPaint(
            painter: DrawingPainter(points),
          ),
        ),
      ),
    );
  }

  void _pickColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                setState(() {
                  selectedColor = color;
                });
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _clearDrawing() {
    setState(() {
      points.clear();
    });
  }

  void _saveDrawing() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImagePreviewPage(pngBytes),
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  List<DrawingPoint?> points;

  DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(
            points[i]!.points, points[i + 1]!.points, points[i]!.paint);
      } else if (points[i] != null && points[i + 1] == null) {
        canvas.drawPoints(
            ui.PointMode.points, [points[i]!.points], points[i]!.paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DrawingPoint {
  Offset points;
  Paint paint;

  DrawingPoint({required this.points, required this.paint});
}

class ImagePreviewPage extends StatelessWidget {
  final Uint8List imageBytes;

  ImagePreviewPage(this.imageBytes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Preview'),
      ),
      body: Center(
        child: Image.memory(imageBytes),
      ),
    );
  }
}
