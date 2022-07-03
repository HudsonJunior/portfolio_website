import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_website/features/works/models/works_model.dart';
import 'package:portfolio_website/features/works/services/playstore_launcher_service.dart';
import 'package:portfolio_website/features/works/widgets/mobile/image_carousel_mobile.dart';
import 'package:portfolio_website/features/works/widgets/work_button.dart';

class WorksBottomButtonsMobile extends StatelessWidget {
  const WorksBottomButtonsMobile({
    Key? key,
    required this.work,
  }) : super(key: key);

  final WorksEnum work;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        WorkButton(
          icon: Icons.photo_library,
          label: "app gallery",
          handleTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return ImageCarouselMobile(
                  imagesPathsLength: work.appImagesLength,
                  work: work,
                );
              },
            );
          },
        ),
        const SizedBox(height: 24.0),
        if (work.playstoreId != null)
          WorkButton(
            icon: FontAwesomeIcons.googlePlay,
            label: "playstore",
            handleTap: () {
              PlayStoreLauncherService.openPlaystore(work.playstoreId!);
            },
          ),
      ],
    );
  }
}
