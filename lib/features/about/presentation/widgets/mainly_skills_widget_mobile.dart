import 'package:flutter/material.dart';
import 'package:portfolio_website/features/about/domain/mainly_skills.dart';
import 'package:portfolio_website/features/core/presentation/widgets/shader_mask_list.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/extensions.dart';

class MainlySkillsWidgetMobile extends StatelessWidget {
  const MainlySkillsWidgetMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "my mainly skills",
            style: context.themeData.headline3,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 8),
          Flexible(
            child: ShaderMaskList(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: MainlySkills.values.length,
                itemBuilder: (context, index) => Align(
                  alignment: Alignment.topCenter,
                  child: Card(
                    color: AppColors.backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 1.0,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        MainlySkills.values[index].name,
                        style: context.themeData.headline2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
