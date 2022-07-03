import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_website/features/works/models/works_model.dart';

class ImageCarouselMobile extends StatefulWidget {
  const ImageCarouselMobile({
    Key? key,
    required this.imagesPathsLength,
    required this.work,
  }) : super(key: key);

  final int imagesPathsLength;
  final WorksEnum work;

  @override
  State<ImageCarouselMobile> createState() => _ImageCarouselMobileState();
}

class _ImageCarouselMobileState extends State<ImageCarouselMobile> {
  late final CarouselController carouselController;

  @override
  void initState() {
    super.initState();
    carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 8.0),
          Material(
            borderRadius: BorderRadius.circular(24),
            child: IconButton(
              onPressed: () {
                carouselController.previousPage();
              },
              splashRadius: 20,
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: CarouselSlider.builder(
              carouselController: carouselController,
              itemCount: widget.imagesPathsLength,
              itemBuilder: (context, index, _) {
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: InteractiveViewer(
                    child: Image.asset(
                      "assets/${widget.work.name.toLowerCase()}/${index + 1}.${widget.work.appImagesFormat}",
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                viewportFraction: 1,
                enableInfiniteScroll: false,
                height: MediaQuery.of(context).size.height * 0.8,
                initialPage: (widget.work.appImagesLength - 1) ~/ 2,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Material(
            borderRadius: BorderRadius.circular(24),
            child: IconButton(
              onPressed: () {
                carouselController.nextPage();
              },
              icon: const Icon(Icons.arrow_forward_ios),
              splashRadius: 20,
            ),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
    );
  }
}
