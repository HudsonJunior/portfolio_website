import 'package:flutter/material.dart';
import 'package:portfolio_website/features/contact/contact_content.dart';
import 'package:portfolio_website/features/core/presentation/widgets/section_header.dart';
import 'package:portfolio_website/resources/extensions.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection>
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
      child: VisibilityDetector(
        key: const Key("contact_section"),
        onVisibilityChanged: (info) {
          if (info.isVisible() && !isVisible) {
            toggleVisibility();
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SectionHeader(
                isVisible: isVisible,
                headerTitle: "contact me",
              ),
            ),
            const SizedBox(height: 32.0),
            ContactContent(isVisible: isVisible),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
