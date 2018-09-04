import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

import 'pages.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    Key key,
    this.currentIndex = 1,
    this.nextIndex,
    this.percent = 0.0,
  }) : super(key: key);

  final int currentIndex;
  final int nextIndex;
  final double percent;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: factories
              .asMap()
              .map((i, factory) => MapEntry(
                  i,
                  _Bubble(
                    iconPath: factory.indicatorIconPath,
                    iconColor: factory.color,
                    isHollow: i > currentIndex,
                    percent: i == currentIndex
                        ? 1 - percent
                        : i == nextIndex ? percent : 0.0,
                  )))
              .values
              .toList(),
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
  }) : super(key: key);

  final String iconPath;
  final Color iconColor;
  final bool isHollow;
  final double percent;

  @override
  Widget build(BuildContext context) => Container(
        width: lerpDouble(20.0, 45.0, percent),
        height: lerpDouble(20.0, 45.0, percent),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: isHollow ? null : Colors.white.withAlpha(0x88),
          shape: BoxShape.circle,
          border: isHollow
              ? Border.all(color: Colors.white.withAlpha(0x88), width: 3.0)
              : null,
        ),
        child: Opacity(
          opacity: percent,
          child: Image.asset(iconPath, color: iconColor),
        ),
      );
}
