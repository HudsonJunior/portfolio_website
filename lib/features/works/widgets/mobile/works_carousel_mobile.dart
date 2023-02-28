import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_website/features/works/models/works_model.dart';
import 'package:portfolio_website/features/works/widgets/mobile/carousel_card_mobile.dart';
import 'package:portfolio_website/features/works/works_cubit.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/extensions.dart';

class WorksCarouselMobile extends StatefulWidget {
  const WorksCarouselMobile({
    Key? key,
  }) : super(key: key);

  @override
  State<WorksCarouselMobile> createState() => _WorksCarouselMobileState();
}

class _WorksCarouselMobileState extends State<WorksCarouselMobile> {
  late final CarouselController pageController;
  late final AutoSizeGroup autoSizeGroup;

  @override
  void initState() {
    super.initState();
    pageController = CarouselController();
    autoSizeGroup = AutoSizeGroup();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorksCubit, bool>(
      builder: (context, isVisible) {
        return AnimatedSlide(
          offset: isVisible ? const Offset(0.0, 0) : const Offset(2, 0.0),
          curve: Curves.easeOutBack,
          duration: const Duration(milliseconds: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: pageController.previousPage,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: AppColors.black,
                          ),
                          Text(
                            'previous',
                            style: context.themeData.displayMedium!
                                .copyWith(fontSize: 10),
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: InkWell(
                      onTap: pageController.nextPage,
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'next',
                            style: context.themeData.displayMedium!
                                .copyWith(fontSize: 10),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: CarouselSlider.builder(
                    key: const PageStorageKey<String>("page_view_works"),
                    carouselController: pageController,
                    options: CarouselOptions(
                      viewportFraction: 1,
                      height: MediaQuery.of(context).size.height * 0.8,
                      enlargeCenterPage: true,
                      scrollPhysics: const BouncingScrollPhysics(),
                    ),
                    itemBuilder: (context, index, _) {
                      final work = WorksEnum.values[index];

                      return CarouselCardMobile(
                        work: work,
                        autoSizeGroup: autoSizeGroup,
                      );
                    },
                    itemCount: WorksEnum.values.length,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
