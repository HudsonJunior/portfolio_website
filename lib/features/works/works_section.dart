import 'package:flutter/material.dart';
import 'package:portfolio_website/features/core/presentation/widgets/section_header.dart';
import 'package:portfolio_website/features/works/widgets/works_carousel.dart';
import 'package:portfolio_website/resources/extensions.dart';
import 'package:visibility_detector/visibility_detector.dart';

class WorksSection extends StatefulWidget {
  const WorksSection({Key? key}) : super(key: key);

  @override
  State<WorksSection> createState() => _WorksSectionState();
}

class _WorksSectionState extends State<WorksSection>
    with AutomaticKeepAliveClientMixin {
  bool isVisible = false;

  void toggleVisibility() {
    setState(() {
      isVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: VisibilityDetector(
        key: const Key("works_section"),
        onVisibilityChanged: (info) {
          if (info.isVisible() && !isVisible) {
            toggleVisibility();
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: SectionHeader(
                isVisible: isVisible,
                headerTitle: "works",
              ),
            ),
            const SizedBox(height: 32.0),
            const Expanded(
              flex: 4,
              child: Center(child: WorksCarousel()),
            ),
            const SizedBox(height: 32.0),
            Flexible(
              child: Text(
                "Besides these apps I have also developed many projects in software house companies and as a freelancer developer.",
                style: context.themeData.headline3!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
