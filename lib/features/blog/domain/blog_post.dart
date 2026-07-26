class BlogPost {
  final String slug;
  final String title;
  final DateTime publishedAt;
  final String summary;
  final String coverAsset;
  final String markdownAsset;
  final List<String> tags;
  final List<String> authors;

  const BlogPost({
    required this.slug,
    required this.title,
    required this.publishedAt,
    required this.summary,
    required this.coverAsset,
    required this.markdownAsset,
    this.tags = const [],
    this.authors = const [],
  });

  String get formattedDate {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[publishedAt.month - 1]} ${publishedAt.day}, ${publishedAt.year}';
  }
}

/// Newest first. Add entries here when you publish a new markdown post.
final kBlogPosts = [
  BlogPost(
    slug: 'embed-flutter-components-web-app-multi-view-api',
    title: 'Embed Flutter Components in a Web App: Multi-View API Guide',
    publishedAt: DateTime(2026, 6, 16),
    summary:
        'A practical guide to Flutter\'s Multi-View Web API and dart:js_interop — '
        'embed components into existing web apps with bidirectional communication.',
    coverAsset:
        'assets/blog/embed-flutter-components-web-app-multi-view-api/main.png',
    markdownAsset:
        'assets/blog/embed-flutter-components-web-app-multi-view-api/'
        'embed-flutter-components-web-app-multi-view-api.md',
    tags: const ['Flutter', 'Flutter Web', 'Dart', 'Web Development'],
    authors: const ['Hudson Proenca', 'Karlo Verde'],
  ),
];

BlogPost? blogPostBySlug(String slug) {
  for (final post in kBlogPosts) {
    if (post.slug == slug) return post;
  }
  return null;
}
