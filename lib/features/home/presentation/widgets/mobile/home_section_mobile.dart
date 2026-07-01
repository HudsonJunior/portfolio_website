import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_website/features/home/presentation/widgets/common/scroll_down_indicator.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeSectionMobile extends StatefulWidget {
  final VoidCallback? onScrollToExperience;

  const HomeSectionMobile({super.key, this.onScrollToExperience});

  @override
  State<HomeSectionMobile> createState() => _HomeSectionMobileState();
}

class _HomeSectionMobileState extends State<HomeSectionMobile>
    with TickerProviderStateMixin {
  // ── Looping ambient controllers ──────────────────────────────
  late final AnimationController _ring;
  late final AnimationController _blob;

  // ── One-shot entrance controller ─────────────────────────────
  late final AnimationController _enter;

  late final Animation<double> _aPhoto;
  // late final Animation<double> _aBadge;
  late final Animation<double> _aHeadline;
  late final Animation<double> _aBio;
  late final Animation<double> _aCta;
  late final Animation<double> _aSocial;

  @override
  void initState() {
    super.initState();

    _ring = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    )..repeat();

    _blob = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat(reverse: true);

    // ── Entrance sequence (total: 1000ms) ──────────────────────
    _enter = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    Animation<double> _interval(double from, double to) =>
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _enter,
            curve: Interval(from, to, curve: Curves.easeOut),
          ),
        );

    _aPhoto = _interval(0.00, 0.40);
    // _aBadge = _interval(0.10, 0.48);
    _aHeadline = _interval(0.20, 0.58);
    _aBio = _interval(0.30, 0.68);
    _aCta = _interval(0.40, 0.78);
    _aSocial = _interval(0.50, 0.88);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _enter.forward();
    });
  }

  @override
  void dispose() {
    _ring.dispose();
    _blob.dispose();
    _enter.dispose();
    super.dispose();
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }

  // Inline fade + slide-up helper (same pattern as desktop _FadeSlide)
  Widget _fs(Animation<double> a, Widget child, {double distance = 28}) {
    return AnimatedBuilder(
      animation: a,
      builder: (_, w) => Opacity(
        opacity: a.value,
        child: Transform.translate(
          offset: Offset(0, distance * (1 - a.value)),
          child: w,
        ),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final blobSize = math.min(size.width * 0.8, 500.0);

    return SizedBox(
      width: double.infinity,
      height: math.max(size.height, 700.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background blob
          Positioned(
            top: -blobSize * 0.2,
            right: -blobSize * 0.3,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                width: blobSize,
                height: blobSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF6366F1).withOpacity(0.35),
                      const Color(0xFF6366F1).withOpacity(0.0),
                    ],
                    stops: const [0.0, 0.62],
                  ),
                ),
              ),
            ),
          ),

          // Scroll-down indicator
          const Positioned(
            bottom: 28,
            left: 0,
            right: 0,
            child: ScrollDownIndicator(),
          ),

          // Content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 110, 24, 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Photo with spinning ring
                  _fs(_aPhoto, _MobileRingPhoto(ringController: _ring),
                      distance: 20),
                  const SizedBox(height: 36),

                  // // Available badge
                  // _fs(
                  //   _aBadge,
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
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
                  //           fontSize: 12,
                  //           color: AppColors.accentLight,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 18),

                  // Headline
                  _fs(
                    _aHeadline,
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        style: AppTextStyles.spaceGrotesk(
                          fontSize: 38,
                          fontWeight: FontWeight.w700,
                          color: AppColors.text,
                          letterSpacingEm: -0.03,
                          height: 1.08,
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
                                textAlign: TextAlign.center,
                                style: AppTextStyles.spaceGrotesk(
                                  fontSize: 38,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  letterSpacingEm: -0.03,
                                  height: 1.08,
                                ),
                              ),
                            ),
                          ),
                          const TextSpan(text: '\nEngineer'),
                          TextSpan(
                            text: '.',
                            style: TextStyle(color: AppColors.accent),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Bio
                  _fs(
                    _aBio,
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        style: AppTextStyles.manrope(
                          fontSize: 15,
                          color: AppColors.text.withOpacity(0.62),
                          height: 1.65,
                        ),
                        children: [
                          const TextSpan(text: "Hi, I'm "),
                          TextSpan(
                            text: 'Hudson Proença',
                            style: AppTextStyles.manrope(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.text,
                              height: 1.65,
                            ),
                          ),
                          const TextSpan(
                              text:
                                  ' — Flutter & mobile engineer, building high-performance apps with care.'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // CTA buttons
                  _fs(
                    _aCta,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _MobileGradientButton(
                          label: 'View experience',
                          icon: Icons.arrow_downward_rounded,
                          onTap: widget.onScrollToExperience ?? () {},
                        ),
                        const SizedBox(height: 12),
                        _MobileGhostButton(
                          label: 'Get in touch',
                          onTap: () =>
                              _launch('mailto:devhudsoncontact@gmail.com'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Social row
                  _fs(
                    _aSocial,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'find me on',
                          style: AppTextStyles.mono(
                            fontSize: 12,
                            color: AppColors.text.withOpacity(0.4),
                          ),
                        ),
                        const SizedBox(width: 16),
                        _SmallSocialButton(
                          icon: FontAwesomeIcons.linkedinIn,
                          onTap: () => _launch(
                              'https://www.linkedin.com/in/hudson-p-46583011a/'),
                        ),
                        const SizedBox(width: 10),
                        _SmallSocialButton(
                          icon: FontAwesomeIcons.github,
                          onTap: () =>
                              _launch('https://github.com/HudsonJunior'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Mobile spinning ring + photo ─────────────────────────────────────────────

class _MobileRingPhoto extends StatelessWidget {
  final AnimationController ringController;
  const _MobileRingPhoto({required this.ringController});

  @override
  Widget build(BuildContext context) {
    const photoSize = 180.0;
    const ringPad = 10.0;
    const coverPad = 3.0;
    const totalSize = photoSize + ringPad * 2;

    return Center(
      child: SizedBox(
        width: totalSize,
        height: totalSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
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
            Container(
              width: photoSize + coverPad * 2,
              height: photoSize + coverPad * 2,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.background,
              ),
            ),
            SizedBox(
              width: photoSize,
              height: photoSize,
              child: ClipOval(
                child: Image.asset('assets/profile.jpeg', fit: BoxFit.cover),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Mobile buttons ────────────────────────────────────────────────────────────

class _MobileGradientButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _MobileGradientButton(
      {required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6366F1).withOpacity(0.42),
              blurRadius: 30,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label,
                style: AppTextStyles.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
            const SizedBox(width: 9),
            Icon(icon, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}

class _MobileGhostButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _MobileGhostButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          border: Border.all(color: Colors.white.withOpacity(0.16)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(label,
              style: AppTextStyles.manrope(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text)),
        ),
      ),
    );
  }
}

class _SmallSocialButton extends StatelessWidget {
  final FaIconData icon;
  final VoidCallback onTap;
  const _SmallSocialButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.14)),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Center(child: FaIcon(icon, size: 17, color: AppColors.text)),
      ),
    );
  }
}
