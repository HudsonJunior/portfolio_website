import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_website/features/works/models/used_techs_model.dart';
import 'package:portfolio_website/features/works/models/works_model.dart';
import 'package:portfolio_website/features/works/services/contact_launcher_service.dart';
import 'package:portfolio_website/features/works/services/playstore_launcher_service.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/theme.dart';

class WorkProjectCard extends StatefulWidget {
  final WorksEnum work;

  const WorkProjectCard({super.key, required this.work});

  @override
  State<WorkProjectCard> createState() => _WorkProjectCardState();
}

class _WorkProjectCardState extends State<WorkProjectCard> {
  bool _hovered = false;

  String? get _coverPath {
    switch (widget.work) {
      case WorksEnum.localDea:
        return 'assets/localdea/1.jpg';
      case WorksEnum.zombiepo:
        return 'assets/zombiepo/1.png';
      case WorksEnum.portfolio:
        return 'assets/profile.jpeg';
      case WorksEnum.legiaoBebidas:
        return 'assets/legiaobebidas/1.jpeg';
      case WorksEnum.painter:
        // Blank canvas screenshot — use centered icon instead.
        return null;
    }
  }

  Widget _buildCover(WorksEnum work) {
    final coverPath = _coverPath;
    if (coverPath == null) {
      return Container(
        color: AppColors.surfaceAlt,
        alignment: Alignment.center,
        child: Image.asset(
          work.icon,
          width: 88,
          height: 88,
          fit: BoxFit.contain,
        ),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          coverPath,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => Container(
            color: AppColors.surfaceAlt,
            alignment: Alignment.center,
            child: Image.asset(
              work.icon,
              width: 64,
              height: 64,
            ),
          ),
        ),
        Positioned(
          left: 14,
          bottom: 14,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.background.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderMid),
            ),
            padding: const EdgeInsets.all(8),
            child: Image.asset(work.icon, fit: BoxFit.contain),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final work = widget.work;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(
            color: _hovered
                ? AppColors.accent.withValues(alpha: 0.45)
                : AppColors.border,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 40,
                    offset: const Offset(0, 16),
                  ),
                ]
              : [],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 10,
              child: _buildCover(work),
            ),
            Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    work.title,
                    style: AppTextStyles.spaceGrotesk(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacingEm: -0.02,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    work.description,
                    style: AppTextStyles.manrope(
                      fontSize: 14,
                      color: AppColors.text.withValues(alpha: 0.55),
                      height: 1.55,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final tech in work.usedTechs.take(5))
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: AppColors.accent.withValues(alpha: 0.25),
                            ),
                          ),
                          child: Text(
                            tech.title,
                            style: AppTextStyles.mono(
                              fontSize: 11,
                              color: AppColors.accentLight,
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (work.githubUrl != null || work.playstoreId != null) ...[
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        if (work.githubUrl != null)
                          _LinkChip(
                            icon: FontAwesomeIcons.github,
                            label: 'GitHub',
                            onTap: () => UrlLauncherService.openGithubRepo(
                              work.githubUrl!,
                            ),
                          ),
                        if (work.githubUrl != null && work.playstoreId != null)
                          const SizedBox(width: 12),
                        if (work.playstoreId != null)
                          _LinkChip(
                            icon: FontAwesomeIcons.googlePlay,
                            label: 'Play Store',
                            onTap: () => PlayStoreLauncherService.openPlaystore(
                              work.playstoreId!,
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LinkChip extends StatefulWidget {
  final FaIconData icon;
  final String label;
  final VoidCallback onTap;

  const _LinkChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_LinkChip> createState() => _LinkChipState();
}

class _LinkChipState extends State<_LinkChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              widget.icon,
              size: 13,
              color: _hovered ? AppColors.accentLight : AppColors.accent,
            ),
            const SizedBox(width: 6),
            Text(
              widget.label,
              style: AppTextStyles.manrope(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _hovered ? AppColors.accentLight : AppColors.accent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
