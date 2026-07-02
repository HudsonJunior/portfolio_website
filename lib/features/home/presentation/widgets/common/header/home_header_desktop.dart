import 'package:flutter/material.dart';
import 'package:portfolio_website/features/home/presentation/widgets/common/header/home_header_title.dart';

class HomeHeader extends StatelessWidget {
  final bool kIsMobile;

  const HomeHeader({
    super.key,
    required this.kIsMobile,
  });

  @override
  Widget build(BuildContext context) {
    return HomeHeaderTitle(kIsMobile: kIsMobile);
  }
}
