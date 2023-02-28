import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_website/features/core/models/app_bar_itens.dart';
import 'package:portfolio_website/features/core/presentation/cubits/control_page_cubit.dart';
import 'package:portfolio_website/features/core/presentation/widgets/section_header.dart';
import 'package:portfolio_website/features/works/widgets/mobile/works_carousel_mobile.dart';
import 'package:portfolio_website/features/works/widgets/works_carousel.dart';
import 'package:portfolio_website/features/works/works_cubit.dart';
import 'package:portfolio_website/resources/constraints.dart';
import 'package:portfolio_website/resources/extensions.dart';

class WorksSection extends StatefulWidget {
  const WorksSection({Key? key}) : super(key: key);

  @override
  State<WorksSection> createState() => _WorksSectionState();
}

class _WorksSectionState extends State<WorksSection>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (_) => WorksCubit(),
      child: Builder(
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: BlocListener<ControlPageCubit, AppBarItens>(
              listener: (_, state) {
                if (state == AppBarItens.works) {
                  context.read<WorksCubit>().changeVisibility();
                }
              },
              key: const Key("works_section"),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: BlocBuilder<WorksCubit, bool>(
                      builder: (context, isVisible) {
                        return SectionHeader(
                          isVisible: isVisible,
                          headerTitle: "works",
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          if (AppConstraints.isMobile(constraints.maxWidth)) {
                            return const WorksCarouselMobile();
                          }

                          return const WorksCarousel();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  Flexible(
                    child: Text(
                      "Besides these apps I also developed many projects in software house companies.",
                      maxLines: 3,
                      style: context.themeData.displaySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
