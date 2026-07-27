import 'package:flutter/material.dart';
import 'package:portfolio_website/features/experiments/presentation/widgets/experiment_grid_background.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/theme.dart';

class MotionLabPreview extends StatelessWidget {
  const MotionLabPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return ExperimentGridBackground(
      spacing: 28,
      child: Stack(
        children: [
          const Positioned(top: 24, left: 24, child: FlutterLogo(size: 46)),
          Positioned(
            right: 30,
            bottom: 30,
            child: Transform.rotate(
              angle: -0.14,
              child: Container(
                width: 78,
                height: 78,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.accent, AppColors.accentBlue],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.35),
                      blurRadius: 28,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.motion_photos_on_rounded,
                  color: Colors.white,
                  size: 34,
                ),
              ),
            ),
          ),
          Positioned(
            left: 24,
            bottom: 28,
            child: Text(
              'CURVE  →  MOTION',
              style: AppTextStyles.mono(
                fontSize: 11,
                color: AppColors.text.withValues(alpha: 0.45),
                letterSpacing: 0.09 * 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
