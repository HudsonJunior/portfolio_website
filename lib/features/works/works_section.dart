import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_website/features/core/models/app_bar_itens.dart';
import 'package:portfolio_website/features/core/presentation/cubits/control_page_cubit.dart';
import 'package:portfolio_website/features/core/presentation/widgets/section_header.dart';
import 'package:portfolio_website/features/works/widgets/mobile/works_carousel_mobile.dart';
import 'package:portfolio_website/features/works/widgets/works_carousel.dart';
import 'package:portfolio_website/resources/constraints.dart';
import 'package:portfolio_website/resources/extensions.dart';

class WorksSection extends StatefulWidget {
  const WorksSection({Key? key}) : super(key: key);

  @override
  State<WorksSection> createState() => _WorksSectionState();
}

class _WorksSectionState extends State<WorksSection>
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
      width: double.infinity,
      child: BlocListener<ControlPageCubit, AppBarItens>(
        listener: (_, state) {
          if (state == AppBarItens.works && !isVisible) {
            toggleVisibility();
          }
        },
        key: const Key("works_section"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: SectionHeader(
                isVisible: isVisible,
                headerTitle: "works",
              ),
            ),
            const SizedBox(height: 32.0),
            Expanded(
              flex: 4,
              child: Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (AppConstraints.isMobile(constraints.maxWidth)) {
                      return WorksCarouselMobile(isVisible: isVisible);
                    }

                    return WorksCarousel(isVisible: isVisible);
                  },
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            Flexible(
              child: AutoSizeText(
                "Besides these apps I have also developed many projects in software house companies and as a freelancer developer.",
                maxLines: 3,
                minFontSize: 10,
                style: context.themeData.headline3!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
