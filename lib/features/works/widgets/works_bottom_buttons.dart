import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_website/features/works/models/works_model.dart';
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
        Flexible(
          child: WorkButton(
            icon: Icons.photo_library,
            label: "app gallery",
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
        ),
        const SizedBox(width: 24.0),
        if (work.playstoreId != null)
          Flexible(
            child: WorkButton(
              icon: FontAwesomeIcons.googlePlay,
              label: "playstore",
              handleTap: () {
                PlayStoreLauncherService.openPlaystore(work.playstoreId!);
              },
            ),
          ),
      ],
    );
  }
}
