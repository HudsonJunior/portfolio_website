import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_website/features/contact/presentation/contact_me_item.dart';
import 'package:portfolio_website/features/works/services/contact_launcher_service.dart';

class ContactContent extends StatefulWidget {
  const ContactContent({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactContent> createState() => _ContactContentState();
}

class _ContactContentState extends State<ContactContent>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> emailAnimation;
  late final Animation<double> linkedinAnimation;
  late final Animation<double> gitHubAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    emailAnimation = Tween<double>(begin: -1, end: 0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0,
          0.33,
          curve: Curves.easeOutBack,
        ),
      ),
    );
    linkedinAnimation = Tween<double>(begin: -1, end: 0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          .33,
          .66,
          curve: Curves.easeOutBack,
        ),
      ),
    );
    gitHubAnimation = Tween<double>(begin: -1, end: 0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          .66,
          1,
          curve: Curves.easeOutBack,
        ),
      ),
    );

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: emailAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                emailAnimation.value * MediaQuery.of(context).size.width,
                0.0,
              ),
              child: child,
            );
          },
          child: ContactMeItem(
            handleTap: () {},
            title: "e-mail",
            description: "devhudsoncontact@gmail.com",
            icon: Icons.mail,
          ),
        ),
        const SizedBox(height: 12),
        AnimatedBuilder(
          animation: linkedinAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                  linkedinAnimation.value * MediaQuery.of(context).size.width,
                  0.0),
              child: child,
            );
          },
          child: ContactMeItem(
            handleTap: () {
              ContactLauncherService.openLinkedin();
            },
            title: "linkedin",
            description: "linkedin",
            icon: FontAwesomeIcons.linkedin,
          ),
        ),
        const SizedBox(height: 12),
        AnimatedBuilder(
          animation: gitHubAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                  gitHubAnimation.value * MediaQuery.of(context).size.width,
                  0.0),
              child: child,
            );
          },
          child: ContactMeItem(
            handleTap: () {
              ContactLauncherService.openGitHub();
            },
            title: "github",
            description: "github",
            icon: FontAwesomeIcons.github,
          ),
        ),
      ],
    );
  }
}
