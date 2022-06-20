import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_website/features/contact/contact_me_item.dart';
import 'package:portfolio_website/features/core/presentation/widgets/section_header.dart';
import 'package:portfolio_website/features/works/services/contact_launcher_service.dart';
import 'package:portfolio_website/resources/extensions.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection>
    with AutomaticKeepAliveClientMixin {
  bool isVisible = false;

  void toggleVisibility() {
    setState(() {
      isVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: VisibilityDetector(
        key: const Key("contact_section"),
        onVisibilityChanged: (info) {
          if (info.isVisible() && !isVisible) {
            toggleVisibility();
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SectionHeader(
                isVisible: isVisible,
                headerTitle: "contact me",
              ),
            ),
            const SizedBox(height: 32.0),
            ContactMeItem(
              handleTap: () {},
              title: "e-mail",
              description:
                  "you can send an e-mail to devhudsoncontact@gmail.com",
              icon: Icons.mail,
            ),
            ContactMeItem(
              handleTap: () {
                ContactLauncherService.openLinkedin();
              },
              title: "linkedin",
              description: "you can send a message on linkedin Hudson Júnior",
              icon: FontAwesomeIcons.linkedin,
            ),
            ContactMeItem(
              handleTap: () {
                ContactLauncherService.openGitHub();
              },
              title: "github",
              description: "or you can follow my on github HudsonJunior",
              icon: FontAwesomeIcons.github,
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
