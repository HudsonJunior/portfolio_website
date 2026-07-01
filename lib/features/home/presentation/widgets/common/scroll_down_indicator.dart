import 'package:flutter/material.dart';
import 'package:portfolio_website/features/core/presentation/widgets/reveal_on_scroll.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/theme.dart';

/// Centered bounce-arrow that fades out once the user scrolls past 80px.
/// Must be a descendant of [PortfolioScroll].
class ScrollDownIndicator extends StatefulWidget {
  const ScrollDownIndicator({super.key});

  @override
  State<ScrollDownIndicator> createState() => _ScrollDownIndicatorState();
}

class _ScrollDownIndicatorState extends State<ScrollDownIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounce;
  ValueNotifier<double>? _scrollNotifier;

  @override
  void initState() {
    super.initState();
    _bounce = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollNotifier?.removeListener(_rebuild);
    _scrollNotifier = PortfolioScroll.of(context);
    _scrollNotifier?.addListener(_rebuild);
  }

  void _rebuild() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _scrollNotifier?.removeListener(_rebuild);
    _bounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scrollPos = _scrollNotifier?.value ?? 0.0;
    final opacity = (1.0 - (scrollPos / 80.0)).clamp(0.0, 1.0);

    if (opacity == 0.0) return const SizedBox.shrink();

    return Opacity(
      opacity: opacity,
      child: AnimatedBuilder(
        animation: _bounce,
        builder: (_, __) {
          final t = CurvedAnimation(
            parent: _bounce,
            curve: Curves.easeInOut,
          ).value;
          return Transform.translate(
            offset: Offset(0, 8 * t),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'scroll',
                  style: AppTextStyles.mono(
                    fontSize: 10.5,
                    color: AppColors.text.withOpacity(0.3),
                    letterSpacing: 0.1 * 10.5,
                  ),
                ),
                const SizedBox(height: 6),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  color: AppColors.text.withOpacity(0.3),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
