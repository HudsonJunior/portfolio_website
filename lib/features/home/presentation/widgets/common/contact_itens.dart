import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_website/features/home/presentation/widgets/common/contact_item.dart';
import 'package:portfolio_website/features/works/services/contact_launcher_service.dart';
import 'package:portfolio_website/resources/extensions.dart';

class ContactItens extends StatelessWidget {
  const ContactItens({
    Key? key,
    required this.kIsMobile,
  }) : super(key: key);
  final bool kIsMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          kIsMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "you can find me on",
          style: context.themeData.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Flexible(
          child: Row(
            mainAxisAlignment:
                kIsMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              ContactItem(
                icon: FontAwesomeIcons.linkedin,
                itemName: "linkedin",
                handleTap: () {
                  UrlLauncherService.openLinkedin();
                },
              ),
              const SizedBox(width: 12.0),
              ContactItem(
                icon: FontAwesomeIcons.github,
                itemName: "github",
                handleTap: () {
                  UrlLauncherService.openGitHub();
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
