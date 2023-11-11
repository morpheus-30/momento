import 'dart:ui';

import 'package:flutter/material.dart';

class DrawingBoard extends StatefulWidget {
  @override
  State<DrawingBoard> createState() => _DrawingBoardState();
}

class _DrawingBoardState extends State<DrawingBoard> {
  List<DrawingPoint?> points = [];

  void clearCanvas() {
    setState(() {
      points.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onPanStart: (details) {
            addPoint(details.localPosition, constraints.biggest);
          },
          onPanUpdate: (details) {
            addPoint(details.localPosition, constraints.biggest);
          },
          onPanEnd: (details) {
            setState(() {
              points.add(null);
            });
          },
          child: CustomPaint(
            size: constraints.biggest,
            painter: _DrawingPainter(drawingpoints: points),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                iconSize: 40,
                icon: Icon(Icons.refresh),
                onPressed: clearCanvas,
              ),
            ),
          ),
        );
      },
    );
  }

  void addPoint(Offset offset, Size size) {
    if (isPointInsideBounds(offset, size)) {
      setState(() {
        points.add(
          DrawingPoint(
            offset,
            Paint()
              ..color = Colors.black
              ..isAntiAlias = true
              ..strokeWidth = 5
              ..strokeCap = StrokeCap.round,
          ),
        );
      });
    }
  }

  bool isPointInsideBounds(Offset offset, Size size) {
    return offset.dx >= 0 &&
        offset.dx <= size.width &&
        offset.dy >= 0 &&
        offset.dy <= size.height;
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
        canvas.drawLine(drawingpoints[i]!.offset, drawingpoints[i + 1]!.offset,
            drawingpoints[i]!.paint);
      } else if (drawingpoints[i] != null && drawingpoints[i + 1] == null) {
        offsetsList.clear();

        offsetsList.add(drawingpoints[i]!.offset);
        canvas.drawPoints(
            PointMode.points, offsetsList, drawingpoints[i]!.paint);
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
