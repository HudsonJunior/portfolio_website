import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactLauncherService {
  static Future<void> openLinkedin() async {
    const appLink = "https://www.linkedin.com/in/hudson-p-46583011a/";

    try {
      if (await canLaunchUrlString(appLink)) {
        launchUrlString(appLink);
      } else {
        launchUrl(Uri.parse(appLink));
      }
    } on Exception {
      launchUrl(Uri.parse(appLink));
    }
  }

  static Future<void> openGitHub() async {
    const appLink = "https://github.com/HudsonJunior";

    try {
      if (await canLaunchUrlString(appLink)) {
        launchUrlString(appLink);
      } else {
        launchUrl(Uri.parse(appLink));
      }
    } on Exception {
      launchUrl(Uri.parse(appLink));
    }
  }

  static Future<void> openEmail() async {
    const appLink = "mailto:devhudsoncontact@gmail.com";

    try {
      if (await canLaunchUrlString(appLink)) {
        launchUrlString(appLink);
      } else {
        launchUrl(Uri.parse(appLink));
      }
    } on Exception {
      launchUrl(Uri.parse(appLink));
    }
  }
}
