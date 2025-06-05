import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: SimpleDrawingTool()));

class SimpleDrawingTool extends StatefulWidget {
  const SimpleDrawingTool({super.key});

  @override
  State<SimpleDrawingTool> createState() => _SimpleDrawingToolState();
}

class _SimpleDrawingToolState extends State<SimpleDrawingTool> {
  List<_DrawPoint?> points = [];
  bool isErasing = false;

  void _toggleEraser() {
    setState(() {
      isErasing = !isErasing;
    });
  }

  void _clearCanvas() {
    setState(() {
      points.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isErasing ? 'Eraser Mode' : 'Drawing Tool', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.brush),
            tooltip: 'Toggle Eraser',
            onPressed: _toggleEraser,
              color: Colors.white
          ),
          IconButton(
            icon: const Icon(Icons.clear),
            tooltip: 'Clear Canvas',
            onPressed: _clearCanvas,
            color: Colors.white
          ),
        ],
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          RenderBox renderBox = context.findRenderObject() as RenderBox;
          Offset localPos = renderBox.globalToLocal(details.globalPosition);
          setState(() {
            points.add(_DrawPoint(
              position: localPos,
              color: isErasing ? Colors.white : Colors.deepPurple,
              strokeWidth: isErasing ? 20.0 : 4.0,
            ));
          });
        },
        onPanEnd: (_) => setState(() => points.add(null)),
        child: CustomPaint(
          painter: _DrawingPainter(points),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _DrawPoint {
  final Offset position;
  final Color color;
  final double strokeWidth;

  _DrawPoint({required this.position, required this.color, required this.strokeWidth});
}

class _DrawingPainter extends CustomPainter {
  final List<_DrawPoint?> points;
  _DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      if (p1 != null && p2 != null) {
        final paint = Paint()
          ..color = p1.color
          ..strokeWidth = p1.strokeWidth
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(p1.position, p2.position, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DrawingPainter oldDelegate) => true;
}
