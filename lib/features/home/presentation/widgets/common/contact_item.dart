import 'package:flutter/material.dart';
import 'package:portfolio_website/features/core/presentation/widgets/hover_scale_effect.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/extensions.dart';

class ContactItem extends StatelessWidget {
  final IconData icon;
  final String itemName;
  final VoidCallback handleTap;

  const ContactItem({
    Key? key,
    required this.icon,
    required this.itemName,
    required this.handleTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(12.0),
      ),
      textStyle: context.themeData.bodyText2,
      message: itemName,
      child: HoverScaleEffect(
        child: InkWell(
          onTap: handleTap,
          child: Card(
            color: AppColors.backgroundColor,
            child: Icon(
              icon,
              color: AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
