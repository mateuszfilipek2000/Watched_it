import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/shared_widgets/image_carousel_with_indicator/image_carousel_with_indicator_controller.dart';

class ImageCarouselWithIndicator extends StatelessWidget {
  const ImageCarouselWithIndicator({
    Key? key,
    required this.tag,
    required this.height,
    required this.navigationIndicatorAlignment,
    required this.imageUrls,
  }) : super(key: key);

  final String tag;
  final double height;

  final List<String> imageUrls;
  final Alignment navigationIndicatorAlignment;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageCarouselWithIndicatorController>(
      init: ImageCarouselWithIndicatorController(),
      tag: tag,
      builder: (_) => Container(
        height: height,
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              controller: _.pageController,
              onPageChanged: (index) => _.currentPage.value = index,
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return Image.network(
                  imageUrls[index],
                  fit: BoxFit.cover,
                );
              },
            ),
            Align(
              alignment: navigationIndicatorAlignment,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 10.0,
                ),
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Obx(
                    () => Text(
                      "${_.currentPage.value + 1}/${imageUrls.length}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
