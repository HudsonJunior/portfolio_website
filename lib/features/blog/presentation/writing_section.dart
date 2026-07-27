import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_website/features/blog/domain/blog_post.dart';
import 'package:portfolio_website/features/core/presentation/widgets/reveal_on_scroll.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/theme.dart';

/// Landing-page Writing section — horizontal carousel of posts.
class WritingSection extends StatelessWidget {
  const WritingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isNarrow = width < 850;
    final horizontalPad = isNarrow ? 24.0 : 48.0;
    final carouselHeight = isNarrow ? 420.0 : 400.0;

    return Container(
      color: AppColors.surfaceAlt,
      width: double.infinity,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 100),
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
                          '// writing',
                          style: AppTextStyles.mono(
                            fontSize: 12.5,
                            color: AppColors.accentLight,
                            letterSpacing: 0.06 * 12.5,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Writing',
                          style: AppTextStyles.spaceGrotesk(
                            fontSize: 48,
                            fontWeight: FontWeight.w700,
                            letterSpacingEm: -0.025,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Notes on Flutter, agentic engineering, and shipping '
                          'with care. Tap a card to read.',
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
                if (kBlogPosts.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPad),
                    child: Text(
                      'Posts coming soon.',
                      style: AppTextStyles.manrope(
                        fontSize: 15,
                        color: AppColors.text.withValues(alpha: 0.5),
                      ),
                    ),
                  )
                else
                  RevealOnScroll(
                    child: CarouselSlider.builder(
                      itemCount: kBlogPosts.length,
                      options: CarouselOptions(
                        height: carouselHeight,
                        viewportFraction: isNarrow ? 0.9 : 0.72,
                        enlargeCenterPage: false,
                        enableInfiniteScroll: kBlogPosts.length > 1,
                        autoPlay: kBlogPosts.length > 1,
                        autoPlayInterval: const Duration(seconds: 6),
                        // Keep the first card flush with the section start
                        // (same inset as the heading above).
                        padEnds: false,
                      ),
                      itemBuilder: (context, index, realIndex) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: index == 0 ? horizontalPad : 8,
                            right: index == kBlogPosts.length - 1
                                ? horizontalPad
                                : 8,
                          ),
                          child: _WritingCarouselCard(post: kBlogPosts[index]),
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

class _WritingCarouselCard extends StatefulWidget {
  final BlogPost post;

  const _WritingCarouselCard({required this.post});

  @override
  State<_WritingCarouselCard> createState() => _WritingCarouselCardState();
}

class _WritingCarouselCardState extends State<_WritingCarouselCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go('/blog/${post.slug}'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered
                  ? AppColors.accent.withValues(alpha: 0.45)
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
                : [],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: Image.asset(
                  post.coverAsset,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.formattedDate,
                        style: AppTextStyles.mono(
                          fontSize: 11.5,
                          color: AppColors.accentLight,
                          letterSpacing: 0.04 * 11.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        post.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.spaceGrotesk(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacingEm: -0.02,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Text(
                          post.summary,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.manrope(
                            fontSize: 13.5,
                            color: AppColors.text.withValues(alpha: 0.55),
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Read',
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
                            Icons.arrow_forward_rounded,
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
    );
  }
}
