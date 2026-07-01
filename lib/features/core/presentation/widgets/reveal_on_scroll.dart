import 'package:flutter/material.dart';

// ─── Scroll position provider ──────────────────────────────────────────────────
// Holds the raw scroll pixels as a ValueNotifier. updateShouldNotify is always
// false so this widget never causes cascading rebuilds — descendants subscribe
// imperatively via ValueNotifier.addListener.

class PortfolioScroll extends InheritedWidget {
  final ValueNotifier<double> scrollPos;

  const PortfolioScroll({
    super.key,
    required this.scrollPos,
    required super.child,
  });

  static ValueNotifier<double>? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<PortfolioScroll>()?.scrollPos;

  @override
  bool updateShouldNotify(PortfolioScroll old) => false;
}

// ─── Reveal-on-scroll wrapper ──────────────────────────────────────────────────
// Fades + slides child up once when it enters the visible viewport.
// Requires a [PortfolioScroll] ancestor in the tree.

class RevealOnScroll extends StatefulWidget {
  final Widget child;

  /// Optional delay before the animation starts (use for staggered sequences).
  final Duration delay;

  /// Logical pixels the widget slides up from when revealing.
  final double slideDistance;

  /// Total animation duration.
  final Duration duration;

  const RevealOnScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.slideDistance = 36.0,
    this.duration = const Duration(milliseconds: 700),
  });

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;
  late final Animation<double> _slideY;

  ValueNotifier<double>? _scrollPos;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 0.70, curve: Curves.easeOut),
      ),
    );

    _slideY = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_scrollPos == null) {
      _scrollPos = PortfolioScroll.of(context);
      _scrollPos?.addListener(_checkVisibility);
      // Also check immediately in case the widget is already visible on build.
      WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
    }
  }

  void _checkVisibility() {
    if (_triggered || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;

    final topY = box.localToGlobal(Offset.zero).dy;
    final screenH = MediaQuery.of(context).size.height;

    // Fire when the top edge of the widget is within 90% of the viewport height.
    if (topY < screenH * 0.90) {
      _triggered = true;
      _scrollPos?.removeListener(_checkVisibility);
      Future.delayed(widget.delay, () {
        if (mounted) _ctrl.forward();
      });
    }
  }

  @override
  void dispose() {
    _scrollPos?.removeListener(_checkVisibility);
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, child) => Opacity(
        opacity: _opacity.value,
        child: Transform.translate(
          offset: Offset(0, _slideY.value * widget.slideDistance),
          child: child,
        ),
      ),
      child: widget.child,
    );
  }
}
