// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/extensions.dart';

class WorkButton extends StatelessWidget {
  const WorkButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.handleTap,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final VoidCallback handleTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: handleTap,
      style: ElevatedButton.styleFrom(
        primary: AppColors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.backgroundColor,
              size: 15,
            ),
            const SizedBox(width: 12.0),
            Text(
              label,
              style: context.themeData.headline2!.copyWith(
                color: AppColors.backgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
