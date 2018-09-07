import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

import 'pages.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    Key key,
    this.currentIndex,
    this.nextIndex,
    this.direction,
    this.percent,
    this.paddingBottom,
  }) : super(key: key);

  final int currentIndex;
  final int nextIndex;
  final AxisDirection direction;
  final double percent;
  final double paddingBottom;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.bottomCenter,
        child: Transform(
          transform: Matrix4.translationValues(
              factories.length * 40 / 2 -
                  20 -
                  currentIndex * 40 +
                  (direction == AxisDirection.left ? -40 : 40) * percent,
              0.0,
              0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: factories
                .asMap()
                .map((i, factory) => MapEntry(
                    i,
                    _Bubble(
                      iconPath: factory.indicatorIconPath,
                      iconColor: factory.color,
                      isHollow: i > nextIndex,
                      percent: i == currentIndex
                          ? 1 - percent
                          : i == nextIndex ? percent : 0.0,
                      paddingBottom: paddingBottom,
                    )))
                .values
                .toList(),
          ),
        ),
      );
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    Key key,
    this.iconPath,
    this.iconColor,
    this.isHollow,
    this.percent,
    this.paddingBottom,
  }) : super(key: key);

  final String iconPath;
  final Color iconColor;
  final bool isHollow;
  final double percent;
  final double paddingBottom;

  @override
  Widget build(BuildContext context) => Container(
        width: lerpDouble(20.0, 45.0, percent),
        height: lerpDouble(20.0, 45.0, percent),
        margin: EdgeInsets.symmetric(
            horizontal: 10.0, vertical: paddingBottom == 0 ? 10.0 : 0.0),
        decoration: BoxDecoration(
          color: isHollow
              ? Colors.white.withAlpha((0x88 * percent).round())
              : Colors.white.withAlpha(0x88),
          shape: BoxShape.circle,
          border: isHollow
              ? Border.all(
                  color: Colors.white.withAlpha((0x88 * (1 - percent)).round()),
                  width: 3.0)
              : null,
        ),
        child: Opacity(
          opacity: percent,
          child: Image.asset(iconPath, color: iconColor),
        ),
      );
}
