import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_website/features/about/presentation/about_cubit.dart';
import 'package:portfolio_website/features/about/presentation/widgets/about_me_text_mobile.dart';
import 'package:portfolio_website/features/about/presentation/widgets/mainly_skills_widget_mobile.dart';

class AboutMeTextsMobile extends StatelessWidget {
  const AboutMeTextsMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutCubit, bool>(
      builder: (context, isVisible) {
        return AnimatedSlide(
          duration: const Duration(milliseconds: 1000),
          offset: isVisible ? const Offset(0, 0) : const Offset(2, 0),
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
                      "I have worked on many projects with different contexts, from small MVP applications to complex large-scale applications. I love to participate in important technical decisions, deciding what is the best solution to the problems I face in my day-to-day work.\n\nCurrently, I work as a Senior Flutter Developer in one of the largest banking apps in Brazil. As an engineer, I like to create solutions with quality, performance and readability, always thinking about the scalability and maintainability of the applications. I'm always improving my knowledge with Flutter and mobile in general and every day I'm more excited about what I can add and learn from the community.",
                ),
              ),
              SizedBox(height: 32.0),
              Expanded(child: MainlySkillsWidgetMobile()),
            ],
          ),
        );
      },
    );
  }
}
