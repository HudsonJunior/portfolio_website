import 'package:flutter/material.dart';
import 'package:portfolio_website/features/home/presentation/widgets/common/contact_itens.dart';
import 'package:portfolio_website/features/home/presentation/widgets/common/see_my_works_widget.dart';

class HomeHeaderContact extends StatelessWidget {
  const HomeHeaderContact({
    Key? key,
    required this.kIsMobile,
  }) : super(key: key);

  final bool kIsMobile;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.bounceOut,
      duration: const Duration(milliseconds: 1200),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: Column(
        children: [
          Flexible(child: ContactItens(kIsMobile: kIsMobile)),
          const Flexible(child: SeeMyWorksWidget()),
        ],
      ),
    );
  }
}
