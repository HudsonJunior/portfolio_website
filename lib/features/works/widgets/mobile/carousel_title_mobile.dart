import 'package:flutter/material.dart';
import 'package:portfolio_website/resources/extensions.dart';

class CarouselTitleMobile extends StatelessWidget {
  const CarouselTitleMobile({
    Key? key,
    required this.title,
    required this.iconPath,
  }) : super(key: key);

  final String title;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            iconPath,
            height: 35,
            width: 35,
          ),
        ),
        const SizedBox(height: 12.0),
        Flexible(
          child: FittedBox(
            child: Text(
              title,
              style: context.themeData.headline5,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
