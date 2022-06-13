// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AnimatedSpiningContainer extends StatefulWidget {
  const AnimatedSpiningContainer({Key? key}) : super(key: key);

  @override
  State<AnimatedSpiningContainer> createState() =>
      _AnimatedSpiningContainerState();
}

class _AnimatedSpiningContainerState extends State<AnimatedSpiningContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Container();
      },
    );
  }
}
