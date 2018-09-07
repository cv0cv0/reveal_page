import 'dart:math';

import 'package:flutter/material.dart';

class Reveal extends StatelessWidget {
  const Reveal({this.direction, this.percent, this.paddingBottom, this.child});

  final AxisDirection direction;
  final double percent;
  final double paddingBottom;
  final Widget child;

  @override
  Widget build(BuildContext context) => ClipOval(
        clipper: _RevealClipper(
          direction: direction,
          percent: percent,
          paddingBottom: paddingBottom,
        ),
        child: child,
      );
}

class _RevealClipper extends CustomClipper<Rect> {
  const _RevealClipper({this.direction, this.percent, this.paddingBottom});

  final AxisDirection direction;
  final double percent;
  final double paddingBottom;

  @override
  Rect getClip(Size size) {
    final center = Offset(
        size.width / 2 +
            (direction == AxisDirection.left ? 52.5 : -52.5) * (1 - percent),
        size.height - (paddingBottom == 0 ? 10.0 : paddingBottom) - 22.5);
    final radius = (center.dy / sin(atan(center.dy / center.dx))) * percent;

    return Rect.fromCircle(center: center, radius: radius);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
