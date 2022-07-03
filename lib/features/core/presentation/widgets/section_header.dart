import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/extensions.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    Key? key,
    required this.isVisible,
    required this.headerTitle,
  }) : super(key: key);

  final bool isVisible;
  final String headerTitle;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1500),
      opacity: isVisible ? 1.0 : 0.0,
      curve: Curves.easeIn,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            color: AppColors.black,
            thickness: 0.2,
          ),
          const SizedBox(height: 32.0),
          Expanded(
            child: AutoSizeText(
              headerTitle,
              style: context.themeData.headline6,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
