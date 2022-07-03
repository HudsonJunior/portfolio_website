import 'package:flutter/material.dart';
import 'package:portfolio_website/features/about/presentation/widgets/about_me_text_mobile.dart';
import 'package:portfolio_website/features/about/presentation/widgets/mainly_skills_widget_mobile.dart';

class AboutMeTextsMobile extends StatelessWidget {
  const AboutMeTextsMobile({Key? key, required this.isVisible})
      : super(key: key);

  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeOut,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Expanded(
            child: AboutMeTextMobile(
              title: "history",
              text:
                  "I started in the programming world in 2018, when I joined the computer science undergraduate course. Since then, I've been falling more and more in love with what the computing world can solve. During graduation, I really liked content such as algorithm analysis, working with big O notations, algorithm complexity (P, NP, etc) and dynamic programming. I also had a great passion for working with graphs, working with several algorithms that solve important problems today. Currently, I work with mobile development, focusing on Flutter. I seek learning every day and I am always looking forward to what I can still discover in this fascinating world of computing.",
            ),
          ),
          SizedBox(height: 24.0),
          Expanded(
            child: AboutMeTextMobile(
              title: "experience",
              text:
                  "I've worked with web front-end (React, JS, CSS, HTML, C#) and back-end (NodeJS, FeathersJS).\nCurrently, I work as a senior Flutter developer at a large company in Santa Catarina, Brazil. As a developer, I like to create solutions with quality, performance and readability, always thinking about the scalability and maintainability of the applications. I'm always improving my knowledge with Flutter and mobile in general and every day I'm more excited about what I can add and learn from the community.",
            ),
          ),
          SizedBox(height: 32.0),
          Expanded(child: MainlySkillsWidgetMobile()),
        ],
      ),
    );
  }
}
