import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_website/features/works/models/works_model.dart';
import 'package:portfolio_website/features/works/services/contact_launcher_service.dart';
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: WorkButton(
            icon: Icons.photo_library,
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
        ),
        if (work.playstoreId != null) ...[
          const SizedBox(width: 8),
          Flexible(
            child: WorkButton(
              icon: FontAwesomeIcons.googlePlay,
              handleTap: () {
                PlayStoreLauncherService.openPlaystore(work.playstoreId!);
              },
            ),
          ),
        ],
        if (work.githubUrl != null) ...[
          const SizedBox(width: 8),
          Flexible(
            child: WorkButton(
              icon: FontAwesomeIcons.github,
              handleTap: () {
                UrlLauncherService.openGithubRepo(work.githubUrl!);
              },
            ),
          ),
        ]
      ],
    );
  }
}
