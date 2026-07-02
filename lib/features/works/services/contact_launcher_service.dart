import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UrlLauncherService {
  static Future<void> openLinkedin() async {
    const appLink = "https://www.linkedin.com/in/hudson-p-46583011a/";

    try {
      if (await canLaunchUrlString(appLink)) {
        await launchUrlString(appLink);
      } else {
        await launchUrl(Uri.parse(appLink));
      }
    } on Exception {
      await launchUrl(Uri.parse(appLink));
    }
  }

  static Future<void> openGitHub() async {
    const appLink = "https://github.com/HudsonJunior";

    try {
      if (await canLaunchUrlString(appLink)) {
        await launchUrlString(appLink);
      } else {
        await launchUrl(Uri.parse(appLink));
      }
    } on Exception {
      await launchUrl(Uri.parse(appLink));
    }
  }

  static Future<void> openGithubRepo(String repo) async {
    try {
      if (await canLaunchUrlString(repo)) {
        await launchUrlString(repo);
      } else {
        await launchUrl(Uri.parse(repo));
      }
    } on Exception {
      await launchUrl(Uri.parse(repo));
    }
  }

  static Future<void> openEmail() async {
    const appLink = "mailto:devhudsoncontact@gmail.com";

    try {
      if (await canLaunchUrlString(appLink)) {
        await launchUrlString(appLink);
      } else {
        await launchUrl(Uri.parse(appLink));
      }
    } on Exception {
      await launchUrl(Uri.parse(appLink));
    }
  }
}
