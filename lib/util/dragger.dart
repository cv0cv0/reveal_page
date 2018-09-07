import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

const dragPx = 300.0;
const animationMilliseconds = 500;

class Dragger extends StatefulWidget {
  const Dragger({this.stream, this.vsync});

  final StreamController<Drag> stream;
  final TickerProvider vsync;

  @override
  _DraggerState createState() => _DraggerState();
}

class _DraggerState extends State<Dragger> {
  Offset startOffset;
  AxisDirection direction;
  double percent = 0.0;

  AnimationController controller;
  bool animating = false;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onHorizontalDragStart: onDragStart,
        onHorizontalDragUpdate: onDragUpdate,
        onHorizontalDragEnd: onDragEnd,
      );

  void onDragStart(DragStartDetails details) {
    percent = 0.0;
    if (!animating) startOffset = details.globalPosition;
  }

  void onDragUpdate(DragUpdateDetails details) {
    if (startOffset == null) return;

    final dx = details.globalPosition.dx - startOffset.dx;
    if (dx == 0) return;

    direction = dx > 0 ? AxisDirection.right : AxisDirection.left;
    percent = (dx / dragPx).abs().clamp(0.0, 1.0);

    widget.stream.add(Drag(
      status: Status.update,
      direction: direction,
      percent: percent,
    ));
  }

  void onDragEnd(DragEndDetails details) {
    startOffset = null;

    if (percent == 0) {
      widget.stream.add(Drag(
        status: Status.cancel,
        direction: direction,
        percent: percent,
      ));
    } else if (percent == 1) {
      widget.stream.add(Drag(
        status: Status.end,
        direction: direction,
        percent: percent,
      ));
    } else {
      final isCancel = percent < 0.3;
      controller = AnimationController(
        value: percent,
        duration: Duration(
            milliseconds:
                ((isCancel ? percent : 1 - percent) * animationMilliseconds)
                    .round()),
        vsync: widget.vsync,
      )
        ..addListener(() {
          widget.stream.add(Drag(
            status: Status.update,
            direction: direction,
            percent:
                lerpDouble(percent, isCancel ? 0.0 : 1.0, controller.value),
          ));
        })
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            widget.stream.add(Drag(
              status: isCancel ? Status.cancel : Status.end,
              direction: direction,
              percent:
                  lerpDouble(percent, isCancel ? 0.0 : 1.0, controller.value),
            ));
            controller.dispose();
            animating = false;
          }
        });

      controller.forward();
      animating = true;
    }
  }
}

class Drag {
  const Drag({
    this.status,
    this.direction,
    this.percent,
  });

  final Status status;
  final AxisDirection direction;
  final double percent;
}

enum Status {
  update,
  end,
  cancel,
}
