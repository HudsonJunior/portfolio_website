import 'package:flutter/material.dart';
import 'package:portfolio_website/resources/colors.dart';

class ShaderMaskList extends StatelessWidget {
  const ShaderMaskList({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.dstOut,
      child: child,
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.black,
            Colors.transparent,
            Colors.transparent,
            AppColors.black
          ],
          stops: const [0.0, 0.06, 0.95, 2.0],
        ).createShader(rect);
      },
    );
  }
}
