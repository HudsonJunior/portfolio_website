import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_website/features/core/models/portfolio_section.dart';
import 'package:portfolio_website/features/core/presentation/cubits/control_page_cubit.dart';
import 'package:portfolio_website/features/core/presentation/widgets/app_bar_menu_item.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/theme.dart';

/// Frosted top nav shared by the landing page and standalone feature routes.
class PortfolioNavBar extends StatelessWidget {
  /// Scrolls within the landing page. Null on standalone routes.
  final ValueChanged<PortfolioSection>? onSectionSelected;

  /// Scroll progress 0..1. Null hides the bar (blog routes).
  final ValueNotifier<double>? scrollFraction;

  /// Explicit selection for standalone routes such as blog posts or labs.
  final PortfolioSection? selectedSection;

  const PortfolioNavBar({
    super.key,
    this.onSectionSelected,
    this.scrollFraction,
    this.selectedSection,
  });

  void _goToSection(BuildContext context, PortfolioSection section) {
    if (onSectionSelected != null) {
      onSectionSelected!(section);
      return;
    }
    context.go('/?section=${section.slug}');
  }

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.sizeOf(context).width < 960;
    final gap = isNarrow ? 16.0 : 24.0;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          color: AppColors.background.withValues(alpha: 0.72),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isNarrow ? 16 : 40,
                  vertical: 17,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          if (onSectionSelected != null) {
                            onSectionSelected!(PortfolioSection.home);
                          } else {
                            context.go('/');
                          }
                        },
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
                    Flexible(
                      child: BlocBuilder<ControlPageCubit, PortfolioSection>(
                        builder: (_, active) {
                          final activeSection = selectedSection ?? active;
                          final textSections = PortfolioSection.values.where(
                            (section) => section != PortfolioSection.contact,
                          );
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                for (final section in textSections) ...[
                                  NavTextItem(
                                    title: section.label,
                                    isSelected: activeSection == section,
                                    onTap: () => _goToSection(context, section),
                                  ),
                                  SizedBox(width: gap),
                                ],
                                NavContactButton(
                                  onTap: () => _goToSection(
                                    context,
                                    PortfolioSection.contact,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (scrollFraction != null)
                ValueListenableBuilder<double>(
                  valueListenable: scrollFraction!,
                  builder: (_, frac, _) => _NavProgressBar(fraction: frac),
                )
              else
                const SizedBox(
                  height: 2,
                  child: ColoredBox(color: Color(0x0FFFFFFF)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

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
          Container(color: Colors.white.withValues(alpha: 0.06)),
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
