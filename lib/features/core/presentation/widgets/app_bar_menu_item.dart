import 'package:flutter/material.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/theme.dart';

class NavTextItem extends StatefulWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const NavTextItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<NavTextItem> createState() => _NavTextItemState();
}

class _NavTextItemState extends State<NavTextItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.isSelected || _hovered;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: AppTextStyles.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: active ? AppColors.text : AppColors.text.withValues(alpha: 0.55),
          ),
          child: Text(widget.title),
        ),
      ),
    );
  }
}

class NavContactButton extends StatefulWidget {
  final VoidCallback onTap;

  const NavContactButton({super.key, required this.onTap});

  @override
  State<NavContactButton> createState() => _NavContactButtonState();
}

class _NavContactButtonState extends State<NavContactButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.accent : Colors.transparent,
            border: Border.all(
              color: _hovered
                  ? AppColors.accent
                  : AppColors.accent.withValues(alpha: 0.5),
            ),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            'Contact',
            style: AppTextStyles.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.text,
            ),
          ),
        ),
      ),
    );
  }
}
