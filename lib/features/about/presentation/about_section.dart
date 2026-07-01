import 'package:flutter/material.dart';
import 'package:portfolio_website/features/core/presentation/widgets/reveal_on_scroll.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/constraints.dart';
import 'package:portfolio_website/resources/theme.dart';

// ─── Skill data ────────────────────────────────────────────────────────────────

const _skillGroups = [
  (
    label: 'Mobile',
    items: ['Flutter · 6y', 'Android · 2y', 'iOS · 2y', 'React Native · 1y'],
  ),
  (
    label: 'Languages',
    items: ['Dart', 'Swift', 'Kotlin', 'JavaScript', 'TypeScript', 'Node.js'],
  ),
  (
    label: 'Engineering',
    items: [
      'Architecture & Design',
      'Clean Code',
      'Performance',
      'Code Review',
      'Design Systems',
    ],
  ),
  (
    label: 'Strengths',
    items: ['Leadership', 'Proactivity', 'Fast Learning', 'Communication'],
  ),
];

// ─── Section root ──────────────────────────────────────────────────────────────

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      width: double.infinity,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section label + H2
                RevealOnScroll(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '// about me',
                        style: AppTextStyles.mono(
                          fontSize: 12.5,
                          color: AppColors.accentLight,
                          letterSpacing: 0.06 * 12.5,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'The person behind the code',
                        style: AppTextStyles.spaceGrotesk(
                          fontSize: 44,
                          fontWeight: FontWeight.w700,
                          letterSpacingEm: -0.025,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                // Responsive body
                LayoutBuilder(
                  builder: (_, constraints) =>
                      AppConstraints.isMobile(constraints.maxWidth)
                          ? const _AboutBodyMobile()
                          : const _AboutBodyDesktop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Desktop two-column layout ─────────────────────────────────────────────────

class _AboutBodyDesktop extends StatelessWidget {
  const _AboutBodyDesktop();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 130,
          child: RevealOnScroll(
            delay: Duration(milliseconds: 100),
            child: _AboutLeft(),
          ),
        ),
        SizedBox(width: 64),
        // Pills have their own stagger entrance — no outer RevealOnScroll needed
        Expanded(
          flex: 100,
          child: _SkillGroups(),
        ),
      ],
    );
  }
}

// ─── Mobile stacked layout ─────────────────────────────────────────────────────

class _AboutBodyMobile extends StatelessWidget {
  const _AboutBodyMobile();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RevealOnScroll(
          delay: Duration(milliseconds: 100),
          child: _AboutLeft(),
        ),
        SizedBox(height: 40),
        // Pills have their own stagger entrance
        _SkillGroups(),
      ],
    );
  }
}

// ─── Left column: bio + education card ────────────────────────────────────────

class _AboutLeft extends StatelessWidget {
  const _AboutLeft();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Senior and Lead Mobile Engineer with a Computer Science degree, '
          'specializing in Flutter for advanced, high-performance app development.',
          style: AppTextStyles.manrope(
            fontSize: 17,
            color: AppColors.text.withOpacity(0.72),
            height: 1.75,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "I'm passionate about innovative problem-solving and building scalable "
          'architectures. Known for creativity, proactivity, and rapid learning — '
          'with a proven track record leading feature delivery, ensuring code '
          'quality, and driving architectural improvements.',
          style: AppTextStyles.manrope(
            fontSize: 15,
            color: AppColors.text.withOpacity(0.6),
            height: 1.75,
          ),
        ),
        const SizedBox(height: 30),
        const _EducationCard(),
      ],
    );
  }
}

// ─── Education card ────────────────────────────────────────────────────────────

class _EducationCard extends StatelessWidget {
  const _EducationCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.accentBlue.withOpacity(0.14),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.school_rounded,
              color: AppColors.accentLight,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'B.Sc. in Computer Science',
                  style: AppTextStyles.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'State University of Maringá · 2018 — 2022',
                  style: AppTextStyles.manrope(
                    fontSize: 13,
                    color: AppColors.text.withOpacity(0.55),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Right column: skill groups ────────────────────────────────────────────────

class _SkillGroups extends StatelessWidget {
  const _SkillGroups();

  @override
  Widget build(BuildContext context) {
    int cumIdx = 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _skillGroups.map((grp) {
        final startIdx = cumIdx;
        cumIdx += grp.items.length;
        return Padding(
          padding: const EdgeInsets.only(bottom: 26),
          child: _SkillGroup(
            label: grp.label,
            items: grp.items,
            startIndex: startIdx,
          ),
        );
      }).toList(),
    );
  }
}

class _SkillGroup extends StatelessWidget {
  final String label;
  final List<String> items;
  final int startIndex;

  const _SkillGroup({
    required this.label,
    required this.items,
    required this.startIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: AppTextStyles.mono(
            fontSize: 11.5,
            color: AppColors.text.withOpacity(0.45),
            letterSpacing: 0.09 * 11.5,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 9,
          runSpacing: 9,
          children: items
              .asMap()
              .entries
              .map((e) => _SkillPill(
                    label: e.value,
                    animIndex: startIndex + e.key,
                  ))
              .toList(),
        ),
      ],
    );
  }
}

// ─── Skill pill with stagger entrance animation ────────────────────────────────

class _SkillPill extends StatefulWidget {
  final String label;
  final int animIndex;

  const _SkillPill({required this.label, required this.animIndex});

  @override
  State<_SkillPill> createState() => _SkillPillState();
}

class _SkillPillState extends State<_SkillPill>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  bool _revealed = false;
  late final AnimationController _enter;
  late final Animation<double> _opacity;
  late final Animation<double> _scale;

  ValueNotifier<double>? _scrollNotifier;

  @override
  void initState() {
    super.initState();
    _enter = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _enter, curve: Curves.easeOut),
    );
    _scale = Tween<double>(begin: 0.82, end: 1.0).animate(
      CurvedAnimation(parent: _enter, curve: Curves.easeOutBack),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollNotifier?.removeListener(_checkVisibility);
    _scrollNotifier = PortfolioScroll.of(context);
    _scrollNotifier?.addListener(_checkVisibility);
    // Check on first attach too
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  void _checkVisibility() {
    if (_revealed || !mounted) return;

    final ro = context.findRenderObject();
    if (ro == null || !ro.attached) return;
    final rb = ro as RenderBox;
    final screenH = MediaQuery.of(context).size.height;
    final dy = rb.localToGlobal(Offset.zero).dy;

    if (dy < screenH * 0.92) {
      _revealed = true;
      final delay = Duration(milliseconds: 35 * widget.animIndex);
      Future.delayed(delay, () {
        if (mounted) _enter.forward();
      });
    }
  }

  @override
  void dispose() {
    _scrollNotifier?.removeListener(_checkVisibility);
    _enter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _enter,
      builder: (_, child) => Opacity(
        opacity: _opacity.value,
        child: Transform.scale(
          scale: _scale.value,
          child: child,
        ),
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.basic,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            border: Border.all(
              color:
                  _hovered ? AppColors.accent : Colors.white.withOpacity(0.12),
            ),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.manrope(
              fontSize: 13.5,
              color: _hovered
                  ? AppColors.text
                  : AppColors.text.withOpacity(0.85),
            ),
          ),
        ),
      ),
    );
  }
}
