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
                flex: 3,
                child: AboutMeTextMobile(
                  title: "experience",
                  text:
                      "I have worked on many projects with different contexts, from small MVP applications to complex large-scale applications. I love to participate in important technical decisions, deciding what is the best solution to the problems I face in my day-to-day work.\n\nMy main focus is with the Flutter framework, since when I started learning it in the earliest of 2019. As a Flutter Engineer, I like to create solutions with quality, performance and readability, always thinking about the scalability and maintainability of the applications. I'm always improving my knowledge with Flutter and mobile in general and every day I'm more excited about what I can add and learn from the community.",
                ),
              ),
              SizedBox(height: 32.0),
              Flexible(child: MainlySkillsWidgetMobile()),
            ],
          ),
        );
      },
    );
  }
}
