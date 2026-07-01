import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_website/resources/colors.dart';

class WorkButton extends StatelessWidget {
  const WorkButton({
    Key? key,
    required this.icon,
    required this.handleTap,
  }) : super(key: key);

  final FaIconData icon;
  final VoidCallback handleTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: handleTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: FaIcon(
          icon,
          color: AppColors.backgroundColor,
          size: 15,
        ),
      ),
    );
  }
}
