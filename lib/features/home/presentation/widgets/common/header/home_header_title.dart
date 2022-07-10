import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_website/resources/extensions.dart';

class HomeHeaderTitle extends StatelessWidget {
  final bool kIsMobile;

  const HomeHeaderTitle({
    Key? key,
    required this.kIsMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: kIsMobile ? Alignment.center : Alignment.centerLeft,
          child: FittedBox(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1200),
              curve: Curves.bounceOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: AutoSizeText(
                "flutter & mobile developer",
                maxLines: 1,
                minFontSize: 10,
                style: context.themeData.headline6,
                textAlign: kIsMobile ? TextAlign.center : TextAlign.start,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        AnimatedTextKit(
          totalRepeatCount: 1,
          animatedTexts: [
            TypewriterAnimatedText(
              "hi! I'm Hudson Júnior. Flutter developer passionate about solving problems and creating mobile apps.",
              textStyle: context.themeData.bodyText1,
              textAlign: kIsMobile ? TextAlign.center : TextAlign.start,
              speed: const Duration(
                milliseconds: 40,
              ),
            )
          ],
        ),
      ],
    );
  }
}
