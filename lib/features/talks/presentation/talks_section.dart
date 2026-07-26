import 'package:flutter/material.dart';
import 'package:portfolio_website/features/core/presentation/widgets/reveal_on_scroll.dart';
import 'package:portfolio_website/features/talks/domain/talk_model.dart';
import 'package:portfolio_website/features/talks/presentation/widgets/talk_card.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/constraints.dart';
import 'package:portfolio_website/resources/theme.dart';

class TalksSection extends StatelessWidget {
  const TalksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
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
                        '// on stage',
                        style: AppTextStyles.mono(
                          fontSize: 12.5,
                          color: AppColors.accentLight,
                          letterSpacing: 0.06 * 12.5,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Talks',
                        style: AppTextStyles.spaceGrotesk(
                          fontSize: 48,
                          fontWeight: FontWeight.w700,
                          letterSpacingEm: -0.025,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Sharing what I learn on stage — Flutter craft, agentic '
                        'engineering, and shipping quality under real constraints.',
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
                    if (isMobile || kTalks.length == 1) {
                      return Column(
                        children: [
                          for (var i = 0; i < kTalks.length; i++) ...[
                            if (i > 0) const SizedBox(height: 24),
                            RevealOnScroll(
                              child: TalkCard(talk: kTalks[i]),
                            ),
                          ],
                        ],
                      );
                    }

                    return Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      children: [
                        for (final talk in kTalks)
                          SizedBox(
                            width: (constraints.maxWidth - 24) / 2,
                            child: RevealOnScroll(
                              child: TalkCard(talk: talk),
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
