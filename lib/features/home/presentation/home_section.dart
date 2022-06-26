import 'package:flutter/material.dart';
import 'package:portfolio_website/features/home/presentation/widgets/desktop/home_section_desktop.dart';
import 'package:portfolio_website/features/home/presentation/widgets/mobile/home_section_mobile.dart';
import 'package:portfolio_website/resources/constraints.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({Key? key}) : super(key: key);

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        if (AppConstraints.isMobile(constraints.maxWidth)) {
          return const HomeSectionMobile();
        } else {
          return const HomeSectionDesktop();
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
