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
          style: context.themeData.headline3,
          textAlign: TextAlign.justify,
        ),
        Expanded(
          child: Text(
            widget.text,
            style: context.themeData.headline3!.copyWith(
              color: Colors.black.withOpacity(0.3),
              fontSize: 16.0,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
