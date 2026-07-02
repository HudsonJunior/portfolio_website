import 'package:flutter/foundation.dart' show kIsWeb;

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

/// Triggers a browser download of the bundled CV PDF.
/// No-op on non-web platforms (shouldn't happen for this portfolio).
void downloadCV() {
  if (!kIsWeb) return;
  // cv.pdf is placed in web/ so it's served at the root URL in Flutter web.
  final anchor = html.AnchorElement(href: 'cv.pdf')
    ..setAttribute('download', 'Hudson Proença - CV.pdf')
    ..style.display = 'none';
  html.document.body!.append(anchor);
  anchor.click();
  anchor.remove();
}
