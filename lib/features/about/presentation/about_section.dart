import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_website/features/about/presentation/about_cubit.dart';
import 'package:portfolio_website/features/about/presentation/widgets/about_me_texts.dart';
import 'package:portfolio_website/features/about/presentation/widgets/about_me_texts_mobile.dart';
import 'package:portfolio_website/features/core/models/app_bar_itens.dart';
import 'package:portfolio_website/features/core/presentation/cubits/control_page_cubit.dart';
import 'package:portfolio_website/features/core/presentation/widgets/section_header.dart';
import 'package:portfolio_website/resources/constraints.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (_) => AboutCubit(),
      child: Builder(builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: BlocListener<ControlPageCubit, AppBarItens>(
            listener: (_, state) {
              if (state == AppBarItens.about) {
                context.read<AboutCubit>().changeVisibility();
              }
            },
            key: const Key("about_section"),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: BlocBuilder<AboutCubit, bool>(
                      builder: (context, isVisible) {
                    return SectionHeader(
                      isVisible: isVisible,
                      headerTitle: "about me",
                    );
                  }),
                ),
                const SizedBox(height: 32.0),
                Expanded(
                  flex: 5,
                  child: LayoutBuilder(builder: (context, constraints) {
                    if (AppConstraints.isMobile(constraints.maxWidth)) {
                      return const AboutMeTextsMobile();
                    }

                    return const AboutMeTexts();
                  }),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
