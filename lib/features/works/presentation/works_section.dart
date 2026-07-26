import 'package:flutter/material.dart';
import 'package:portfolio_website/features/core/presentation/widgets/reveal_on_scroll.dart';
import 'package:portfolio_website/features/works/models/works_model.dart';
import 'package:portfolio_website/features/works/presentation/widgets/work_project_card.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/constraints.dart';
import 'package:portfolio_website/resources/theme.dart';

class WorksSection extends StatelessWidget {
  const WorksSection({super.key});

  static const _projects = WorksEnum.values;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surfaceAlt,
      width: double.infinity,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RevealOnScroll(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '// selected work',
                        style: AppTextStyles.mono(
                          fontSize: 12.5,
                          color: AppColors.accentLight,
                          letterSpacing: 0.06 * 12.5,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Works',
                        style: AppTextStyles.spaceGrotesk(
                          fontSize: 48,
                          fontWeight: FontWeight.w700,
                          letterSpacingEm: -0.025,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Apps and experiments I\'ve shipped — from healthcare '
                        'routing to games, storefronts, and this site.',
                        style: AppTextStyles.manrope(
                          fontSize: 16,
                          color: AppColors.text.withValues(alpha: 0.6),
                          height: 1.65,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile =
                        AppConstraints.isMobile(constraints.maxWidth + 96);

                    if (isMobile) {
                      return Column(
                        children: [
                          for (var i = 0; i < _projects.length; i++) ...[
                            if (i > 0) const SizedBox(height: 24),
                            RevealOnScroll(
                              child: WorkProjectCard(work: _projects[i]),
                            ),
                          ],
                        ],
                      );
                    }

                    return Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      children: [
                        for (final project in _projects)
                          SizedBox(
                            width: (constraints.maxWidth - 24) / 2,
                            child: RevealOnScroll(
                              child: WorkProjectCard(work: project),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
