import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:web/web.dart' as web;

/// Triggers a browser download of the bundled CV PDF.
/// No-op on non-web platforms (shouldn't happen for this portfolio).
void downloadCV() {
  if (!kIsWeb) return;
  // cv.pdf is placed in web/ so it's served at the root URL in Flutter web.
  final anchor = web.document.createElement('a') as web.HTMLAnchorElement
    ..href = 'cv.pdf'
    ..download = 'Hudson Proença - CV.pdf'
    ..style.display = 'none';
  web.document.body!.append(anchor);
  anchor.click();
  anchor.remove();
}
