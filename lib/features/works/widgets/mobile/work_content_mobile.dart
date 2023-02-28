import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_website/features/works/models/used_techs_model.dart';
import 'package:portfolio_website/features/works/models/works_model.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/extensions.dart';

class WorkContentMobile extends StatelessWidget {
  const WorkContentMobile({
    Key? key,
    required this.work,
  }) : super(key: key);

  final WorksEnum work;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: CarouselSlider.builder(
        itemCount: work.usedTechs.length,
        itemBuilder: (context, index, _) {
          final tech = work.usedTechs[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            color: AppColors.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox.expand(
                child: Text(
                  tech.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:
                      context.themeData.displayMedium!.copyWith(fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
        options: CarouselOptions(
          viewportFraction: 0.5,
          height: 50,
        ),
      ),
    );
  }
}
