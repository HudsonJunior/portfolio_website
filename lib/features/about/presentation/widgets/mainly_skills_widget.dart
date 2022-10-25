import 'package:flutter/material.dart';
import 'package:portfolio_website/features/about/domain/mainly_skills.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/extensions.dart';

class MainlySkillsWidget extends StatelessWidget {
  const MainlySkillsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "my mainly skills",
            style: context.themeData.headline3!.copyWith(
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 12.0),
          Expanded(
            child: Wrap(
              runSpacing: 8.0,
              spacing: 4.0,
              children: MainlySkills.values
                  .map(
                    (skill) => Card(
                      color: AppColors.backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                      ),
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          skill.name,
                          style: context.themeData.headline2,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
