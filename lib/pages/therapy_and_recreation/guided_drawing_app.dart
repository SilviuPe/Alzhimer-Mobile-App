import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: SimpleDrawingTool()));

class SimpleDrawingTool extends StatefulWidget {
  const SimpleDrawingTool({super.key});

  @override
  State<SimpleDrawingTool> createState() => _SimpleDrawingToolState();
}

class _SimpleDrawingToolState extends State<SimpleDrawingTool> {
  final List<_DrawPoint?> _points = [];
  bool _isErasing = false;

  void _toggleEraser() {
    setState(() {
      _isErasing = !_isErasing;
    });
  }

  void _clearCanvas() {
    setState(() {
      _points.clear();
    });
  }

  void _addPoint(Offset offset) {
    setState(() {
      _points.add(_DrawPoint(
        position: offset,
        color: _isErasing ? Colors.white : Colors.deepPurple,
        strokeWidth: _isErasing ? 20.0 : 4.0,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isErasing ? 'Eraser Mode' : 'Drawing Tool',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.brush),
            tooltip: 'Toggle Eraser',
            onPressed: _toggleEraser,
            color: Colors.white,
          ),
          IconButton(
            icon: const Icon(Icons.clear),
            tooltip: 'Clear Canvas',
            onPressed: _clearCanvas,
            color: Colors.white,
          ),
        ],
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          final RenderBox renderBox = context.findRenderObject() as RenderBox;
          final Offset localPos = renderBox.globalToLocal(details.globalPosition);
          _addPoint(localPos);
        },
        onPanEnd: (_) => setState(() => _points.add(null)),
        child: CustomPaint(
          painter: _DrawingPainter(_points),
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

  _DrawPoint({
    required this.position,
    required this.color,
    required this.strokeWidth,
  });
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
