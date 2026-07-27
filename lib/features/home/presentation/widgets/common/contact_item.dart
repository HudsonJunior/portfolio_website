import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_website/features/core/presentation/widgets/hover_scale_effect.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/extensions.dart';

class ContactItem extends StatelessWidget {
  final FaIconData icon;
  final String itemName;
  final VoidCallback handleTap;

  const ContactItem({
    super.key,
    required this.icon,
    required this.itemName,
    required this.handleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(12.0),
      ),
      textStyle: context.themeData.bodyMedium,
      message: itemName,
      child: HoverScaleEffect(
        child: InkWell(
          onTap: handleTap,
          child: Card(
            color: AppColors.backgroundColor,
            child: FaIcon(
              icon,
              color: AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
