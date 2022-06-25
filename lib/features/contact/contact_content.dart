import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_website/features/contact/contact_me_item.dart';
import 'package:portfolio_website/features/works/services/contact_launcher_service.dart';

class ContactContent extends StatelessWidget {
  const ContactContent({
    Key? key,
    required this.isVisible,
  }) : super(key: key);

  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1500),
      child: Column(children: [
        ContactMeItem(
          handleTap: () {},
          title: "e-mail",
          description: "you can send an e-mail to devhudsoncontact@gmail.com",
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
      ]),
    );
  }
}
