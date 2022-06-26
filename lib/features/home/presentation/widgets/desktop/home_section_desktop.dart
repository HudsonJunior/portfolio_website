import 'package:flutter/material.dart';
import 'package:portfolio_website/features/home/presentation/widgets/common/header/home_header_contact.dart';
import 'package:portfolio_website/features/home/presentation/widgets/common/header/home_header_desktop.dart';
import 'package:portfolio_website/features/home/presentation/widgets/common/profile_picture.dart';

class HomeSectionDesktop extends StatelessWidget {
  const HomeSectionDesktop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Expanded(flex: 3, child: HomeHeader(kIsMobile: false)),
                SizedBox(width: 48),
                Expanded(
                  flex: 2,
                  child: ProfilePicture(),
                ),
              ],
            ),
          ),
          const Expanded(child: HomeHeaderContact(kIsMobile: false)),
        ],
      ),
    );
  }
}
