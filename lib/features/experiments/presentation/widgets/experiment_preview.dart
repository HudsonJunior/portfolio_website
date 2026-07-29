import 'package:flutter/material.dart';
import 'package:portfolio_website/features/experiments/domain/experiment.dart';
import 'package:portfolio_website/features/experiments/presentation/motion_lab/motion_lab_preview.dart';
import 'package:portfolio_website/features/experiments/presentation/widgets/experiment_grid_background.dart';
import 'package:portfolio_website/resources/colors.dart';

class ExperimentPreview extends StatelessWidget {
  final ExperimentKind kind;

  const ExperimentPreview({super.key, required this.kind});

  @override
  Widget build(BuildContext context) {
    switch (kind) {
      case ExperimentKind.motionLab:
        return const MotionLabPreview();
      case ExperimentKind.flutterScene:
        return const _FlutterScenePreview();
    }
  }
}

class _FlutterScenePreview extends StatelessWidget {
  const _FlutterScenePreview();

  @override
  Widget build(BuildContext context) {
    return ExperimentGridBackground(
      child: Center(
        child: Container(
          width: 112,
          height: 112,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.accent.withValues(alpha: 0.12),
            border: Border.all(
              color: AppColors.accentLight.withValues(alpha: 0.45),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.22),
                blurRadius: 34,
              ),
            ],
          ),
          child: const Icon(
            Icons.view_in_ar_rounded,
            size: 54,
            color: AppColors.accentLight,
          ),
        ),
      ),
    );
  }
}
