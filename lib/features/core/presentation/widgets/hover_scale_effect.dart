import 'package:flutter/material.dart';

class HoverScaleEffect extends StatefulWidget {
  const HoverScaleEffect({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<HoverScaleEffect> createState() => _HoverScaleEffectState();
}

class _HoverScaleEffectState extends State<HoverScaleEffect> {
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
      child: AnimatedScale(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        scale: isHovered ? 1.1 : 1.0,
        child: widget.child,
      ),
    );
  }
}
