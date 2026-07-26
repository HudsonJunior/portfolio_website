import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_website/features/blog/domain/blog_post.dart';
import 'package:portfolio_website/features/core/presentation/widgets/portfolio_nav_bar.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/constraints.dart';
import 'package:portfolio_website/resources/theme.dart';

class BlogIndexPage extends StatelessWidget {
  const BlogIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(top: 80),
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 64,
                    ),
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
                          'with care.',
                          style: AppTextStyles.manrope(
                            fontSize: 16,
                            color: AppColors.text.withValues(alpha: 0.6),
                            height: 1.65,
                          ),
                        ),
                        const SizedBox(height: 48),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final isMobile = AppConstraints.isMobile(
                              constraints.maxWidth + 96,
                            );
                            if (isMobile) {
                              return Column(
                                children: [
                                  for (var i = 0;
                                      i < kBlogPosts.length;
                                      i++) ...[
                                    if (i > 0) const SizedBox(height: 24),
                                    _BlogPostCard(post: kBlogPosts[i]),
                                  ],
                                ],
                              );
                            }
                            return Wrap(
                              spacing: 24,
                              runSpacing: 24,
                              children: [
                                for (final post in kBlogPosts)
                                  SizedBox(
                                    width: (constraints.maxWidth - 24) / 2,
                                    child: _BlogPostCard(post: post),
                                  ),
                              ],
                            );
                          },
                        ),
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
            child: PortfolioNavBar(writingSelected: true),
          ),
        ],
      ),
    );
  }
}

class _BlogPostCard extends StatefulWidget {
  final BlogPost post;

  const _BlogPostCard({required this.post});

  @override
  State<_BlogPostCard> createState() => _BlogPostCardState();
}

class _BlogPostCardState extends State<_BlogPostCard> {
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
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(post.coverAsset, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(22),
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
                    const SizedBox(height: 10),
                    Text(
                      post.title,
                      style: AppTextStyles.spaceGrotesk(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacingEm: -0.02,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      post.summary,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.manrope(
                        fontSize: 14,
                        color: AppColors.text.withValues(alpha: 0.55),
                        height: 1.55,
                      ),
                    ),
                    const SizedBox(height: 16),
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
            ],
          ),
        ),
      ),
    );
  }
}
