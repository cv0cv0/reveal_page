import 'package:flutter/material.dart';

import 'page/home_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Reveal Page',
    home: HomePage(),
  );
}
