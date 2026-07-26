enum TalkFormat { session, workshop, keynote, panel }

extension TalkFormatExt on TalkFormat {
  String get label {
    switch (this) {
      case TalkFormat.session:
        return 'Session';
      case TalkFormat.workshop:
        return 'Workshop';
      case TalkFormat.keynote:
        return 'Keynote';
      case TalkFormat.panel:
        return 'Panel';
    }
  }
}

class TalkModel {
  final String title;
  final String event;
  final String date;
  final String location;
  final TalkFormat format;
  final String abstract;
  final String imageAsset;
  final String talkUrl;
  final String? slidesUrl;

  const TalkModel({
    required this.title,
    required this.event,
    required this.date,
    required this.location,
    required this.format,
    required this.abstract,
    required this.imageAsset,
    required this.talkUrl,
    this.slidesUrl,
  });
}

/// Newest first.
const kTalks = [
  TalkModel(
    title: 'Bridging Ecosystems: Embedding Flutter Components in a Web App',
    event: 'FlutterCon USA',
    date: 'Jul 2026',
    location: 'Orlando, FL',
    format: TalkFormat.session,
    abstract:
        'A practical guide to Flutter\'s Multi-View Web API — embedding multiple '
        'independent Flutter components into an existing host web app, sharing one '
        'codebase across mobile and web, and using Dart JS Interop for type-safe, '
        'two-way communication with the host. Co-presented with Karlo Verde.',
    imageAsset: 'assets/talks/fluttercon-usa-2026.png',
    talkUrl: 'https://flutterconusa.dev/',
    slidesUrl: null,
  ),
];
