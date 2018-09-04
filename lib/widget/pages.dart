import 'package:flutter/material.dart';

const factories = [
  PageFactory(
    title: 'Hotels',
    body: 'This is the body',
    color: Color(0xFF678FB4),
    heroIconPath: 'asset/hotels.png',
    indicatorIconPath: 'asset/key.png',
  ),
  PageFactory(
    title: 'Banks',
    body: 'We carefully verify all banks before adding them into the app',
    color: Color(0xFF65B0B4),
    heroIconPath: 'asset/banks.png',
    indicatorIconPath: 'asset/wallet.png',
  ),
  PageFactory(
    title: 'Store',
    body: 'All local stores are categorized for your convenience',
    color: Color(0xFF9B90BC),
    heroIconPath: 'asset/stores.png',
    indicatorIconPath: 'asset/shopping_cart.png',
  ),
];

class Page extends StatelessWidget {
  const Page({
    Key key,
    this.factory,
    this.opacity,
  }) : super(key: key);

  final PageFactory factory;
  final double opacity;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        color: factory.color,
        child: Opacity(
          opacity: opacity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Transform(
                transform:
                    Matrix4.translationValues(0.0, (1.0 - opacity) * 50.0, 0.0),
                child: Image.asset(factory.heroIconPath, width: 200.0, height: 200.0),
              ),
              SizedBox(height: 35.0),
              Transform(
                transform:
                    Matrix4.translationValues(0.0, (1.0 - opacity) * 30.0, 0.0),
                child: Text(
                  factory.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'FlamanteRoma',
                      fontSize: 34.0),
                ),
              ),
              SizedBox(height: 10.0),
              Transform(
                transform:
                    Matrix4.translationValues(0.0, (1.0 - opacity) * 30.0, 0.0),
                child: Text(
                  factory.body,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
              SizedBox(height: 75.0),
            ],
          ),
        ),
      );
}

class PageFactory {
  const PageFactory({
    this.title,
    this.body,
    this.color,
    this.heroIconPath,
    this.indicatorIconPath,
  });

  final String title;
  final String body;
  final Color color;
  final String heroIconPath;
  final String indicatorIconPath;
}
