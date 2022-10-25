import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_website/features/about/presentation/about_cubit.dart';
import 'package:portfolio_website/features/about/presentation/widgets/about_me_text.dart';
import 'package:portfolio_website/features/about/presentation/widgets/mainly_skills_widget.dart';

class AboutMeTexts extends StatelessWidget {
  const AboutMeTexts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutCubit, bool>(
      builder: (context, isVisible) {
        return AnimatedSlide(
          duration: const Duration(milliseconds: 1000),
          offset: isVisible ? const Offset(0, 0) : const Offset(2, 0),
          curve: Curves.easeOut,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Expanded(
                      child: AboutMeText(
                        title: "history",
                        text:
                            "I started in the programming world in 2018, when I joined the computer science undergraduate course. Since then, I've been falling more and more in love with what the computing world can solve. During graduation, I really liked content such as algorithm analysis, working with big O notations, algorithm complexity (P, NP, etc) and dynamic programming. I also had a great passion for working with graphs, working with several algorithms that solve important problems today. Currently, I work with mobile development, focusing on Flutter. I seek learning every day and I am always looking forward to what I can still discover in this fascinating world of computing.",
                      ),
                    ),
                    SizedBox(width: 100.0),
                    Expanded(
                      child: AboutMeText(
                        title: "experience",
                        text:
                            "I've worked with web front-end (React, JS, CSS, HTML, C#) and back-end (NodeJS, FeathersJS).\nCurrently, I work as a Senior Flutter Engineer at a large company in Santa Catarina, Brazil. As an engineer, I like to create solutions with quality, performance and readability, always thinking about the scalability and maintainability of the applications. I'm always improving my knowledge with Flutter and mobile in general and every day I'm more excited about what I can add and learn from the community.",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),
              const Expanded(child: MainlySkillsWidget()),
            ],
          ),
        );
      },
    );
  }
}
