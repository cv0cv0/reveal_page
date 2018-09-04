import 'package:flutter/material.dart';

import '../widget/pages.dart';
import '../util/reveal.dart';
import '../widget/indicator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Material(
        child: Stack(
          children: <Widget>[
            Page(factory: factories[0], opacity: 1.0),
            Reveal(
              percent: 1.0,
              child: Page(factory: factories[1], opacity: 1.0),
            ),
            Indicator(),
          ],
        ),
      );
}
