import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_website/features/home/presentation/widgets/common/contact_item.dart';
import 'package:portfolio_website/features/works/services/contact_launcher_service.dart';
import 'package:portfolio_website/resources/extensions.dart';

class ContactItens extends StatefulWidget {
  const ContactItens({Key? key}) : super(key: key);

  @override
  State<ContactItens> createState() => _ContactItensState();
}

class _ContactItensState extends State<ContactItens> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "you can find me on",
          style: context.themeData.bodyText1!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            ContactItem(
              icon: FontAwesomeIcons.linkedin,
              itemName: "linkedin",
              handleTap: () {
                ContactLauncherService.openLinkedin();
              },
            ),
            const SizedBox(width: 12.0),
            ContactItem(
              icon: FontAwesomeIcons.github,
              itemName: "github",
              handleTap: () {
                ContactLauncherService.openGitHub();
              },
            )
          ],
        ),
      ],
    );
  }
}
