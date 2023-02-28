import 'package:auto_size_text/auto_size_text.dart';
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
    required this.autoSizeGroup,
  }) : super(key: key);

  final WorksEnum work;
  final AutoSizeGroup autoSizeGroup;

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
            AutoSizeText(
              work.description,
              style: context.themeData.displaySmall!.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
              ),
              maxLines: 12,
              group: autoSizeGroup,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16.0),
            Expanded(child: WorkContent(work: work)),
            const Spacer(),
            Expanded(child: WorksBottomButtons(work: work)),
          ],
        ),
      ),
    );
  }
}
