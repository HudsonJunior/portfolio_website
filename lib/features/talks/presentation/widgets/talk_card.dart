import 'package:flutter/material.dart';
import 'package:portfolio_website/features/talks/domain/talk_model.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class TalkCard extends StatefulWidget {
  final TalkModel talk;

  const TalkCard({super.key, required this.talk});

  @override
  State<TalkCard> createState() => _TalkCardState();
}

class _TalkCardState extends State<TalkCard> {
  bool _hovered = false;

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final talk = widget.talk;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => _open(talk.talkUrl),
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
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      talk.imageAsset,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 14,
                      left: 14,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.background.withValues(alpha: 0.78),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.borderMid),
                        ),
                        child: Text(
                          talk.format.label,
                          style: AppTextStyles.mono(
                            fontSize: 11,
                            color: AppColors.accentLight,
                            letterSpacing: 0.04 * 11,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${talk.event} · ${talk.date}',
                      style: AppTextStyles.mono(
                        fontSize: 11.5,
                        color: AppColors.accentLight,
                        letterSpacing: 0.04 * 11.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      talk.location,
                      style: AppTextStyles.mono(
                        fontSize: 11,
                        color: AppColors.text.withValues(alpha: 0.4),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      talk.title,
                      style: AppTextStyles.spaceGrotesk(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacingEm: -0.02,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      talk.abstract,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.manrope(
                        fontSize: 14,
                        color: AppColors.text.withValues(alpha: 0.55),
                        height: 1.55,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          'View talk',
                          style: AppTextStyles.manrope(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _hovered
                                ? AppColors.accentLight
                                : AppColors.accent,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_outward_rounded,
                          size: 14,
                          color: _hovered
                              ? AppColors.accentLight
                              : AppColors.accent,
                        ),
                        if (talk.slidesUrl != null) ...[
                          const Spacer(),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () => _open(talk.slidesUrl!),
                              child: Text(
                                'Slides',
                                style: AppTextStyles.manrope(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.text.withValues(alpha: 0.5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
