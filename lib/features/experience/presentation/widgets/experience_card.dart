import 'package:flutter/material.dart';
import 'package:portfolio_website/features/experience/domain/experience_model.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/theme.dart';

class ExperienceCard extends StatefulWidget {
  final ExperienceModel job;

  const ExperienceCard({super.key, required this.job});

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(_hovered ? 6 : 0, 0, 0),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(
            color: _hovered
                ? AppColors.accent.withValues(alpha: 0.4)
                : AppColors.border,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 40,
                    offset: const Offset(0, 16),
                  ),
                ]
              : [],
        ),
        padding: const EdgeInsets.all(26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Role + period row ────────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Expanded(
                  child: Text(
                    widget.job.role,
                    style: AppTextStyles.spaceGrotesk(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.text,
                      letterSpacingEm: -0.02,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  widget.job.period,
                  style: AppTextStyles.mono(
                    fontSize: 12,
                    color: AppColors.textDim,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // ── Company + current badge ──────────────────────────
            Row(
              children: [
                Text(
                  widget.job.company,
                  style: AppTextStyles.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accentLight,
                  ),
                ),
                if (widget.job.isCurrent) ...[
                  const SizedBox(width: 10),
                  const _CurrentBadge(),
                ],
              ],
            ),
            const SizedBox(height: 16),

            // ── Bullet points ────────────────────────────────────
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.job.points
                  .map((pt) => Padding(
                        padding: const EdgeInsets.only(bottom: 9),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: Icon(
                                Icons.arrow_forward,
                                size: 14,
                                color: AppColors.accent,
                              ),
                            ),
                            const SizedBox(width: 11),
                            Expanded(
                              child: Text(
                                pt,
                                style: AppTextStyles.manrope(
                                  fontSize: 14,
                                  color: AppColors.text.withValues(alpha: 0.66),
                                  height: 1.55,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 4),

            // ── Tech stack tags ──────────────────────────────────
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.job.stack
                  .map((tech) => _StackTag(label: tech))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _CurrentBadge extends StatelessWidget {
  const _CurrentBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.green.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        'current',
        style: AppTextStyles.mono(
          fontSize: 10.5,
          color: AppColors.green,
          letterSpacing: 0.06 * 10.5,
        ),
      ),
    );
  }
}

class _StackTag extends StatelessWidget {
  final String label;

  const _StackTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF7C82F2).withValues(alpha: 0.10),
        border: Border.all(
          color: const Color(0xFF7C82F2).withValues(alpha: 0.26),
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: AppTextStyles.mono(
          fontSize: 11.5,
          color: AppColors.text.withValues(alpha: 0.8),
        ),
      ),
    );
  }
}
