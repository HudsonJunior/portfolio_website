import 'package:flutter/material.dart';
import 'package:portfolio_website/features/home/presentation/widgets/common/header/home_header_contact.dart';
import 'package:portfolio_website/features/home/presentation/widgets/common/header/home_header_desktop.dart';
import 'package:portfolio_website/features/home/presentation/widgets/common/profile_picture.dart';

class HomeSectionMobile extends StatefulWidget {
  const HomeSectionMobile({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeSectionMobile> createState() => _HomeSectionMobileState();
}

class _HomeSectionMobileState extends State<HomeSectionMobile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(height: 48.0),
            Expanded(child: ProfilePicture()),
            SizedBox(height: 24.0),
            Expanded(child: HomeHeader(kIsMobile: true)),
            Expanded(child: HomeHeaderContact(kIsMobile: true)),
          ],
        ),
      ),
    );
  }
}
