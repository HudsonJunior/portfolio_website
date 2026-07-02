import 'package:flutter/material.dart';
import 'package:portfolio_website/features/core/presentation/widgets/reveal_on_scroll.dart';
import 'package:portfolio_website/features/experience/presentation/widgets/experience_timeline.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/theme.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surfaceAlt,
      width: double.infinity,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 48,
              vertical: 100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Section header ──────────────────────────────
                RevealOnScroll(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '// where i\'ve worked',
                        style: AppTextStyles.mono(
                          fontSize: 12.5,
                          color: AppColors.accentLight,
                          letterSpacing: 0.06 * 12.5,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Experience',
                        style: AppTextStyles.spaceGrotesk(
                          fontSize: 48,
                          fontWeight: FontWeight.w700,
                          letterSpacingEm: -0.025,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Six years shipping mobile products — from banking super-apps to one of the world\'s largest resort platforms.',
                        style: AppTextStyles.manrope(
                          fontSize: 16,
                          color: AppColors.text.withValues(alpha: 0.6),
                          height: 1.65,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 56),

                // ── Timeline (each card staggers in) ────────────
                const ExperienceTimeline(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
