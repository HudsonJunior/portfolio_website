import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_website/features/about/presentation/about_section.dart';
import 'package:portfolio_website/features/contact/presentation/contact_section.dart';
import 'package:portfolio_website/features/core/models/app_bar_itens.dart';
import 'package:portfolio_website/features/core/presentation/cubits/control_page_cubit.dart';
import 'package:portfolio_website/features/core/presentation/widgets/app_bar_menu_item.dart';
import 'package:portfolio_website/features/core/presentation/widgets/reveal_on_scroll.dart';
import 'package:portfolio_website/features/experience/presentation/experience_section.dart';
import 'package:portfolio_website/features/home/presentation/home_section.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/theme.dart';

class CorePage extends StatefulWidget {
  const CorePage({super.key});

  @override
  State<CorePage> createState() => _CorePageState();
}

class _CorePageState extends State<CorePage> {
  late final ControlPageCubit _cubit;
  late final ScrollController _scrollController;

  // One GlobalKey per section for scroll-to
  final _keys = List.generate(4, (_) => GlobalKey());

  // Scroll position in raw pixels — fed into PortfolioScroll for RevealOnScroll widgets
  final _scrollPos = ValueNotifier<double>(0);

  // Normalized 0..1 scroll fraction — drives the nav progress bar
  final _scrollFraction = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<ControlPageCubit>(context);
    _scrollController = ScrollController()
      ..addListener(() {
        if (!_scrollController.hasClients) return;
        final pos = _scrollController.position.pixels;
        final max = _scrollController.position.maxScrollExtent;

        _scrollPos.value = pos;
        _scrollFraction.value = max > 0 ? (pos / max).clamp(0.0, 1.0) : 0.0;

        _updateActiveSection();
      });
  }

  @override
  void dispose() {
    _scrollPos.dispose();
    _scrollFraction.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Approximate height of the frosted nav bar (row + 2px progress bar)
  static const _kNavHeight = 62.0;

  void _goTo(int index) {
    if (!_scrollController.hasClients) return;
    final ctx = _keys[index].currentContext;
    if (ctx == null) return;
    final ro = ctx.findRenderObject() as RenderBox?;
    if (ro == null) return;

    // localToGlobal gives the section's top edge in viewport (screen) space.
    // Adding the current scroll offset converts it to document space.
    final dy = ro.localToGlobal(Offset.zero).dy;
    final target = (_scrollController.offset + dy - _kNavHeight)
        .clamp(0.0, _scrollController.position.maxScrollExtent);

    _scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  /// Determines which section is active by reading actual widget positions.
  /// Picks the last section whose top edge is above 40% of the screen height.
  void _updateActiveSection() {
    final threshold = MediaQuery.of(context).size.height * 0.40;
    for (int i = _keys.length - 1; i >= 0; i--) {
      final ctx = _keys[i].currentContext;
      if (ctx == null) continue;
      final ro = ctx.findRenderObject() as RenderBox?;
      if (ro == null) continue;
      final dy = ro.localToGlobal(Offset.zero).dy;
      if (dy <= threshold) {
        _cubit.setSection(i);
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final sections = [
      HomeSection(onScrollToExperience: () => _goTo(1)),
      const ExperienceSection(),
      const AboutSection(),
      const ContactSection(),
    ];

    return PortfolioScroll(
      scrollPos: _scrollPos,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            // ── Scrollable content ───────────────────────────────
            // SingleChildScrollView keeps all 4 sections in the widget tree
            // at all times, so GlobalKey lookups always succeed.
            SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(
                  sections.length,
                  (i) => KeyedSubtree(key: _keys[i], child: sections[i]),
                ),
              ),
            ),

            // ── Frosted-glass nav overlay ────────────────────────
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _PortfolioNav(
                cubit: _cubit,
                onTap: _goTo,
                scrollFraction: _scrollFraction,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Frosted-glass nav ─────────────────────────────────────────────────────────

class _PortfolioNav extends StatelessWidget {
  final ControlPageCubit cubit;
  final void Function(int index) onTap;
  final ValueNotifier<double> scrollFraction;

  const _PortfolioNav({
    required this.cubit,
    required this.onTap,
    required this.scrollFraction,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          color: AppColors.background.withValues(alpha: 0.72),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Nav row ────────────────────────────────────────
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 48, vertical: 17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => onTap(0),
                        child: RichText(
                          text: TextSpan(
                            style: AppTextStyles.spaceGrotesk(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.text,
                              letterSpacingEm: -0.02,
                            ),
                            children: const [
                              TextSpan(text: 'hudson'),
                              TextSpan(
                                text: '.',
                                style: TextStyle(color: AppColors.accent),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Links
                    BlocBuilder<ControlPageCubit, AppBarItens>(
                      bloc: cubit,
                      builder: (_, active) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NavTextItem(
                            title: 'Home',
                            isSelected: active == AppBarItens.home,
                            onTap: () => onTap(0),
                          ),
                          const SizedBox(width: 32),
                          NavTextItem(
                            title: 'Experience',
                            isSelected: active == AppBarItens.experience,
                            onTap: () => onTap(1),
                          ),
                          const SizedBox(width: 32),
                          NavTextItem(
                            title: 'About',
                            isSelected: active == AppBarItens.about,
                            onTap: () => onTap(2),
                          ),
                          const SizedBox(width: 32),
                          NavContactButton(onTap: () => onTap(3)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ── Scroll progress bar ────────────────────────────
              ValueListenableBuilder<double>(
                valueListenable: scrollFraction,
                builder: (_, frac, __) => _NavProgressBar(fraction: frac),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Scroll progress bar ───────────────────────────────────────────────────────

class _NavProgressBar extends StatelessWidget {
  final double fraction;
  const _NavProgressBar({required this.fraction});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 2,
      width: double.infinity,
      child: Stack(
        children: [
          // Track (faint background line)
          Container(color: Colors.white.withValues(alpha: 0.06)),
          // Filled portion
          FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: fraction.clamp(0.0, 1.0),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF6366F1),
                    Color(0xFF8B5CF6),
                    Color(0xFF22D3EE),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
