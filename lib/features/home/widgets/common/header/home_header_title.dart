import 'package:flutter/material.dart';
import 'package:portfolio_website/resources/extensions.dart';

class HomeHeaderTitle extends StatelessWidget {
  const HomeHeaderTitle({Key? key, this.kIsMobile = false}) : super(key: key);

  final bool kIsMobile;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.bounceOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: Align(
        alignment: kIsMobile ? Alignment.center : Alignment.centerLeft,
        child: Text(
          "flutter & mobile developer",
          style: context.themeData.headline6,
          textAlign: kIsMobile ? TextAlign.center : TextAlign.start,
        ),
      ),
    );
  }
}
