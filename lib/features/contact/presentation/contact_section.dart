import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_website/features/core/presentation/widgets/reveal_on_scroll.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/cv_download.dart';
import 'package:portfolio_website/resources/constraints.dart';
import 'package:portfolio_website/resources/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  static Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      width: double.infinity,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(48, 100, 48, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Gradient card ───────────────────────────────
                const RevealOnScroll(
                  child: _ContactCard(),
                ),
                const SizedBox(height: 44),

                // ── Footer ──────────────────────────────────────
                RevealOnScroll(
                  delay: const Duration(milliseconds: 150),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 48),
                    child: LayoutBuilder(
                      builder: (_, constraints) =>
                          AppConstraints.isMobile(constraints.maxWidth)
                              ? const _FooterMobile()
                              : const _FooterDesktop(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Gradient card ─────────────────────────────────────────────────────────────

class _ContactCard extends StatelessWidget {
  const _ContactCard();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(1.3, 1.3),
            colors: [Color(0xFF0E0F17), Color(0xFF4A2FB0)],
          ),
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Stack(
          children: [
            // Radial glow – top right
            Positioned(
              top: -80,
              right: -60,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: 420,
                  height: 420,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.accent.withValues(alpha: 0.50),
                        AppColors.accent.withValues(alpha: 0.0),
                      ],
                      stops: const [0.0, 0.65],
                    ),
                  ),
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.fromLTRB(56, 64, 56, 64),
              child: LayoutBuilder(
                builder: (_, constraints) =>
                    AppConstraints.isMobile(constraints.maxWidth)
                        ? const _ContactCardContentMobile()
                        : const _ContactCardContentDesktop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Card content (desktop) ────────────────────────────────────────────────────

class _ContactCardContentDesktop extends StatelessWidget {
  const _ContactCardContentDesktop();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '// let\'s talk',
          style: AppTextStyles.mono(
            fontSize: 12.5,
            color: AppColors.accentPurpleLight,
            letterSpacing: 0.06 * 12.5,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Let's build something\ngreat together",
          style: AppTextStyles.spaceGrotesk(
            fontSize: 46,
            fontWeight: FontWeight.w700,
            color: AppColors.text,
            letterSpacingEm: -0.03,
            height: 1.12,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Open to Flutter consulting, and interesting problems. Based in Brazil, working worldwide.',
          style: AppTextStyles.manrope(
            fontSize: 17,
            color: AppColors.text.withValues(alpha: 0.72),
            height: 1.65,
          ),
        ),
        const SizedBox(height: 36),
        const _ContactActions(),
      ],
    );
  }
}

// ─── Card content (mobile) ─────────────────────────────────────────────────────

class _ContactCardContentMobile extends StatelessWidget {
  const _ContactCardContentMobile();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '// let\'s talk',
          style: AppTextStyles.mono(
            fontSize: 12,
            color: AppColors.accentPurpleLight,
            letterSpacing: 0.06 * 12,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          "Let's build something great together",
          style: AppTextStyles.spaceGrotesk(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: AppColors.text,
            letterSpacingEm: -0.03,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Open to Flutter consulting, and interesting problems. Based in Brazil, working worldwide.',
          style: AppTextStyles.manrope(
            fontSize: 15,
            color: AppColors.text.withValues(alpha: 0.72),
            height: 1.65,
          ),
        ),
        const SizedBox(height: 28),
        const _ContactActions(),
      ],
    );
  }
}

// ─── Action row: email button + icon buttons ───────────────────────────────────

class _ContactActions extends StatelessWidget {
  const _ContactActions();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 14,
      runSpacing: 14,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _EmailButton(),
        _DownloadCVButton(),
        _IconActionButton(
          icon: FontAwesomeIcons.linkedinIn,
          url: 'https://www.linkedin.com/in/hudson-p-46583011a/',
        ),
        _IconActionButton(
          icon: FontAwesomeIcons.github,
          url: 'https://github.com/HudsonJunior',
        ),
      ],
    );
  }
}

// ─── White filled email button ─────────────────────────────────────────────────

class _EmailButton extends StatefulWidget {
  const _EmailButton();

  @override
  State<_EmailButton> createState() => _EmailButtonState();
}

class _EmailButtonState extends State<_EmailButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () =>
            ContactSection._launch('mailto:devhudsoncontact@gmail.com'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.mail_outline_rounded,
                  color: Color(0xFF0B0C10), size: 18),
              const SizedBox(width: 10),
              Text(
                'devhudsoncontact@gmail.com',
                style: AppTextStyles.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B0C10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Download CV button ────────────────────────────────────────────────────────

class _DownloadCVButton extends StatefulWidget {
  const _DownloadCVButton();

  @override
  State<_DownloadCVButton> createState() => _DownloadCVButtonState();
}

class _DownloadCVButtonState extends State<_DownloadCVButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: downloadCV,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: _hovered ? 0.14 : 0.08),
            border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.download_rounded, color: Colors.white, size: 18),
              const SizedBox(width: 10),
              Text(
                'Download CV',
                style: AppTextStyles.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Square icon action button ─────────────────────────────────────────────────

class _IconActionButton extends StatefulWidget {
  final FaIconData icon;
  final String url;

  const _IconActionButton({required this.icon, required this.url});

  @override
  State<_IconActionButton> createState() => _IconActionButtonState();
}

class _IconActionButtonState extends State<_IconActionButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => ContactSection._launch(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: _hovered ? 0.20 : 0.10),
            border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: FaIcon(widget.icon, size: 19, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// ─── Footer ────────────────────────────────────────────────────────────────────

class _FooterDesktop extends StatelessWidget {
  const _FooterDesktop();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '© 2026 Hudson Proença',
          style: AppTextStyles.mono(
            fontSize: 12.5,
            color: AppColors.text.withValues(alpha: 0.4),
          ),
        ),
        Text(
          'designed & built with care',
          style: AppTextStyles.mono(
            fontSize: 12.5,
            color: AppColors.text.withValues(alpha: 0.4),
          ),
        ),
      ],
    );
  }
}

class _FooterMobile extends StatelessWidget {
  const _FooterMobile();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '© 2026 Hudson Proença',
          style: AppTextStyles.mono(
            fontSize: 12,
            color: AppColors.text.withValues(alpha: 0.4),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'designed & built with care',
          style: AppTextStyles.mono(
            fontSize: 12,
            color: AppColors.text.withValues(alpha: 0.4),
          ),
        ),
      ],
    );
  }
}
