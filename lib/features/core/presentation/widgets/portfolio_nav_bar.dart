import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_website/features/core/models/app_bar_itens.dart';
import 'package:portfolio_website/features/core/presentation/cubits/control_page_cubit.dart';
import 'package:portfolio_website/features/core/presentation/widgets/app_bar_menu_item.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/theme.dart';

/// Frosted top nav shared by the landing page and blog routes.
class PortfolioNavBar extends StatelessWidget {
  /// When on `/`, scrolls to a section index. Null on blog routes.
  final void Function(int index)? onScrollTo;

  /// Scroll progress 0..1. Null hides the bar (blog routes).
  final ValueNotifier<double>? scrollFraction;

  /// Highlights the Writing nav item on blog routes.
  final bool writingSelected;

  const PortfolioNavBar({
    super.key,
    this.onScrollTo,
    this.scrollFraction,
    this.writingSelected = false,
  });

  void _goHomeSection(BuildContext context, String section) {
    if (onScrollTo != null) {
      final index = _sectionIndex(section);
      if (index != null) onScrollTo!(index);
      return;
    }
    context.go('/?section=$section');
  }

  static int? _sectionIndex(String section) {
    switch (section) {
      case 'home':
        return 0;
      case 'talks':
        return 1;
      case 'writing':
        return 2;
      case 'works':
        return 3;
      case 'experience':
        return 4;
      case 'about':
        return 5;
      case 'contact':
        return 6;
      default:
        return null;
    }
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
                          if (onScrollTo != null) {
                            onScrollTo!(0);
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
                      child: BlocBuilder<ControlPageCubit, AppBarItens>(
                        builder: (_, active) {
                          final scrollActive = writingSelected ? null : active;
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                NavTextItem(
                                  title: 'Home',
                                  isSelected: scrollActive == AppBarItens.home,
                                  onTap: () => _goHomeSection(context, 'home'),
                                ),
                                SizedBox(width: gap),
                                NavTextItem(
                                  title: 'Talks',
                                  isSelected: scrollActive == AppBarItens.talks,
                                  onTap: () => _goHomeSection(context, 'talks'),
                                ),
                                SizedBox(width: gap),
                                NavTextItem(
                                  title: 'Writing',
                                  isSelected: writingSelected ||
                                      scrollActive == AppBarItens.writing,
                                  onTap: () =>
                                      _goHomeSection(context, 'writing'),
                                ),
                                SizedBox(width: gap),
                                NavTextItem(
                                  title: 'Personal Projects',
                                  isSelected: scrollActive == AppBarItens.works,
                                  onTap: () => _goHomeSection(context, 'works'),
                                ),
                                SizedBox(width: gap),
                                NavTextItem(
                                  title: 'Experience',
                                  isSelected:
                                      scrollActive == AppBarItens.experience,
                                  onTap: () => _goHomeSection(
                                    context,
                                    'experience',
                                  ),
                                ),
                                SizedBox(width: gap),
                                NavTextItem(
                                  title: 'About',
                                  isSelected: scrollActive == AppBarItens.about,
                                  onTap: () => _goHomeSection(context, 'about'),
                                ),
                                SizedBox(width: gap),
                                NavContactButton(
                                  onTap: () =>
                                      _goHomeSection(context, 'contact'),
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
