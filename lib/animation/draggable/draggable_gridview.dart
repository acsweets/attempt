import 'package:flutter/material.dart';

class FlowingDraggableGrid extends StatefulWidget {
  const FlowingDraggableGrid({Key? key}) : super(key: key);

  @override
  _FlowingDraggableGridState createState() => _FlowingDraggableGridState();
}

class _FlowingDraggableGridState extends State<FlowingDraggableGrid> {
  List<String> items = List.generate(16, (index) => 'Item ${index + 1}');
  int? draggedIndex;
  Offset? dragOffset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('流动拖拽网格')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = constraints.maxWidth / 4;
          final itemHeight = itemWidth;

          return Stack(
            children: [
              ...items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final row = index ~/ 4;
                final col = index % 4;

                return AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  left: col * itemWidth,
                  top: row * itemHeight,
                  width: itemWidth,
                  height: itemHeight,
                  child: Draggable<int>(
                    data: index,
                    feedback: Material(
                      elevation: 4,
                      child: Container(
                        width: itemWidth,
                        height: itemHeight,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(item, style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    childWhenDragging: SizedBox(),
                    onDragStarted: () => setState(() => draggedIndex = index),
                    onDragEnd: (_) => setState(() {
                      draggedIndex = null;
                      dragOffset = null;
                    }),
                    onDragUpdate: (details) => setState(() => dragOffset = details.localPosition),
                    child: GridItem(item: item),
                  ),
                );
              }).toList(),
              if (draggedIndex != null && dragOffset != null)
                Positioned.fill(
                  child: IgnorePointer(
                    child: CustomPaint(
                      painter: FlowPainter(
                        itemCount: items.length,
                        draggedIndex: draggedIndex!,
                        dragOffset: dragOffset!,
                        itemSize: Size(itemWidth, itemHeight),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String item;

  const GridItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(item, style: TextStyle(color: Colors.white)),
    );
  }
}

class FlowPainter extends CustomPainter {
  final int itemCount;
  final int draggedIndex;
  final Offset dragOffset;
  final Size itemSize;

  FlowPainter({
    required this.itemCount,
    required this.draggedIndex,
    required this.dragOffset,
    required this.itemSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < itemCount; i++) {
      if (i == draggedIndex) continue;

      final row = i ~/ 4;
      final col = i % 4;
      final itemRect = Rect.fromLTWH(
        col * itemSize.width,
        row * itemSize.height,
        itemSize.width,
        itemSize.height,
      );

      final distance = (itemRect.center - dragOffset).distance;
      final maxDistance = itemSize.width * 1.5;

      if (distance < maxDistance) {
        final ratio = 1 - (distance / maxDistance);
        final offset = Offset(
          (dragOffset.dx - itemRect.center.dx) * ratio * 0.3,
          (dragOffset.dy - itemRect.center.dy) * ratio * 0.3,
        );

        canvas.drawRRect(
          RRect.fromRectAndRadius(itemRect.shift(offset), Radius.circular(8)),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}



class DragGrid extends StatefulWidget {
  @override
  _DragGridState createState() => _DragGridState();
}

class _DragGridState extends State<DragGrid> {
  List<Offset?> positions = List.generate(9, (index) => Offset((index % 3) * 100.0, (index ~/ 3) * 100.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flow Layout with Drag')),
      body: Stack(
        children: List.generate(9, (index) {
          return Positioned(
            left: positions[index]!.dx,
            top: positions[index]!.dy,
            child: Draggable<int>(
              data: index,
              feedback: Material(
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                  child: Center(child: Text('$index', style: TextStyle(color: Colors.white, fontSize: 24))),
                ),
              ),
              childWhenDragging: Container(),
              onDragEnd: (details) {
                setState(() {
                  positions[index] = details.offset;
                  // Handle other items here to avoid overlap
                });
              },
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: Center(child: Text('$index', style: TextStyle(color: Colors.white, fontSize: 24))),
              ),
            ),
          );
        }),
      ),
    );
  }
}
