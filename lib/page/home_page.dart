import 'dart:async';

import 'package:flutter/material.dart';

import '../widget/pages.dart';
import '../util/reveal.dart';
import '../widget/indicator.dart';
import '../util/dragger.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final dragStream = StreamController<Drag>();

  int currentIndex = 0;
  int nextIndex = 0;
  double percent = 0.0;
  AxisDirection direction;

  @override
  void initState() {
    super.initState();
    dragStream.stream.listen((drag) {
      final newIndex = drag.direction == AxisDirection.left
          ? currentIndex + 1
          : currentIndex - 1;
      if (newIndex < 0 || newIndex >= factories.length) return;

      setState(() {
        if (drag.status == Status.update) {
          direction = drag.direction;
          nextIndex = newIndex;
          percent = drag.percent;
        } else if (drag.status == Status.end) {
          currentIndex = nextIndex;
          percent = 0.0;
        } else {
          nextIndex = currentIndex;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) => Material(
        child: Stack(
          children: <Widget>[
            Page(factory: factories[currentIndex], opacity: 1.0),
            Reveal(
              direction: direction,
              percent: percent,
              child: Page(factory: factories[nextIndex], opacity: percent),
            ),
            Indicator(
              currentIndex: currentIndex,
              nextIndex: nextIndex,
              direction: direction,
              percent: percent,
            ),
            Dragger(
              stream: dragStream,
              vsync: this,
            ),
          ],
        ),
      );

  @override
  void dispose() {
    dragStream.close();
    super.dispose();
  }
}
