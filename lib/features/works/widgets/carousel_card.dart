import 'package:flutter/material.dart';
import 'package:portfolio_website/features/works/models/works_model.dart';
import 'package:portfolio_website/features/works/widgets/carousel_title.dart';
import 'package:portfolio_website/features/works/widgets/work_content.dart';
import 'package:portfolio_website/features/works/widgets/works_bottom_buttons.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/extensions.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({
    Key? key,
    required this.work,
  }) : super(key: key);

  final WorksEnum work;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: AppColors.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CarouselTitle(
              title: work.title,
              iconPath: work.icon,
            ),
            const SizedBox(height: 16.0),
            Expanded(
              flex: 3,
              child: LimitedBox(
                child: Text(
                  work.description,
                  style: context.themeData.headline3!.copyWith(
                    color: Colors.black.withOpacity(0.3),
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(child: WorkContent(work: work)),
            const SizedBox(height: 8.0),
            Expanded(child: WorksBottomButtons(work: work)),
          ],
        ),
      ),
    );
  }
}
