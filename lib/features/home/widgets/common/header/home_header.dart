import 'package:flutter/material.dart';
import 'package:portfolio_website/features/home/widgets/common/header/home_header_contact.dart';
import 'package:portfolio_website/features/home/widgets/common/header/home_header_subtitle.dart';
import 'package:portfolio_website/features/home/widgets/common/header/home_header_title.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key, this.kIsMobile = false}) : super(key: key);

  final bool kIsMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(child: HomeHeaderTitle(kIsMobile: kIsMobile)),
        const SizedBox(height: 24.0),
        Flexible(child: HomeHeaderSubtitle(kIsMobile: kIsMobile)),
        const SizedBox(height: 48.0),
        const Flexible(child: HomeHeaderContact()),
        const SizedBox(height: 24.0),
      ],
    );
  }
}
