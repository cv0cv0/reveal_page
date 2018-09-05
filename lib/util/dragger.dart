import 'dart:async';

import 'package:flutter/material.dart';

const dragPx = 300.0;

class Dragger extends StatefulWidget {
  const Dragger(this.dragStream);

  final StreamController<Drag> dragStream;

  @override
  _DraggerState createState() => _DraggerState();
}

class _DraggerState extends State<Dragger> {
  Offset startOffset;
  double percent;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onHorizontalDragStart: onDragStart,
        onHorizontalDragUpdate: onDragUpdate,
        onHorizontalDragEnd: onDragEnd,
      );

  void onDragStart(DragStartDetails details) {
    startOffset = details.globalPosition;
  }

  void onDragUpdate(DragUpdateDetails details) {
    final dx = details.globalPosition.dx - startOffset.dx;
    percent = (dx / dragPx).abs().clamp(0.0, 1.0);

    widget.dragStream.add(Drag(
      direction: dx > 0 ? AxisDirection.right : AxisDirection.left,
      percent: percent,
    ));
  }

  void onDragEnd(DragEndDetails details) {}
}

class Drag {
  const Drag({
    this.direction,
    this.percent,
  });

  final AxisDirection direction;
  final double percent;
}
