import 'dart:math';

import 'package:flutter/material.dart';

class Reveal extends StatelessWidget {
  const Reveal({this.percent, this.child});

  final double percent;
  final Widget child;

  @override
  Widget build(BuildContext context) => ClipOval(
        clipper: _RevealClipper(percent),
        child: child,
      );
}

class _RevealClipper extends CustomClipper<Rect> {
  const _RevealClipper(this.percent);

  final double percent;

  @override
  Rect getClip(Size size) {
    final center = Offset(size.width / 2, size.height * 0.9);
    final radius = (center.dy / sin(atan(center.dy / center.dx))) * percent;

    return Rect.fromCircle(center: center, radius: radius);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
