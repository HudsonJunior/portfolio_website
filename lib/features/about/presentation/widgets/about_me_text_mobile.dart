import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_website/features/works/widgets/work_button.dart';
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
        Flexible(
          child: OverflowBox(
            child: AutoSizeText(
              widget.text,
              style: context.themeData.displaySmall!.copyWith(
                color: Colors.black.withOpacity(0.3),
                fontSize: 16.0,
              ),
              maxLines: 10,
              minFontSize: 10,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.justify,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 8,
                          child: AutoSizeText(
                            widget.text,
                            style: context.themeData.displaySmall!.copyWith(
                              color: Colors.black.withOpacity(0.3),
                              fontSize: 16.0,
                            ),
                            minFontSize: 12,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const Spacer(),
                        WorkButton(
                          icon: Icons.check,
                          handleTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Text(
            'click to read...',
            style: context.themeData.displayMedium!.copyWith(fontSize: 10),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
