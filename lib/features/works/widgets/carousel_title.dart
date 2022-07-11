import 'package:flutter/material.dart';
import 'package:portfolio_website/resources/extensions.dart';

class CarouselTitle extends StatelessWidget {
  const CarouselTitle({
    Key? key,
    required this.title,
    required this.iconPath,
  }) : super(key: key);

  final String title;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: ClipOval(
            child: Image.asset(
              iconPath,
              height: 35,
              width: 35,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Flexible(
          child: Text(
            title,
            style: context.themeData.headline5,
          ),
        ),
      ],
    );
  }
}
