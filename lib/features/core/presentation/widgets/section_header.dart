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
    return AnimatedSlide(
      duration: const Duration(milliseconds: 1000),
      offset: isVisible ? const Offset(0.0, 0) : const Offset(-1, 0.0),
      curve: Curves.easeOutBack,
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
          AutoSizeText(
            headerTitle,
            style: context.themeData.titleLarge,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
