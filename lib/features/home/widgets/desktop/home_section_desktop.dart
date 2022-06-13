import 'package:flutter/material.dart';
import 'package:portfolio_website/features/home/widgets/common/header/home_header.dart';
import 'package:portfolio_website/features/home/widgets/common/profile_picture.dart';

class HomeSectionDesktop extends StatefulWidget {
  const HomeSectionDesktop({Key? key}) : super(key: key);

  @override
  State<HomeSectionDesktop> createState() => _HomeSectionDesktopState();
}

class _HomeSectionDesktopState extends State<HomeSectionDesktop> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: const [
        Flexible(child: HomeHeader()),
        SizedBox(width: 48.0),
        Flexible(child: ProfilePicture()),
      ],
    );
  }
}
