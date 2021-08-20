import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:watched_it_getx/app/shared_widgets/imagecarousel/image_carousel_controller.dart';

class ImageCarousel extends StatelessWidget {
  const ImageCarousel({
    required this.height,
    this.width = double.infinity,
    Key? key,
  }) : super(key: key);
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => GetBuilder<ImageCarouselController>(
        init: ImageCarouselController(),
        builder: (_) => Container(
          height: this.height,
          width: this.width,
          child: PageView.builder(
            onPageChanged: (index) {
              print(constraints.maxHeight);
              _.activeChildIndex.value = index;
            },
            controller: _.pageController,
            physics: BouncingScrollPhysics(),
            itemCount: 30,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleCarouselItem(
                  index: index,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class SingleCarouselItem extends StatelessWidget {
  const SingleCarouselItem({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return GetX<ImageCarouselController>(
      builder: (_) {
        //right side
        double fraction = (index - _.pageValue.value).abs();
        if (fraction < 0) fraction = 0;
        if (fraction > 1) fraction = 1;
        //fraction varies between 0 and 1
        //zero is start, 1 is finish
        double heightFactor = -0.2 * fraction + 1;

        //if (index == 0) print((heightFactor));

        return FractionallySizedBox(
          heightFactor: heightFactor,
          child: Container(
            color: Colors.blue,
          ),
        );
      },
    );
  }
}
