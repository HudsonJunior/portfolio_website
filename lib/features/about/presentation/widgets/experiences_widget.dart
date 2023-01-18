import 'package:flutter/material.dart';
import 'package:portfolio_website/resources/extensions.dart';

class ExperiencesWidget extends StatelessWidget {
  const ExperiencesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flutter Engineer at CourseKey',
          style: context.themeData.headline2,
        ),
        Text(
          'October 2022 - Present',
          style: context.themeData.bodyText1,
        ),
        const SizedBox(height: 24),
        Text(
          'Flutter Engineer at Ailos',
          style: context.themeData.headline2,
        ),
        Text(
          'June 2022 - October 2022',
          style: context.themeData.bodyText1,
        ),
        const SizedBox(height: 24),
        Text(
          'Flutter Engineer at EurekaLabs',
          style: context.themeData.headline2,
        ),
        Text(
          'January 2020 - June 2022',
          style: context.themeData.bodyText1,
        ),
        const SizedBox(height: 24),
        Text(
          'Mobile Engineer at InovaClick',
          style: context.themeData.headline2,
        ),
        Text(
          'January 2019 - December 2019',
          style: context.themeData.bodyText1,
        ),
      ],
    );
  }
}
