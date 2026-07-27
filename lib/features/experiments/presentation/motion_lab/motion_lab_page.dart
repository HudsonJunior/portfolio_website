import 'package:flutter/material.dart';
import 'package:portfolio_website/features/experiments/domain/experiment.dart';
import 'package:portfolio_website/features/experiments/presentation/widgets/experiment_detail_scaffold.dart';
import 'package:portfolio_website/features/experiments/presentation/widgets/experiment_grid_background.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/theme.dart';

class MotionLabPage extends StatefulWidget {
  const MotionLabPage({super.key});

  @override
  State<MotionLabPage> createState() => _MotionLabPageState();
}

class _MotionLabPageState extends State<MotionLabPage> {
  static const _curveOptions = <_MotionCurveOption>[
    _MotionCurveOption(label: 'Linear', curve: Curves.linear),
    _MotionCurveOption(label: 'Ease out', curve: Curves.easeOutCubic),
    _MotionCurveOption(label: 'Back', curve: Curves.easeOutBack),
    _MotionCurveOption(label: 'Bounce', curve: Curves.bounceOut),
  ];

  double _durationMs = 650;
  _MotionCurveOption _selectedCurve = _curveOptions[1];
  bool _atEnd = false;

  void _runAnimation() => setState(() => _atEnd = !_atEnd);
  void _setDuration(double value) => setState(() => _durationMs = value);
  void _setCurve(_MotionCurveOption value) {
    setState(() => _selectedCurve = value);
  }

  @override
  Widget build(BuildContext context) {
    return ExperimentDetailScaffold(
      experiment: kMotionLabExperiment,
      child: _MotionLab(
        durationMs: _durationMs,
        selectedCurve: _selectedCurve,
        curveOptions: _curveOptions,
        atEnd: _atEnd,
        onDurationChanged: _setDuration,
        onCurveChanged: _setCurve,
        onRun: _runAnimation,
      ),
    );
  }
}

class _MotionLab extends StatelessWidget {
  final double durationMs;
  final _MotionCurveOption selectedCurve;
  final List<_MotionCurveOption> curveOptions;
  final bool atEnd;
  final ValueChanged<double> onDurationChanged;
  final ValueChanged<_MotionCurveOption> onCurveChanged;
  final VoidCallback onRun;

  const _MotionLab({
    required this.durationMs,
    required this.selectedCurve,
    required this.curveOptions,
    required this.atEnd,
    required this.onDurationChanged,
    required this.onCurveChanged,
    required this.onRun,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 720;
        final controls = _Controls(
          durationMs: durationMs,
          selectedCurve: selectedCurve,
          curveOptions: curveOptions,
          onDurationChanged: onDurationChanged,
          onCurveChanged: onCurveChanged,
          onRun: onRun,
        );
        final stage = _MotionStage(
          atEnd: atEnd,
          duration: Duration(milliseconds: durationMs.round()),
          curveOption: selectedCurve,
          onRun: onRun,
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
  final _MotionCurveOption curveOption;
  final VoidCallback onRun;

  const _MotionStage({
    required this.atEnd,
    required this.duration,
    required this.curveOption,
    required this.onRun,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Run animation with ${curveOption.label} curve',
      child: ExperimentGridBackground(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onRun,
            mouseCursor: SystemMouseCursors.click,
            child: Stack(
              children: [
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
                    curve: curveOption.curve,
                    child: const _MotionObject(),
                  ),
                ),
                _StageStatus(duration: duration, curveOption: curveOption),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MotionObject extends StatelessWidget {
  const _MotionObject();

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class _StageStatus extends StatelessWidget {
  final Duration duration;
  final _MotionCurveOption curveOption;

  const _StageStatus({required this.duration, required this.curveOption});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 24,
      bottom: 20,
      child: Text(
        '${duration.inMilliseconds} MS  ·  ${curveOption.label.toUpperCase()}',
        style: AppTextStyles.mono(
          fontSize: 10.5,
          color: AppColors.accentLight,
          letterSpacing: 0.06 * 10.5,
        ),
      ),
    );
  }
}

class _Controls extends StatelessWidget {
  final double durationMs;
  final _MotionCurveOption selectedCurve;
  final List<_MotionCurveOption> curveOptions;
  final ValueChanged<double> onDurationChanged;
  final ValueChanged<_MotionCurveOption> onCurveChanged;
  final VoidCallback onRun;

  const _Controls({
    required this.durationMs,
    required this.selectedCurve,
    required this.curveOptions,
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
        _DurationControl(durationMs: durationMs, onChanged: onDurationChanged),
        const SizedBox(height: 20),
        _CurveControl(
          options: curveOptions,
          selectedOption: selectedCurve,
          onChanged: onCurveChanged,
        ),
        const SizedBox(height: 28),
        _RunAnimationButton(onPressed: onRun),
      ],
    );
  }
}

class _DurationControl extends StatelessWidget {
  final double durationMs;
  final ValueChanged<double> onChanged;

  const _DurationControl({required this.durationMs, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _CurveControl extends StatelessWidget {
  final List<_MotionCurveOption> options;
  final _MotionCurveOption selectedOption;
  final ValueChanged<_MotionCurveOption> onChanged;

  const _CurveControl({
    required this.options,
    required this.selectedOption,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            for (final option in options)
              ChoiceChip(
                label: Text(option.label),
                selected: selectedOption == option,
                showCheckmark: false,
                selectedColor: AppColors.accent.withValues(alpha: 0.26),
                backgroundColor: AppColors.surfaceAlt,
                side: BorderSide(
                  color: selectedOption == option
                      ? AppColors.accent.withValues(alpha: 0.65)
                      : AppColors.borderMid,
                ),
                labelStyle: AppTextStyles.manrope(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: selectedOption == option
                      ? AppColors.accentPurpleLight
                      : AppColors.textMuted,
                ),
                onSelected: (_) => onChanged(option),
              ),
          ],
        ),
      ],
    );
  }
}

class _RunAnimationButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _RunAnimationButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: onPressed,
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
    );
  }
}

class _MotionCurveOption {
  final String label;
  final Curve curve;

  const _MotionCurveOption({required this.label, required this.curve});
}
