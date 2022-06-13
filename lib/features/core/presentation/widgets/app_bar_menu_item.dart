import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/features/core/presentation/widgets/hover_scale_effect.dart';
import 'package:portfolio_website/resources/colors.dart';

class AppBarMenuItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback handleTap;

  const AppBarMenuItem({
    Key? key,
    required this.title,
    required this.handleTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: AppColors.backgroundColor,
      splashColor: AppColors.backgroundColor,
      focusColor: AppColors.backgroundColor,
      highlightColor: AppColors.backgroundColor,
      onTap: handleTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: HoverScaleEffect(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.openSans(
                    color: AppColors.black,
                    letterSpacing: 2.0,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4.0),
                AnimatedScale(
                  duration: const Duration(milliseconds: 400),
                  scale: isSelected ? 1.2 : 0.0,
                  child: Icon(
                    Icons.circle,
                    color: AppColors.black,
                    size: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
