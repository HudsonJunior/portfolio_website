import 'package:flutter/material.dart';
import 'package:portfolio_website/resources/extensions.dart';

class AboutMeText extends StatefulWidget {
  final String title;
  final String text;

  const AboutMeText({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  State<AboutMeText> createState() => _AboutMeTextState();
}

class _AboutMeTextState extends State<AboutMeText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: context.themeData.displaySmall!.copyWith(
            fontWeight: FontWeight.w900,
          ),
          textAlign: TextAlign.justify,
        ),
        Flexible(
          child: Text(
            widget.text,
            style: context.themeData.displaySmall!.copyWith(
              color: Colors.grey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
