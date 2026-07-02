import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_website/features/works/models/works_model.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({
    super.key,
    required this.imagesPathsLength,
    required this.work,
  });

  final int imagesPathsLength;
  final WorksEnum work;

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  late final CarouselSliderController carouselController;

  @override
  void initState() {
    super.initState();
    carouselController = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 24.0),
          Material(
            borderRadius: BorderRadius.circular(24),
            child: IconButton(
              splashRadius: 18,
              onPressed: () {
                carouselController.previousPage();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
          const SizedBox(width: 24.0),
          Expanded(
            child: CarouselSlider.builder(
              carouselController: carouselController,
              itemCount: widget.imagesPathsLength,
              itemBuilder: (context, index, _) {
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Image.asset(
                    "assets/${widget.work.name.toLowerCase()}/${index + 1}.${widget.work.appImagesFormat}",
                  ),
                );
              },
              options: CarouselOptions(
                viewportFraction: 0.3,
                enableInfiniteScroll: false,
                initialPage: (widget.work.appImagesLength - 1) ~/ 2,
              ),
            ),
          ),
          const SizedBox(width: 24.0),
          Material(
            borderRadius: BorderRadius.circular(24),
            child: IconButton(
              splashRadius: 18,
              onPressed: () {
                carouselController.nextPage();
              },
              icon: const Icon(Icons.arrow_forward_ios),
            ),
          ),
          const SizedBox(width: 24.0),
        ],
      ),
    );
  }
}
