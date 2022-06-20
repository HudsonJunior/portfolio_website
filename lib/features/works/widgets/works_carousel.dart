import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_website/features/works/models/works_model.dart';
import 'package:portfolio_website/features/works/widgets/carousel_card.dart';

class WorksCarousel extends StatefulWidget {
  const WorksCarousel({Key? key}) : super(key: key);

  @override
  State<WorksCarousel> createState() => _WorksCarouselState();
}

class _WorksCarouselState extends State<WorksCarousel> {
  late final CarouselController pageController;

  @override
  void initState() {
    super.initState();
    pageController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        key: const PageStorageKey<String>("page_view_works"),
        carouselController: pageController,
        options: CarouselOptions(
          viewportFraction: 0.6,
          enlargeCenterPage: true,
          scrollPhysics: const BouncingScrollPhysics(),
        ),
        itemBuilder: (context, index, _) {
          final work = WorksEnum.values[index];

          return CarouselCard(work: work);
        },
        itemCount: WorksEnum.values.length,
      ),
    );
  }
}
