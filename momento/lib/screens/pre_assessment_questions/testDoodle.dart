import 'dart:ui';

import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return DrawingBoard();
  }
}

class DrawingBoard extends StatefulWidget {
  const DrawingBoard({super.key});

  @override
  State<DrawingBoard> createState() => _DrawingBoardState();
}

class _DrawingBoardState extends State<DrawingBoard> {
  List<DrawingPoint?> points = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanStart: (details) {
          setState(() {
            points.add(
              DrawingPoint(
                  details.localPosition,
                  Paint()
                    ..color = Colors.black
                    ..isAntiAlias = true
                    ..strokeWidth = 5
                    ..strokeCap = StrokeCap.round),
            );
          });
        },
        onPanUpdate: (details) {
          setState(() {
            points.add(
              DrawingPoint(
                  details.localPosition,
                  Paint()
                    ..color = Colors.black
                    ..isAntiAlias = true
                    ..strokeWidth = 5
                    ..strokeCap = StrokeCap.round),
            );
          });
        },
        onPanEnd: (details) {
          setState(() {
            points.add(null);
          });
        },
        child: CustomPaint(
          painter: _DrawingPainter(drawingpoints: points),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }
}

class _DrawingPainter extends CustomPainter {
  
  final List<DrawingPoint?> drawingpoints;

  _DrawingPainter({required this.drawingpoints});

  List<Offset> offsetsList = [];

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < drawingpoints.length - 1; i++) {
      if (drawingpoints[i] != null && drawingpoints[i + 1] != null) {
        canvas.drawLine(
            drawingpoints[i]!.offset, drawingpoints[i + 1]!.offset, drawingpoints[i]!.paint);
      } else if (drawingpoints[i] != null && drawingpoints[i + 1] == null) {
        offsetsList.clear();

        offsetsList.add(drawingpoints[i]!.offset);
        canvas.drawPoints(PointMode.points, offsetsList, drawingpoints[i]!.paint);
      }
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DrawingPoint {
  final Offset offset;
  final Paint paint;

  DrawingPoint(this.offset, this.paint);
}
