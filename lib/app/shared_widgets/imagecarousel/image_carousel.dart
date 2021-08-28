import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/shared_widgets/imagecarousel/image_carousel_controller.dart';

class ImageCarousel extends StatelessWidget {
  ImageCarousel({
    required this.height,
    required this.imageUrls,
    required this.tag,
    required this.controller,
    this.onPageChanged,
    this.onTap,
    this.width = double.infinity,
    Key? key,
  }) : super(key: key);
  final ImageCarouselController controller;
  final double height;
  final double width;
  final List<String?> imageUrls;
  final String tag;
  final Function(int)? onPageChanged;
  final Function(int)? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: this.height,
      width: this.width,
      child: PageView.builder(
        onPageChanged: (index) {
          if (onPageChanged != null) onPageChanged!(index);

          controller.activeChildIndex.value = index;
        },
        controller: controller.pageController,
        physics: BouncingScrollPhysics(),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (this.onTap != null) this.onTap!(index);
              print("carousel item with index $index was tapped");
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleCarouselItem(
                index: index,
                imageURL: imageUrls[index],
                controllerTag: tag,
              ),
            ),
          );
        },
      ),
    );
  }
}

class SingleCarouselItem extends StatelessWidget {
  SingleCarouselItem({
    Key? key,
    required this.index,
    required this.imageURL,
    required String controllerTag,
  })  : controller = Get.find<ImageCarouselController>(tag: controllerTag),
        super(key: key);
  final int index;
  final String? imageURL;
  final ImageCarouselController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        double fraction = (index - controller.pageValue.value).abs();
        if (fraction < 0) fraction = 0;
        //if (fraction > 1) fraction = 1;
        //fraction varies between 0 and 1
        //zero is start, 1 is finish
        double heightFactor =
            -(1 - controller.minimumChildScale) * fraction + 1;

        if (heightFactor < 0) heightFactor = 0;
        return FractionallySizedBox(
          heightFactor: heightFactor,
          child: imageURL == null
              ? Container(
                  color: Colors.blue,
                )
              : Image.network(
                  imageURL as String,
                  fit: BoxFit.contain,
                ),
        );
      },
    );
  }
}
