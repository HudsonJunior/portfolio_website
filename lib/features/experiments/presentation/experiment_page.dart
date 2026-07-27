import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_website/features/core/presentation/widgets/portfolio_nav_bar.dart';
import 'package:portfolio_website/features/experiments/domain/experiment.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/theme.dart';

class ExperimentPage extends StatefulWidget {
  final String slug;

  const ExperimentPage({super.key, required this.slug});

  @override
  State<ExperimentPage> createState() => _ExperimentPageState();
}

class _ExperimentPageState extends State<ExperimentPage> {
  double _durationMs = 650;
  int _curveIndex = 1;
  bool _atEnd = false;

  static const _curves = <({String name, Curve curve})>[
    (name: 'Linear', curve: Curves.linear),
    (name: 'Ease out', curve: Curves.easeOutCubic),
    (name: 'Back', curve: Curves.easeOutBack),
    (name: 'Bounce', curve: Curves.bounceOut),
  ];

  @override
  Widget build(BuildContext context) {
    final experiment = experimentBySlug(widget.slug);

    if (experiment == null) {
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
              child: PortfolioNavBar(experimentsSelected: true),
            ),
          ],
        ),
      );
    }

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
                            fontSize: 48,
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
                            for (final tag in experiment.tags) _Tag(label: tag),
                          ],
                        ),
                        const SizedBox(height: 42),
                        _buildLab(),
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
            child: PortfolioNavBar(experimentsSelected: true),
          ),
        ],
      ),
    );
  }

  Widget _buildLab() {
    final selectedCurve = _curves[_curveIndex];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 720;
        final controls = _Controls(
          durationMs: _durationMs,
          curveIndex: _curveIndex,
          curves: _curves,
          onDurationChanged: (value) => setState(() => _durationMs = value),
          onCurveChanged: (value) => setState(() => _curveIndex = value),
          onRun: () => setState(() => _atEnd = !_atEnd),
        );
        final stage = _MotionStage(
          atEnd: _atEnd,
          duration: Duration(milliseconds: _durationMs.round()),
          curve: selectedCurve.curve,
          curveName: selectedCurve.name,
          onRun: () => setState(() => _atEnd = !_atEnd),
        );

        return Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.borderMid),
          ),
          clipBehavior: Clip.antiAlias,
          child: isNarrow
              ? Column(
                  children: [
                    SizedBox(height: 360, child: stage),
                    const Divider(height: 1, color: AppColors.borderMid),
                    Padding(padding: const EdgeInsets.all(24), child: controls),
                  ],
                )
              : SizedBox(
                  height: 480,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(flex: 7, child: stage),
                      const VerticalDivider(
                        width: 1,
                        color: AppColors.borderMid,
                      ),
                      SizedBox(
                        width: 280,
                        child: Padding(
                          padding: const EdgeInsets.all(26),
                          child: controls,
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class _MotionStage extends StatelessWidget {
  final bool atEnd;
  final Duration duration;
  final Curve curve;
  final String curveName;
  final VoidCallback onRun;

  const _MotionStage({
    required this.atEnd,
    required this.duration,
    required this.curve,
    required this.curveName,
    required this.onRun,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Run animation with $curveName curve',
      child: InkWell(
        onTap: onRun,
        mouseCursor: SystemMouseCursors.click,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF17152B), Color(0xFF101625)],
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(child: CustomPaint(painter: _StageGridPainter())),
              Positioned(
                top: 22,
                left: 24,
                child: Text(
                  'TAP THE STAGE TO RUN',
                  style: AppTextStyles.mono(
                    fontSize: 10.5,
                    color: AppColors.text.withValues(alpha: 0.35),
                    letterSpacing: 0.08 * 10.5,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 34,
                  vertical: 64,
                ),
                child: AnimatedAlign(
                  alignment: atEnd
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  duration: duration,
                  curve: curve,
                  child: Container(
                    width: 86,
                    height: 86,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.accent, AppColors.accentBlue],
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withValues(alpha: 0.35),
                          blurRadius: 32,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.flutter_dash_rounded,
                      size: 42,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 24,
                bottom: 20,
                child: Text(
                  '${duration.inMilliseconds} MS  ·  ${curveName.toUpperCase()}',
                  style: AppTextStyles.mono(
                    fontSize: 10.5,
                    color: AppColors.accentLight,
                    letterSpacing: 0.06 * 10.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Controls extends StatelessWidget {
  final double durationMs;
  final int curveIndex;
  final List<({String name, Curve curve})> curves;
  final ValueChanged<double> onDurationChanged;
  final ValueChanged<int> onCurveChanged;
  final VoidCallback onRun;

  const _Controls({
    required this.durationMs,
    required this.curveIndex,
    required this.curves,
    required this.onDurationChanged,
    required this.onCurveChanged,
    required this.onRun,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'CONTROLS',
          style: AppTextStyles.mono(
            fontSize: 11,
            color: AppColors.accentLight,
            letterSpacing: 0.07 * 11,
          ),
        ),
        const SizedBox(height: 26),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Duration',
              style: AppTextStyles.manrope(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${durationMs.round()} ms',
              style: AppTextStyles.mono(
                fontSize: 11.5,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
        Slider(
          value: durationMs,
          min: 150,
          max: 1400,
          divisions: 25,
          activeColor: AppColors.accent,
          inactiveColor: AppColors.borderMid,
          onChanged: onDurationChanged,
        ),
        const SizedBox(height: 20),
        Text(
          'Curve',
          style: AppTextStyles.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (var i = 0; i < curves.length; i++)
              ChoiceChip(
                label: Text(curves[i].name),
                selected: curveIndex == i,
                showCheckmark: false,
                selectedColor: AppColors.accent.withValues(alpha: 0.26),
                backgroundColor: AppColors.surfaceAlt,
                side: BorderSide(
                  color: curveIndex == i
                      ? AppColors.accent.withValues(alpha: 0.65)
                      : AppColors.borderMid,
                ),
                labelStyle: AppTextStyles.manrope(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: curveIndex == i
                      ? AppColors.accentPurpleLight
                      : AppColors.textMuted,
                ),
                onSelected: (_) => onCurveChanged(i),
              ),
          ],
        ),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: onRun,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.play_arrow_rounded, size: 20),
            label: Text(
              'Run animation',
              style: AppTextStyles.manrope(
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;

  const _Tag({required this.label});

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

class _StageGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.035)
      ..strokeWidth = 1;
    const spacing = 32.0;
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
