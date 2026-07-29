import 'package:flutter/material.dart';
import 'package:portfolio_website/features/experiments/domain/experiment.dart';
import 'package:portfolio_website/features/experiments/presentation/flutter_scene/dash_scene_view.dart';
import 'package:portfolio_website/features/experiments/presentation/widgets/experiment_detail_scaffold.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/theme.dart';

class FlutterSceneExperimentPage extends StatelessWidget {
  const FlutterSceneExperimentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ExperimentDetailScaffold(
      experiment: kFlutterSceneExperiment,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 640;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: isNarrow ? 400 : 540,
                decoration: BoxDecoration(
                  color: const Color(0xFF171B22),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.borderMid),
                ),
                clipBehavior: Clip.antiAlias,
                child: const DashSceneView(),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _StatusPill(
                    icon: Icons.play_arrow_rounded,
                    label: 'Animation: Run',
                  ),
                  Text(
                    'Preprocessed GLB · looping automatically',
                    style: AppTextStyles.manrope(
                      fontSize: 13,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final IconData icon;
  final String label;

  const _StatusPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.borderMid),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.green),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTextStyles.mono(fontSize: 11, color: AppColors.text),
          ),
        ],
      ),
    );
  }
}
