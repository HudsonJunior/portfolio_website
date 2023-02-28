import 'package:flutter/material.dart';
import 'package:portfolio_website/resources/extensions.dart';

class AboutMeTextMobile extends StatefulWidget {
  final String title;
  final String text;

  const AboutMeTextMobile({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  State<AboutMeTextMobile> createState() => _AboutMeTextMobileState();
}

class _AboutMeTextMobileState extends State<AboutMeTextMobile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: context.themeData.displaySmall,
          textAlign: TextAlign.justify,
        ),
        Expanded(
          child: Text(
            widget.text,
            style: context.themeData.displaySmall!.copyWith(
              color: Colors.black.withOpacity(0.5),
              fontSize: 16.0,
            ),
            maxLines: 30,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
