import 'package:go_router/go_router.dart';
import 'package:portfolio_website/features/blog/presentation/blog_index_page.dart';
import 'package:portfolio_website/features/blog/presentation/blog_post_page.dart';
import 'package:portfolio_website/features/core/presentation/pages/core_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        final section = state.uri.queryParameters['section'];
        return CorePage(initialSection: section);
      },
    ),
    GoRoute(
      path: '/blog',
      builder: (context, state) => const BlogIndexPage(),
      routes: [
        GoRoute(
          path: ':slug',
          builder: (context, state) {
            final slug = state.pathParameters['slug'] ?? '';
            return BlogPostPage(slug: slug);
          },
        ),
      ],
    ),
  ],
);
