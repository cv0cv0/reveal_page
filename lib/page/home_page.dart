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

class _HomePageState extends State<HomePage> {
  final dragStream = StreamController<Drag>();

  int currentIndex = 0;
  int nextIndex = 0;
  double percent = 0.0;

  @override
  void initState() {
    super.initState();
    dragStream.stream.listen((drag) {
      final newIndex = drag.direction == AxisDirection.left
          ? currentIndex + 1
          : currentIndex - 1;
      if (newIndex < 0 || newIndex >= factories.length) return;

      setState(() {
        percent = drag.percent;
        if (percent < 1)
          nextIndex = newIndex;
        else
          currentIndex = nextIndex;
      });
    });
  }

  @override
  Widget build(BuildContext context) => Material(
        child: Stack(
          children: <Widget>[
            Page(factory: factories[currentIndex], opacity: 1.0),
            Reveal(
              percent: percent,
              child: Page(factory: factories[nextIndex], opacity: percent),
            ),
            Indicator(
              currentIndex: currentIndex,
              nextIndex: nextIndex,
              percent: percent,
            ),
            Dragger(dragStream),
          ],
        ),
      );

  @override
  void dispose() {
    dragStream.close();
    super.dispose();
  }
}
