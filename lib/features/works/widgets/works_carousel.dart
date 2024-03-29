import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_website/features/core/presentation/widgets/shader_mask_list.dart';
import 'package:portfolio_website/features/works/models/works_model.dart';
import 'package:portfolio_website/features/works/widgets/carousel_card.dart';
import 'package:portfolio_website/features/works/works_cubit.dart';
import 'package:portfolio_website/resources/colors.dart';

class WorksCarousel extends StatefulWidget {
  const WorksCarousel({
    Key? key,
  }) : super(key: key);

  @override
  State<WorksCarousel> createState() => _WorksCarouselState();
}

class _WorksCarouselState extends State<WorksCarousel> {
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
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: ShaderMaskList(
                  child: CarouselSlider.builder(
                    key: const PageStorageKey<String>("page_view_works"),
                    carouselController: pageController,
                    options: CarouselOptions(
                      viewportFraction: 0.4,
                      enlargeCenterPage: true,
                      scrollPhysics: const BouncingScrollPhysics(),
                    ),
                    itemBuilder: (context, index, _) {
                      final work = WorksEnum.values[index];

                      return CarouselCard(
                        work: work,
                        autoSizeGroup: autoSizeGroup,
                      );
                    },
                    itemCount: WorksEnum.values.length,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: IconButton(
                  onPressed: () {
                    pageController.previousPage();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  color: AppColors.black,
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: IconButton(
                  onPressed: () {
                    pageController.nextPage();
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                  ),
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
