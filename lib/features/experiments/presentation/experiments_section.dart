import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_website/features/core/presentation/widgets/reveal_on_scroll.dart';
import 'package:portfolio_website/features/experiments/domain/experiment.dart';
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
    final carouselHeight = isNarrow ? 410.0 : 390.0;

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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPad),
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
                          'A sandbox for playful Flutter ideas, interaction '
                          'studies, and tiny things worth testing. Tap a card '
                          'to try one.',
                          style: AppTextStyles.manrope(
                            fontSize: 16,
                            color: AppColors.text.withValues(alpha: 0.6),
                            height: 1.65,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                RevealOnScroll(
                  child: CarouselSlider.builder(
                    itemCount: kExperiments.length,
                    options: CarouselOptions(
                      height: carouselHeight,
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
                          left: index == 0 ? horizontalPad : 8,
                          right: index == kExperiments.length - 1
                              ? horizontalPad
                              : 8,
                        ),
                        child: _ExperimentCard(experiment: kExperiments[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
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
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final experiment = widget.experiment;

    return Semantics(
      button: true,
      label: 'Open ${experiment.title}',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: () => context.go('/experiments/${experiment.slug}'),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _hovered
                    ? AppColors.accent.withValues(alpha: 0.55)
                    : AppColors.border,
              ),
              boxShadow: _hovered
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Expanded(flex: 5, child: _MotionPreview()),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 17, 20, 17),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          experiment.status,
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
                                color: _hovered
                                    ? AppColors.accentLight
                                    : AppColors.accent,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.arrow_outward_rounded,
                              size: 14,
                              color: _hovered
                                  ? AppColors.accentLight
                                  : AppColors.accent,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MotionPreview extends StatelessWidget {
  const _MotionPreview();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF17152B), Color(0xFF101625)],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _GridPainter())),
          const Positioned(top: 24, left: 24, child: FlutterLogo(size: 46)),
          Positioned(
            right: 30,
            bottom: 30,
            child: Transform.rotate(
              angle: -0.14,
              child: Container(
                width: 78,
                height: 78,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.accent, AppColors.accentBlue],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.35),
                      blurRadius: 28,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.motion_photos_on_rounded,
                  color: Colors.white,
                  size: 34,
                ),
              ),
            ),
          ),
          Positioned(
            left: 24,
            bottom: 28,
            child: Text(
              'CURVE  →  MOTION',
              style: AppTextStyles.mono(
                fontSize: 11,
                color: AppColors.text.withValues(alpha: 0.45),
                letterSpacing: 0.09 * 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.035)
      ..strokeWidth = 1;
    const spacing = 28.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
