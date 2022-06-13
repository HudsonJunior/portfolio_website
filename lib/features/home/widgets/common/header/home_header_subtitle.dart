import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_website/resources/extensions.dart';

class HomeHeaderSubtitle extends StatelessWidget {
  const HomeHeaderSubtitle({Key? key, this.kIsMobile = false})
      : super(key: key);

  final bool kIsMobile;

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      totalRepeatCount: 1,
      animatedTexts: [
        TypewriterAnimatedText(
          "hi! I'm Hudson Júnior. Flutter developer passionate about solving problems and creating mobile apps.",
          textStyle: context.themeData.bodyText1,
          textAlign: kIsMobile ? TextAlign.center : TextAlign.start,
          speed: const Duration(
            milliseconds: 50,
          ),
        )
      ],
    );
  }
}
