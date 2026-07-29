import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_website/features/core/models/portfolio_section.dart';
import 'package:portfolio_website/features/core/presentation/widgets/portfolio_nav_bar.dart';
import 'package:portfolio_website/features/experiments/domain/experiment.dart';
import 'package:portfolio_website/features/experiments/presentation/flutter_scene/flutter_scene_experiment_page.dart';
import 'package:portfolio_website/features/experiments/presentation/motion_lab/motion_lab_page.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/theme.dart';

/// Resolves experiment slugs to isolated experiment pages.
///
/// Add each new experiment here with its own page widget. This keeps experiment
/// state and presentation independent from the landing-page carousel.
class ExperimentRoutePage extends StatelessWidget {
  final String slug;

  const ExperimentRoutePage({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    final experiment = experimentBySlug(slug);
    if (experiment == null) return const _ExperimentNotFoundPage();

    switch (experiment.kind) {
      case ExperimentKind.motionLab:
        return const MotionLabPage();
      case ExperimentKind.flutterScene:
        return const FlutterSceneExperimentPage();
    }
  }
}

class _ExperimentNotFoundPage extends StatelessWidget {
  const _ExperimentNotFoundPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Experiment not found',
                  style: AppTextStyles.spaceGrotesk(fontSize: 28),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => context.go('/?section=experiments'),
                  child: const Text('Back to Experiments'),
                ),
              ],
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PortfolioNavBar(
              selectedSection: PortfolioSection.experiments,
            ),
          ),
        ],
      ),
    );
  }
}
