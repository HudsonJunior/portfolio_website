import 'package:flutter/material.dart';
import 'package:portfolio_website/features/works/models/used_techs_model.dart';
import 'package:portfolio_website/features/works/models/works_model.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/extensions.dart';

class WorkContent extends StatelessWidget {
  const WorkContent({
    Key? key,
    required this.work,
  }) : super(key: key);

  final WorksEnum work;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        children: work.usedTechs
            .map(
              (tech) => Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                color: AppColors.backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    tech.title,
                    style: context.themeData.headline2,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
