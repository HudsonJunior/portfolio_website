import 'package:flutter/material.dart';
import 'package:portfolio_website/features/experiments/domain/experiment.dart';
import 'package:portfolio_website/features/experiments/presentation/motion_lab/motion_lab_preview.dart';

class ExperimentPreview extends StatelessWidget {
  final ExperimentKind kind;

  const ExperimentPreview({super.key, required this.kind});

  @override
  Widget build(BuildContext context) {
    switch (kind) {
      case ExperimentKind.motionLab:
        return const MotionLabPreview();
    }
  }
}
