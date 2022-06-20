import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PlayStoreLauncherService {
  static Future<void> openPlaystore(String appId) async {
    final appLink = "market://details?id=$appId";
    final appLinkWeb = "https://play.google.com/store/apps/details?id=$appId";

    try {
      if (await canLaunchUrlString(appLink)) {
        launchUrlString(appLink);
      } else {
        launchUrl(Uri.parse(appLinkWeb));
      }
    } on Exception {
      launchUrl(Uri.parse(appLinkWeb));
    }
  }
}
