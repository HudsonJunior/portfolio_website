import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_website/features/core/presentation/widgets/reveal_on_scroll.dart';
import 'package:portfolio_website/features/experiments/domain/experiment.dart';
import 'package:portfolio_website/features/experiments/presentation/widgets/experiment_preview.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/theme.dart';

/// Landing-page sandbox for small, interactive Flutter explorations.
class ExperimentsSection extends StatelessWidget {
  const ExperimentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isNarrow = width < 850;
    final horizontalPad = isNarrow ? 24.0 : 48.0;

    return Container(
      color: AppColors.background,
      width: double.infinity,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ExperimentsHeader(horizontalPadding: horizontalPad),
                const SizedBox(height: 48),
                _ExperimentsCarousel(
                  isNarrow: isNarrow,
                  horizontalPadding: horizontalPad,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ExperimentsHeader extends StatelessWidget {
  final double horizontalPadding;

  const _ExperimentsHeader({required this.horizontalPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: RevealOnScroll(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '// sandbox',
              style: AppTextStyles.mono(
                fontSize: 12.5,
                color: AppColors.accentLight,
                letterSpacing: 0.06 * 12.5,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Experiments',
              style: AppTextStyles.spaceGrotesk(
                fontSize: 48,
                fontWeight: FontWeight.w700,
                letterSpacingEm: -0.025,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'A sandbox for playful Flutter ideas, interaction studies, and '
              'tiny things worth testing. Tap a card to try one.',
              style: AppTextStyles.manrope(
                fontSize: 16,
                color: AppColors.text.withValues(alpha: 0.6),
                height: 1.65,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExperimentsCarousel extends StatelessWidget {
  final bool isNarrow;
  final double horizontalPadding;

  const _ExperimentsCarousel({
    required this.isNarrow,
    required this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return RevealOnScroll(
      child: CarouselSlider.builder(
        itemCount: kExperiments.length,
        options: CarouselOptions(
          height: isNarrow ? 410 : 390,
          viewportFraction: isNarrow ? 0.9 : 0.72,
          enlargeCenterPage: false,
          enableInfiniteScroll: kExperiments.length > 1,
          autoPlay: kExperiments.length > 1,
          autoPlayInterval: const Duration(seconds: 6),
          padEnds: false,
        ),
        itemBuilder: (context, index, realIndex) {
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? horizontalPadding : 8,
              right: index == kExperiments.length - 1 ? horizontalPadding : 8,
            ),
            child: _ExperimentCard(experiment: kExperiments[index]),
          );
        },
      ),
    );
  }
}

class _ExperimentCard extends StatefulWidget {
  final Experiment experiment;

  const _ExperimentCard({required this.experiment});

  @override
  State<_ExperimentCard> createState() => _ExperimentCardState();
}

class _ExperimentCardState extends State<_ExperimentCard> {
  bool _isHovered = false;
  bool _hasFocus = false;

  bool get _isHighlighted => _isHovered || _hasFocus;

  @override
  Widget build(BuildContext context) {
    final experiment = widget.experiment;

    return Semantics(
      button: true,
      label: 'Open ${experiment.title}',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        transform: Matrix4.translationValues(0, _isHighlighted ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHighlighted
                ? AppColors.accent.withValues(alpha: 0.55)
                : AppColors.border,
          ),
          boxShadow: _isHighlighted
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.35),
                    blurRadius: 28,
                    offset: const Offset(0, 12),
                  ),
                ]
              : null,
        ),
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => context.go('/experiments/${experiment.slug}'),
            onHover: (value) => setState(() => _isHovered = value),
            onFocusChange: (value) => setState(() => _hasFocus = value),
            child: _ExperimentCardBody(
              experiment: experiment,
              isHighlighted: _isHighlighted,
            ),
          ),
        ),
      ),
    );
  }
}

class _ExperimentCardBody extends StatelessWidget {
  final Experiment experiment;
  final bool isHighlighted;

  const _ExperimentCardBody({
    required this.experiment,
    required this.isHighlighted,
  });

  @override
  Widget build(BuildContext context) {
    final actionColor = isHighlighted
        ? AppColors.accentLight
        : AppColors.accent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(flex: 5, child: ExperimentPreview(kind: experiment.kind)),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 17, 20, 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  experiment.status.toUpperCase(),
                  style: AppTextStyles.mono(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.green,
                    letterSpacing: 0.05 * 11,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  experiment.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.spaceGrotesk(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacingEm: -0.02,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Text(
                    experiment.summary,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.manrope(
                      fontSize: 13.5,
                      color: AppColors.text.withValues(alpha: 0.55),
                      height: 1.5,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Launch experiment',
                      style: AppTextStyles.manrope(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: actionColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_outward_rounded,
                      size: 14,
                      color: actionColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
