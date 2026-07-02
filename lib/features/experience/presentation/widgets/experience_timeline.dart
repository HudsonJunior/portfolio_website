import 'package:flutter/material.dart';
import 'package:portfolio_website/features/core/presentation/widgets/reveal_on_scroll.dart';
import 'package:portfolio_website/features/experience/domain/experience_model.dart';
import 'package:portfolio_website/features/experience/presentation/widgets/experience_card.dart';
import 'package:portfolio_website/resources/colors.dart';

class ExperienceTimeline extends StatelessWidget {
  const ExperienceTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(kExperiences.length, (i) {
        return _TimelineItem(
          job: kExperiences[i],
          isLast: i == kExperiences.length - 1,
          index: i,
        );
      }),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final ExperienceModel job;
  final bool isLast;
  final int index;

  const _TimelineItem({
    required this.job,
    required this.isLast,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return RevealOnScroll(
      delay: Duration(milliseconds: 80 * index),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Timeline spine (dot + line) ──────────────────────
            SizedBox(
              width: 40,
              child: Column(
                children: [
                  const SizedBox(height: 4),
                  // Dot
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.surfaceAlt,
                      border: Border.all(
                        color: AppColors.accent,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withValues(alpha: 0.12),
                          blurRadius: 0,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                  ),
                  // Connecting line (hidden on last item)
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.accent,
                              AppColors.accentBlue,
                              Color(0x1F6366F1),
                            ],
                            stops: [0.0, 0.4, 1.0],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(width: 20),

            // ── Card ─────────────────────────────────────────────
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 38),
                child: ExperienceCard(job: job),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
