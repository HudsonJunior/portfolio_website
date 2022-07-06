import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  bool isVisible = false;

  void toggleVisibility() {
    setState(() {
      isVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: BlocListener<ControlPageCubit, AppBarItens>(
        listener: (_, state) {
          if (state == AppBarItens.about && !isVisible) toggleVisibility();
        },
        key: const Key("about_section"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SectionHeader(
                isVisible: isVisible,
                headerTitle: "about me",
              ),
            ),
            const SizedBox(height: 32.0),
            Expanded(
              flex: 5,
              child: LayoutBuilder(builder: (context, constraints) {
                if (AppConstraints.isMobile(constraints.maxWidth)) {
                  return AboutMeTextsMobile(isVisible: isVisible);
                }

                return AboutMeTexts(isVisible: isVisible);
              }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
