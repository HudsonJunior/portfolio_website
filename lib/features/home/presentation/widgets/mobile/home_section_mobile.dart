import 'package:flutter/material.dart';
import 'package:portfolio_website/features/home/presentation/widgets/common/header/home_header.dart';
import 'package:portfolio_website/features/home/presentation/widgets/common/profile_picture.dart';

class HomeSectionMobile extends StatefulWidget {
  const HomeSectionMobile({Key? key}) : super(key: key);

  @override
  State<HomeSectionMobile> createState() => _HomeSectionMobileState();
}

class _HomeSectionMobileState extends State<HomeSectionMobile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: const [
          Flexible(child: ProfilePicture()),
          SizedBox(height: 48.0),
          Flexible(child: HomeHeader(kIsMobile: true)),
        ],
      ),
    );
  }
}
