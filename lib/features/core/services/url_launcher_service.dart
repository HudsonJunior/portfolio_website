import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UrlLauncherService {
  static Future<void> openLinkedin() async {
    await _openUrl('https://www.linkedin.com/in/hudson-p-46583011a/');
  }

  static Future<void> openGitHub() async {
    await _openUrl('https://github.com/HudsonJunior');
  }

  static Future<void> _openUrl(String url) async {
    try {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        await launchUrl(Uri.parse(url));
      }
    } on Exception {
      await launchUrl(Uri.parse(url));
    }
  }
}
