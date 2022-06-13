import 'package:flutter/material.dart';

class HoverRotationEffect extends StatefulWidget {
  const HoverRotationEffect({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<HoverRotationEffect> createState() => _HoverRotationEffectState();
}

class _HoverRotationEffectState extends State<HoverRotationEffect> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: AnimatedRotation(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        turns: isHovered ? 1 : 0.0,
        child: widget.child,
      ),
    );
  }
}
