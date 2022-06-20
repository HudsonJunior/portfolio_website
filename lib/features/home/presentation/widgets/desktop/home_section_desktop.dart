import 'package:flutter/material.dart';
import 'package:portfolio_website/features/home/presentation/widgets/common/header/home_header.dart';
import 'package:portfolio_website/features/home/presentation/widgets/common/profile_picture.dart';

class HomeSectionDesktop extends StatefulWidget {
  const HomeSectionDesktop({Key? key}) : super(key: key);

  @override
  State<HomeSectionDesktop> createState() => _HomeSectionDesktopState();
}

class _HomeSectionDesktopState extends State<HomeSectionDesktop> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Expanded(
            flex: 3,
            child: HomeHeader(),
          ),
          SizedBox(width: 48),
          Expanded(
            child: ProfilePicture(),
          ),
        ],
      ),
    );
  }
}
