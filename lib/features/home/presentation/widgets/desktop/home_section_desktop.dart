import 'package:flutter/material.dart';
import 'package:portfolio_website/features/home/presentation/widgets/common/header/home_header_contact.dart';
import 'package:portfolio_website/features/home/presentation/widgets/common/header/home_header_desktop.dart';
import 'package:portfolio_website/features/home/presentation/widgets/common/profile_picture.dart';
import 'package:portfolio_website/features/home/presentation/widgets/common/see_my_works_widget.dart';

class HomeSectionDesktop extends StatelessWidget {
  const HomeSectionDesktop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Expanded(child: HomeHeader(kIsMobile: false)),
                      Expanded(child: HomeHeaderContact(kIsMobile: false)),
                    ],
                  ),
                ),
                const SizedBox(width: 48),
                const Flexible(child: ProfilePicture()),
              ],
            ),
          ),
          const Flexible(child: SeeMyWorksWidget()),
        ],
      ),
    );
  }
}
