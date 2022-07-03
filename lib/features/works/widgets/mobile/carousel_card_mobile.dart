import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_website/features/works/models/works_model.dart';
import 'package:portfolio_website/features/works/widgets/mobile/carousel_title_mobile.dart';
import 'package:portfolio_website/features/works/widgets/mobile/work_content_mobile.dart';
import 'package:portfolio_website/features/works/widgets/mobile/works_bottom_buttons_mobile.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/extensions.dart';

class CarouselCardMobile extends StatelessWidget {
  const CarouselCardMobile({
    Key? key,
    required this.work,
    required this.autoSizeGroup,
  }) : super(key: key);

  final WorksEnum work;
  final AutoSizeGroup autoSizeGroup;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: AppColors.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: CarouselTitleMobile(
                title: work.title,
                iconPath: work.icon,
              ),
            ),
            const SizedBox(height: 16.0),
            AutoSizeText(
              work.description,
              maxLines: 5,
              style: context.themeData.headline2!.copyWith(
                color: Colors.black.withOpacity(0.3),
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              group: autoSizeGroup,
              minFontSize: 10,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32.0),
            Text(
              'Some tools I used',
              style: context.themeData.headline2!.copyWith(fontSize: 12),
            ),
            const SizedBox(height: 16.0),
            WorkContentMobile(work: work),
            const SizedBox(height: 8.0),
            Expanded(
              child: Center(child: WorksBottomButtonsMobile(work: work)),
            ),
          ],
        ),
      ),
    );
  }
}
