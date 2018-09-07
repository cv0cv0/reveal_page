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

  AxisDirection direction;
  int currentIndex = 0;
  int nextIndex = 0;
  double percent = 0.0;

  @override
  void initState() {
    super.initState();
    dragStream.stream.listen((drag) => setState(() {
          if (drag.status == Status.update) {
            direction = drag.direction;
            percent = drag.percent;
            nextIndex = drag.direction == AxisDirection.left
                ? currentIndex + 1
                : currentIndex - 1;

            if (nextIndex < 0) {
              nextIndex = 0;
              percent = 0.0;
            } else if (nextIndex >= factories.length) {
              nextIndex = factories.length - 1;
              percent = 0.0;
            }
          } else if (drag.status == Status.end) {
            currentIndex = nextIndex;
            percent = 0.0;
          } else {
            nextIndex = currentIndex;
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    final paddingBottom = MediaQuery.of(context).padding.bottom;
    return Material(
      child: Stack(
        children: <Widget>[
          Page(factory: factories[currentIndex], opacity: 1.0),
          Reveal(
            direction: direction,
            percent: percent,
            paddingBottom: paddingBottom,
            child: Page(factory: factories[nextIndex], opacity: percent),
          ),
          SafeArea(
            child: Indicator(
              currentIndex: currentIndex,
              nextIndex: nextIndex,
              direction: direction,
              percent: percent,
              paddingBottom: paddingBottom,
            ),
          ),
          Dragger(
            stream: dragStream,
            vsync: this,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    dragStream.close();
    super.dispose();
  }
}
