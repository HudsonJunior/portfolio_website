import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_website/features/home/presentation/widgets/common/scroll_down_indicator.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/cv_download.dart';
import 'package:portfolio_website/resources/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeSectionDesktop extends StatefulWidget {
  final VoidCallback? onScrollToExperience;

  const HomeSectionDesktop({super.key, this.onScrollToExperience});

  @override
  State<HomeSectionDesktop> createState() => _HomeSectionDesktopState();
}

class _HomeSectionDesktopState extends State<HomeSectionDesktop>
    with TickerProviderStateMixin {
  // ── Looping ambient controllers ──────────────────────────────
  late final AnimationController _blob1;
  late final AnimationController _blob2;
  late final AnimationController _ring;
  late final AnimationController _blink;

  // ── One-shot entrance controller ─────────────────────────────
  late final AnimationController _enter;

  // ── One-shot typing controller (starts after _enter) ─────────
  late final AnimationController _type;

  // Per-element enter animations (staggered via Interval)
  late final Animation<double> _aBadge;
  late final Animation<double> _aHeadline;
  late final Animation<double> _aBio;
  late final Animation<double> _aCta;
  late final Animation<double> _aSocial;
  late final Animation<double> _aRight;

  @override
  void initState() {
    super.initState();

    _blob1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat(reverse: true);

    _blob2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat(reverse: true);

    _ring = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    )..repeat();

    _blink = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat();

    // ── Entrance sequence (total: 1000ms) ──────────────────────
    _enter = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    Animation<double> interval(double from, double to) =>
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _enter,
            curve: Interval(from, to, curve: Curves.easeOut),
          ),
        );

    _aBadge = interval(0.00, 0.35);
    _aHeadline = interval(0.10, 0.48);
    _aBio = interval(0.22, 0.58);
    _aCta = interval(0.34, 0.68);
    _aSocial = interval(0.44, 0.78);
    _aRight = interval(0.14, 0.54);

    // ── Typing controller (1800ms, starts 300ms after _enter done)
    _type = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    // Start after the first frame so widgets are laid out
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _enter.forward();
      }
    });

    _enter.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) _type.forward();
        });
      }
    });
  }

  @override
  void dispose() {
    _blob1.dispose();
    _blob2.dispose();
    _ring.dispose();
    _blink.dispose();
    _enter.dispose();
    _type.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final blobSize1 = math.min(size.width * 0.6, 820.0);
    final blobSize2 = math.min(size.width * 0.55, 700.0);

    return SizedBox(
      width: double.infinity,
      height: math.max(size.height, 700.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ── Blob 1 – top-right, indigo ──────────────────────
          Positioned(
            top: -size.height * 0.15,
            right: -size.width * 0.05,
            child: _AnimatedBlob(
              controller: _blob1,
              size: blobSize1,
              dx: 0.04,
              dy: -0.03,
              scaleAdd: 0.08,
              color: const Color(0xFF6366F1),
              opacity: 0.40,
            ),
          ),

          // ── Blob 2 – bottom-left, purple ────────────────────
          Positioned(
            bottom: -size.height * 0.25,
            left: -size.width * 0.12,
            child: _AnimatedBlob(
              controller: _blob2,
              size: blobSize2,
              dx: -0.05,
              dy: 0.04,
              scaleAdd: 0.12,
              color: AppColors.accent,
              opacity: 0.42,
            ),
          ),

          // ── Grid overlay with radial fade ────────────────────
          Positioned.fill(
            child: ShaderMask(
              shaderCallback: (bounds) => const RadialGradient(
                center: Alignment(0, -0.1),
                radius: 0.85,
                colors: [Colors.black, Colors.transparent],
                stops: [0.30, 0.78],
              ).createShader(bounds),
              blendMode: BlendMode.dstIn,
              child: const CustomPaint(painter: _GridPainter()),
            ),
          ),

          // ── Main content ─────────────────────────────────────
          Positioned.fill(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(80, 120, 80, 80),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 115,
                        child: _HeroLeft(
                          onScrollToExperience: widget.onScrollToExperience,
                          badgeAnim: _aBadge,
                          headlineAnim: _aHeadline,
                          bioAnim: _aBio,
                          ctaAnim: _aCta,
                          socialAnim: _aSocial,
                        ),
                      ),
                      const SizedBox(width: 72),
                      Expanded(
                        flex: 85,
                        child: _FadeSlide(
                          animation: _aRight,
                          child: _HeroRight(
                            ringController: _ring,
                            blinkController: _blink,
                            typeProgress: _type,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Scroll-down indicator ─────────────────────────────
          const Positioned(
            bottom: 36,
            left: 0,
            right: 0,
            child: ScrollDownIndicator(),
          ),
        ],
      ),
    );
  }
}

// ─── Fade + slide-up helper ────────────────────────────────────────────────────

class _FadeSlide extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const _FadeSlide({
    required this.animation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, w) => Opacity(
        opacity: animation.value,
        child: Transform.translate(
          offset: Offset(0, 28 * (1 - animation.value)),
          child: w,
        ),
      ),
      child: child,
    );
  }
}

// ─── Animated mesh blob ────────────────────────────────────────────────────────

class _AnimatedBlob extends StatelessWidget {
  final AnimationController controller;
  final double size;
  final double dx;
  final double dy;
  final double scaleAdd;
  final Color color;
  final double opacity;

  const _AnimatedBlob({
    required this.controller,
    required this.size,
    required this.dx,
    required this.dy,
    required this.scaleAdd,
    required this.color,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) {
        final t = Curves.easeInOut.transform(controller.value);
        return Transform(
          transform: Matrix4.identity()
            ..translateByDouble(size * dx * t, size * dy * t, 0, 1.0)
            ..scaleByDouble(
              1.0 + scaleAdd * t,
              1.0 + scaleAdd * t,
              1.0 + scaleAdd * t,
              1.0,
            ),
          alignment: Alignment.center,
          child: child,
        );
      },
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                color.withValues(alpha: opacity),
                color.withValues(alpha: 0.0),
              ],
              stops: const [0.0, 0.62],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Grid painter ──────────────────────────────────────────────────────────────

class _GridPainter extends CustomPainter {
  const _GridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..strokeWidth = 1;

    const spacing = 48.0;
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter _) => false;
}

// ─── Left column ───────────────────────────────────────────────────────────────

class _HeroLeft extends StatelessWidget {
  final VoidCallback? onScrollToExperience;
  final Animation<double> badgeAnim;
  final Animation<double> headlineAnim;
  final Animation<double> bioAnim;
  final Animation<double> ctaAnim;
  final Animation<double> socialAnim;

  const _HeroLeft({
    this.onScrollToExperience,
    required this.badgeAnim,
    required this.headlineAnim,
    required this.bioAnim,
    required this.ctaAnim,
    required this.socialAnim,
  });

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // // ── Available badge ──────────────────────────────────
        // _FadeSlide(
        //   animation: badgeAnim,
        //   child: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Container(
        //         width: 7,
        //         height: 7,
        //         decoration: const BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: AppColors.green,
        //           boxShadow: [
        //             BoxShadow(color: AppColors.green, blurRadius: 10)
        //           ],
        //         ),
        //       ),
        //       const SizedBox(width: 8),
        //       Text(
        //         'available for new work',
        //         style: AppTextStyles.mono(
        //           fontSize: 12.5,
        //           color: AppColors.accentLight,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // const SizedBox(height: 22),

        // ── Headline ─────────────────────────────────────────
        _FadeSlide(
          animation: headlineAnim,
          child: Text.rich(
            TextSpan(
              style: AppTextStyles.spaceGrotesk(
                fontSize: 62,
                fontWeight: FontWeight.w700,
                color: AppColors.text,
                letterSpacingEm: -0.03,
                height: 1.03,
              ),
              children: [
                const TextSpan(text: 'Senior '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: ShaderMask(
                    shaderCallback: (b) => const LinearGradient(
                      colors: [Color(0xFF818CF8), Color(0xFFC4B5FD)],
                    ).createShader(b),
                    child: Text(
                      'Mobile',
                      style: AppTextStyles.spaceGrotesk(
                        fontSize: 62,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacingEm: -0.03,
                        height: 1.03,
                      ),
                    ),
                  ),
                ),
                const TextSpan(text: ' Engineer\n& '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: ShaderMask(
                    shaderCallback: (b) => const LinearGradient(
                      colors: [Color(0xFF818CF8), Color(0xFFC4B5FD)],
                    ).createShader(b),
                    child: Text(
                      'AI Applied',
                      style: AppTextStyles.spaceGrotesk(
                        fontSize: 62,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacingEm: -0.03,
                        height: 1.03,
                      ),
                    ),
                  ),
                ),
                const TextSpan(text: '\nEngineer'),
                const TextSpan(
                  text: '.',
                  style: TextStyle(color: AppColors.accent),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // ── Bio ───────────────────────────────────────────────
        _FadeSlide(
          animation: bioAnim,
          child: Text.rich(
            TextSpan(
              style: AppTextStyles.manrope(
                fontSize: 17,
                color: AppColors.text.withValues(alpha: 0.62),
                height: 1.68,
              ),
              children: [
                const TextSpan(text: "Hi, I'm "),
                TextSpan(
                  text: 'Hudson Proença',
                  style: AppTextStyles.manrope(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                    height: 1.68,
                  ),
                ),
                const TextSpan(
                  text:
                      ' — a Flutter & mobile engineer who builds high-performance, scalable apps and leads teams to ship them with care.',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 34),

        // ── CTA buttons ───────────────────────────────────────
        _FadeSlide(
          animation: ctaAnim,
          child: Wrap(
            spacing: 14,
            runSpacing: 14,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _GradientButton(
                label: 'View experience',
                icon: Icons.arrow_downward_rounded,
                onTap: onScrollToExperience ?? () {},
              ),
              _GhostButton(
                label: 'Get in touch',
                onTap: () => _launch('mailto:devhudsoncontact@gmail.com'),
              ),
              const _GhostButton(
                label: 'Download CV',
                icon: Icons.download_rounded,
                onTap: downloadCV,
              ),
            ],
          ),
        ),
        const SizedBox(height: 38),

        // ── Social row ────────────────────────────────────────
        _FadeSlide(
          animation: socialAnim,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'find me on',
                style: AppTextStyles.mono(
                  fontSize: 12,
                  color: AppColors.text.withValues(alpha: 0.4),
                ),
              ),
              const SizedBox(width: 16),
              _SocialButton(
                icon: FontAwesomeIcons.linkedinIn,
                onTap: () =>
                    _launch('https://www.linkedin.com/in/hudson-p-46583011a/'),
              ),
              const SizedBox(width: 10),
              _SocialButton(
                icon: FontAwesomeIcons.github,
                onTap: () => _launch('https://github.com/HudsonJunior'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Right column ──────────────────────────────────────────────────────────────

class _HeroRight extends StatelessWidget {
  final AnimationController ringController;
  final AnimationController blinkController;
  final Animation<double> typeProgress;

  const _HeroRight({
    required this.ringController,
    required this.blinkController,
    required this.typeProgress,
  });

  @override
  Widget build(BuildContext context) {
    const photoSize = 300.0;
    const ringPad = 14.0;
    const coverPad = 4.0;
    const totalSize = photoSize + ringPad * 2;

    return Center(
      child: SizedBox(
        width: totalSize + 50,
        height: totalSize + 50,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Spinning conic-gradient ring
            SizedBox(
              width: totalSize,
              height: totalSize,
              child: RotationTransition(
                turns: ringController,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SweepGradient(
                      startAngle: 200 * math.pi / 180,
                      colors: [
                        Color(0xFF6366F1),
                        Color(0xFF8B5CF6),
                        Color(0xFF22D3EE),
                        Color(0xFF6366F1),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Dark cover ring (hides gradient behind photo)
            Container(
              width: photoSize + coverPad * 2,
              height: photoSize + coverPad * 2,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.background,
              ),
            ),

            // Profile photo
            SizedBox(
              width: photoSize,
              height: photoSize,
              child: ClipOval(
                child: Image.asset(
                  'assets/profile.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Terminal card – bottom-left overlay
            Positioned(
              bottom: 0,
              left: 0,
              child: _TerminalCard(
                blinkController: blinkController,
                typeProgress: typeProgress,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Terminal card with typing animation ───────────────────────────────────────

// Span data: (text, color)
// Grouped into 4 visual lines by cumulative char count.
// Line 0: spans 0-2  (chars 0-13,  total 14)
// Line 1: spans 3-6  (chars 14-41, total 28)
// Line 2: spans 7-10 (chars 42-62, total 21)
// Line 3: span 11    (chars 63-63, total 1)
const _kSpans = [
  ('class ', AppColors.accentLight), // 6
  ('Hudson ', AppColors.text), // 7
  ('{', AppColors.text), // 1  → line 0 ends at 14
  ('  final ', AppColors.accentPurpleLight), // 8
  ('stack = [', AppColors.text), // 9
  ("'flutter'", AppColors.green), // 9
  ('];', AppColors.text), // 2  → line 1 ends at 42
  ('  final ', AppColors.accentPurpleLight), // 8
  ('since = ', AppColors.text), // 8
  ('2019', AppColors.yellow), // 4
  (';', AppColors.text), // 1  → line 2 ends at 63
  ('}', AppColors.text), // 1  → line 3
];
const _kTotalChars = 64;
// Which span index starts each line
const _kLineBreaks = [0, 3, 7, 11]; // span indices where each new line starts

class _TerminalCard extends StatelessWidget {
  final AnimationController blinkController;
  final Animation<double> typeProgress;

  const _TerminalCard({
    required this.blinkController,
    required this.typeProgress,
  });

  /// Build the typed code body given how many chars have been typed (0–64).
  Widget _buildCode(int charsTyped) {
    // Distribute charsTyped across spans → group into visual lines
    final List<List<InlineSpan>> lines = [[], [], [], []];
    int remaining = charsTyped;
    int lineIdx = 0;

    for (int i = 0; i < _kSpans.length; i++) {
      if (remaining <= 0) break;

      // Advance lineIdx when we hit a new line boundary
      final nextLineStart = _kLineBreaks.indexWhere(
        (b) => b == i,
        1, // skip index 0
      );
      if (nextLineStart != -1) lineIdx = nextLineStart;

      final (text, color) = _kSpans[i];
      final show = text.substring(0, math.min(remaining, text.length));
      remaining -= show.length;

      lines[lineIdx].add(
        TextSpan(
          text: show,
          style: AppTextStyles.mono(fontSize: 11.5, color: color),
        ),
      );
    }

    // Render non-empty lines, inserting the blinking cursor on the last
    // visible line if typing is still in progress
    final bool done = charsTyped >= _kTotalChars;
    final lineWidgets = <Widget>[];

    for (int l = 0; l < 4; l++) {
      if (lines[l].isEmpty) break;

      final bool isLastVisible = l == 3 || (l < 3 && lines[l + 1].isEmpty);

      if (lineWidgets.isNotEmpty) lineWidgets.add(const SizedBox(height: 3));

      if (isLastVisible && !done) {
        // Append inline cursor to this line
        lineWidgets.add(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text.rich(TextSpan(children: lines[l])),
              AnimatedBuilder(
                animation: blinkController,
                builder: (_, __) => Container(
                  width: 6,
                  height: 13,
                  margin: const EdgeInsets.only(left: 2),
                  color: blinkController.value < 0.5
                      ? AppColors.accent
                      : Colors.transparent,
                ),
              ),
            ],
          ),
        );
      } else if (l == 3 && done) {
        // Final line: } + permanent cursor
        lineWidgets.add(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text.rich(TextSpan(children: lines[l])),
              const SizedBox(width: 3),
              AnimatedBuilder(
                animation: blinkController,
                builder: (_, __) => Container(
                  width: 8,
                  height: 14,
                  color: blinkController.value < 0.5
                      ? AppColors.accent
                      : Colors.transparent,
                ),
              ),
            ],
          ),
        );
      } else {
        lineWidgets.add(Text.rich(TextSpan(children: lines[l])));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lineWidgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: 240,
          decoration: BoxDecoration(
            color: const Color(0xF00E0F15),
            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 60,
                offset: const Offset(0, 24),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title bar
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                decoration: BoxDecoration(
                  border: Border(
                    bottom:
                        BorderSide(color: Colors.white.withValues(alpha: 0.08)),
                  ),
                ),
                child: Row(
                  children: [
                    const _Dot(color: Color(0xFFFB7185)),
                    const SizedBox(width: 6),
                    const _Dot(color: Color(0xFFFBBF24)),
                    const SizedBox(width: 6),
                    const _Dot(color: AppColors.green),
                    const SizedBox(width: 8),
                    Text(
                      'engineer.dart',
                      style: AppTextStyles.mono(
                        fontSize: 10.5,
                        color: AppColors.text.withValues(alpha: 0.4),
                      ),
                    ),
                  ],
                ),
              ),

              // Typed code body
              Padding(
                padding: const EdgeInsets.all(14),
                child: AnimatedBuilder(
                  animation: typeProgress,
                  builder: (_, __) {
                    final charsTyped =
                        (typeProgress.value * _kTotalChars).floor();
                    return _buildCode(charsTyped);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  const _Dot({required this.color});

  @override
  Widget build(BuildContext context) => Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color));
}

// ─── CTA — gradient button ─────────────────────────────────────────────────────

class _GradientButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _GradientButton(
      {required this.label, required this.icon, required this.onTap});

  @override
  State<_GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<_GradientButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6366F1)
                    .withValues(alpha: _hovered ? 0.6 : 0.42),
                blurRadius: _hovered ? 44 : 30,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.label,
                  style: AppTextStyles.manrope(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              const SizedBox(width: 9),
              Icon(widget.icon, color: Colors.white, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── CTA — ghost button ────────────────────────────────────────────────────────

class _GhostButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  const _GhostButton({required this.label, required this.onTap, this.icon});

  @override
  State<_GhostButton> createState() => _GhostButtonState();
}

class _GhostButtonState extends State<_GhostButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: _hovered ? 0.06 : 0.03),
            border: Border.all(
              color: _hovered
                  ? AppColors.accent
                  : Colors.white.withValues(alpha: 0.16),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: widget.icon != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(widget.label,
                        style: AppTextStyles.manrope(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.text)),
                    const SizedBox(width: 8),
                    Icon(widget.icon, color: AppColors.text, size: 16),
                  ],
                )
              : Text(widget.label,
                  style: AppTextStyles.manrope(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.text)),
        ),
      ),
    );
  }
}

// ─── Social icon button ────────────────────────────────────────────────────────

class _SocialButton extends StatefulWidget {
  final FaIconData icon;
  final VoidCallback onTap;
  const _SocialButton({required this.icon, required this.onTap});

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 42,
          height: 42,
          transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
          decoration: BoxDecoration(
            border: Border.all(
              color: _hovered
                  ? AppColors.accentLight
                  : Colors.white.withValues(alpha: 0.14),
            ),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Center(
            child: FaIcon(widget.icon,
                size: 17,
                color: _hovered ? AppColors.accentLight : AppColors.text),
          ),
        ),
      ),
    );
  }
}
