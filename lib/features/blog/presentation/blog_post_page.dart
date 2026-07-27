import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_website/features/blog/domain/blog_post.dart';
import 'package:portfolio_website/features/core/presentation/widgets/portfolio_nav_bar.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogPostPage extends StatelessWidget {
  final String slug;

  const BlogPostPage({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    final post = blogPostBySlug(slug);

    if (post == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Post not found',
                    style: AppTextStyles.spaceGrotesk(fontSize: 28),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => context.go('/?section=writing'),
                    child: const Text('Back to Writing'),
                  ),
                ],
              ),
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

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          FutureBuilder<String>(
            future:
                DefaultAssetBundle.of(context).loadString(post.markdownAsset),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.accent),
                );
              }

              return ListView(
                padding: const EdgeInsets.only(top: 80, bottom: 80),
                children: [
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 720),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 40),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () => context.go('/?section=writing'),
                                child: Text(
                                  '← Writing',
                                  style: AppTextStyles.manrope(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.accentLight,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 28),
                            Text(
                              post.formattedDate,
                              style: AppTextStyles.mono(
                                fontSize: 12,
                                color: AppColors.accentLight,
                                letterSpacing: 0.04 * 12,
                              ),
                            ),
                            if (post.authors.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                post.authors.join(' · '),
                                style: AppTextStyles.manrope(
                                  fontSize: 14,
                                  color: AppColors.text.withValues(alpha: 0.5),
                                ),
                              ),
                            ],
                            const SizedBox(height: 14),
                            Text(
                              post.title,
                              style: AppTextStyles.spaceGrotesk(
                                fontSize: 36,
                                fontWeight: FontWeight.w700,
                                letterSpacingEm: -0.025,
                                height: 1.2,
                              ),
                            ),
                            if (post.tags.isNotEmpty) ...[
                              const SizedBox(height: 18),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  for (final tag in post.tags)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.accent
                                            .withValues(alpha: 0.1),
                                        borderRadius:
                                            BorderRadius.circular(999),
                                        border: Border.all(
                                          color: AppColors.accent
                                              .withValues(alpha: 0.25),
                                        ),
                                      ),
                                      child: Text(
                                        tag,
                                        style: AppTextStyles.mono(
                                          fontSize: 11,
                                          color: AppColors.accentLight,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                            const SizedBox(height: 28),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Image.asset(
                                  post.coverAsset,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 36),
                            MarkdownBody(
                              data: snapshot.data!,
                              selectable: true,
                              imageBuilder: (uri, _, alt) {
                                final path = uri.toString();
                                final isNetwork = path.startsWith('http://') ||
                                    path.startsWith('https://');
                                final image = isNetwork
                                    ? Image.network(
                                        path,
                                        fit: BoxFit.contain,
                                      )
                                    : Image.asset(
                                        path,
                                        fit: BoxFit.contain,
                                        errorBuilder: (_, _, _) => Text(
                                          alt ?? 'Image unavailable',
                                          style: AppTextStyles.manrope(
                                            fontSize: 13,
                                            color: AppColors.text
                                                .withValues(alpha: 0.45),
                                          ),
                                        ),
                                      );
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: image,
                                  ),
                                );
                              },
                              onTapLink: (text, href, title) async {
                                if (href == null) return;
                                final uri = Uri.parse(href);
                                if (await canLaunchUrl(uri)) {
                                  await launchUrl(
                                    uri,
                                    mode: LaunchMode.externalApplication,
                                  );
                                }
                              },
                              styleSheet: MarkdownStyleSheet(
                                p: AppTextStyles.manrope(
                                  fontSize: 16.5,
                                  color: AppColors.text.withValues(alpha: 0.78),
                                  height: 1.75,
                                ),
                                h1: AppTextStyles.spaceGrotesk(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  letterSpacingEm: -0.02,
                                  height: 1.3,
                                ),
                                h2: AppTextStyles.spaceGrotesk(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  letterSpacingEm: -0.02,
                                  height: 1.35,
                                ),
                                h3: AppTextStyles.spaceGrotesk(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  letterSpacingEm: -0.02,
                                ),
                                listBullet: AppTextStyles.manrope(
                                  fontSize: 16.5,
                                  color: AppColors.text.withValues(alpha: 0.78),
                                  height: 1.75,
                                ),
                                strong: AppTextStyles.manrope(
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.text,
                                  height: 1.75,
                                ),
                                a: AppTextStyles.manrope(
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.accentLight,
                                  height: 1.75,
                                ),
                                blockquote: AppTextStyles.manrope(
                                  fontSize: 16,
                                  color: AppColors.text.withValues(alpha: 0.65),
                                  height: 1.7,
                                ),
                                blockquoteDecoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      color: AppColors.accent
                                          .withValues(alpha: 0.5),
                                      width: 3,
                                    ),
                                  ),
                                ),
                                code: AppTextStyles.mono(
                                  fontSize: 13.5,
                                  color: AppColors.accentPurpleLight,
                                ),
                                codeblockDecoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.border),
                                ),
                                horizontalRuleDecoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: AppColors.borderMid,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
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
