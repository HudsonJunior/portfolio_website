import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_website/features/about/presentation/about_section.dart';
import 'package:portfolio_website/features/blog/presentation/writing_section.dart';
import 'package:portfolio_website/features/contact/presentation/contact_section.dart';
import 'package:portfolio_website/features/core/presentation/cubits/control_page_cubit.dart';
import 'package:portfolio_website/features/core/presentation/widgets/portfolio_nav_bar.dart';
import 'package:portfolio_website/features/core/presentation/widgets/reveal_on_scroll.dart';
import 'package:portfolio_website/features/experience/presentation/experience_section.dart';
import 'package:portfolio_website/features/experiments/presentation/experiments_section.dart';
import 'package:portfolio_website/features/home/presentation/home_section.dart';
import 'package:portfolio_website/features/talks/presentation/talks_section.dart';
import 'package:portfolio_website/resources/colors.dart';

class CorePage extends StatefulWidget {
  /// Optional section slug from `/?section=talks` deep links.
  final String? initialSection;

  const CorePage({super.key, this.initialSection});

  @override
  State<CorePage> createState() => _CorePageState();
}

class _CorePageState extends State<CorePage> {
  late final ControlPageCubit _cubit;
  late final ScrollController _scrollController;

  // Order: Home, Talks, Writing, Experiments, Experience, About, Contact
  final _keys = List.generate(7, (_) => GlobalKey());

  final _scrollPos = ValueNotifier<double>(0);
  final _scrollFraction = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<ControlPageCubit>(context);
    _scrollController = ScrollController()
      ..addListener(() {
        if (!_scrollController.hasClients) return;
        final pos = _scrollController.position.pixels;
        final max = _scrollController.position.maxScrollExtent;

        _scrollPos.value = pos;
        _scrollFraction.value = max > 0 ? (pos / max).clamp(0.0, 1.0) : 0.0;

        _updateActiveSection();
      });

    final section = widget.initialSection;
    if (section != null && section.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final index = _indexForSection(section);
        if (index != null) _goTo(index);
      });
    }
  }

  @override
  void dispose() {
    _scrollPos.dispose();
    _scrollFraction.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  static const _kNavHeight = 62.0;

  static int? _indexForSection(String section) {
    switch (section) {
      case 'home':
        return 0;
      case 'talks':
        return 1;
      case 'writing':
        return 2;
      case 'experiments':
        return 3;
      case 'experience':
        return 4;
      case 'about':
        return 5;
      case 'contact':
        return 6;
      default:
        return null;
    }
  }

  void _goTo(int index) {
    if (!_scrollController.hasClients) return;
    final ctx = _keys[index].currentContext;
    if (ctx == null) return;
    final ro = ctx.findRenderObject() as RenderBox?;
    if (ro == null) return;

    final dy = ro.localToGlobal(Offset.zero).dy;
    final target = (_scrollController.offset + dy - _kNavHeight).clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );

    _scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  void _updateActiveSection() {
    final threshold = MediaQuery.of(context).size.height * 0.40;
    for (int i = _keys.length - 1; i >= 0; i--) {
      final ctx = _keys[i].currentContext;
      if (ctx == null) continue;
      final ro = ctx.findRenderObject() as RenderBox?;
      if (ro == null) continue;
      final dy = ro.localToGlobal(Offset.zero).dy;
      if (dy <= threshold) {
        _cubit.setSection(i);
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final sections = [
      HomeSection(onScrollToExperience: () => _goTo(4)),
      const TalksSection(),
      const WritingSection(),
      const ExperimentsSection(),
      const ExperienceSection(),
      const AboutSection(),
      const ContactSection(),
    ];

    return PortfolioScroll(
      scrollPos: _scrollPos,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(
                  sections.length,
                  (i) => KeyedSubtree(key: _keys[i], child: sections[i]),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: PortfolioNavBar(
                onScrollTo: _goTo,
                scrollFraction: _scrollFraction,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
