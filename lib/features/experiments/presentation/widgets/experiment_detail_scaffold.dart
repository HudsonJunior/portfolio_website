import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_website/features/core/models/portfolio_section.dart';
import 'package:portfolio_website/features/core/presentation/widgets/portfolio_nav_bar.dart';
import 'package:portfolio_website/features/experiments/domain/experiment.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/theme.dart';

/// Shared chrome for standalone experiments.
///
/// Each experiment owns the interactive content passed as [child], while this
/// widget keeps navigation and metadata presentation consistent.
class ExperimentDetailScaffold extends StatelessWidget {
  final Experiment experiment;
  final Widget child;

  const ExperimentDetailScaffold({
    super.key,
    required this.experiment,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.sizeOf(context).width < 600;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 54, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton.icon(
                          onPressed: () => context.go('/?section=experiments'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.textMuted,
                            padding: EdgeInsets.zero,
                          ),
                          icon: const Icon(Icons.arrow_back_rounded, size: 17),
                          label: const Text('All experiments'),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          '// ${experiment.status.toLowerCase()}',
                          style: AppTextStyles.mono(
                            fontSize: 12,
                            color: AppColors.green,
                            letterSpacing: 0.06 * 12,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          experiment.title,
                          style: AppTextStyles.spaceGrotesk(
                            fontSize: isNarrow ? 38 : 48,
                            fontWeight: FontWeight.w700,
                            letterSpacingEm: -0.03,
                            height: 1.05,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 680),
                          child: Text(
                            experiment.summary,
                            style: AppTextStyles.manrope(
                              fontSize: 16,
                              color: AppColors.text.withValues(alpha: 0.6),
                              height: 1.65,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final tag in experiment.tags)
                              _ExperimentTag(label: tag),
                          ],
                        ),
                        const SizedBox(height: 42),
                        child,
                      ],
                    ),
                  ),
                ),
              ),
            ],
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

class _ExperimentTag extends StatelessWidget {
  final String label;

  const _ExperimentTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.borderMid),
      ),
      child: Text(
        label,
        style: AppTextStyles.mono(fontSize: 10.5, color: AppColors.textMuted),
      ),
    );
  }
}
