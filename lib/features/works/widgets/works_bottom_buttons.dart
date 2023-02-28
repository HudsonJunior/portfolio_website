import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_website/features/works/models/works_model.dart';
import 'package:portfolio_website/features/works/services/contact_launcher_service.dart';
import 'package:portfolio_website/features/works/services/playstore_launcher_service.dart';
import 'package:portfolio_website/features/works/widgets/image_carousel.dart';
import 'package:portfolio_website/features/works/widgets/work_button.dart';

class WorksBottomButtons extends StatelessWidget {
  const WorksBottomButtons({
    Key? key,
    required this.work,
  }) : super(key: key);

  final WorksEnum work;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (work.appImagesLength > 0)
          Flexible(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth * 0.6,
                  child: WorkButton(
                    icon: Icons.photo_library,
                    handleTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                            child: ImageCarousel(
                              imagesPathsLength: work.appImagesLength,
                              work: work,
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        if (work.playstoreId != null) ...[
          const SizedBox(width: 12),
          Flexible(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth * 0.6,
                  child: WorkButton(
                    icon: FontAwesomeIcons.googlePlay,
                    handleTap: () {
                      PlayStoreLauncherService.openPlaystore(work.playstoreId!);
                    },
                  ),
                );
              },
            ),
          ),
        ],
        if (work.githubUrl != null) ...[
          const SizedBox(width: 12),
          Flexible(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth * 0.6,
                  child: WorkButton(
                    icon: FontAwesomeIcons.github,
                    handleTap: () {
                      UrlLauncherService.openGithubRepo(work.githubUrl!);
                    },
                  ),
                );
              },
            ),
          ),
        ]
      ],
    );
  }
}
