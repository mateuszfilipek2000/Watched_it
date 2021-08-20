import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/controllers/similar_movies_controller.dart';
import 'package:watched_it_getx/app/shared_widgets/imagecarousel/image_carousel.dart';
import 'package:watched_it_getx/app/shared_widgets/imagecarousel/image_carousel_controller.dart';

class SimilarMoviesView extends StatelessWidget {
  const SimilarMoviesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<SimilarMoviesController>(
      init: SimilarMoviesController(),
      builder: (_) {
        if (_.recommendations.value == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Stack(
            fit: StackFit.expand,
            children: [
              FittedBox(
                fit: BoxFit.cover,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  child: Image.network(
                    _.recommendedUrls[_.currentCarouselItem.value] as String,
                    key: UniqueKey(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.0),
                  child: GetBuilder<ImageCarouselController>(
                    init: ImageCarouselController(0.7, 0.8),
                    tag: "smallCarouselController",
                    builder: (controller) {
                      return ImageCarousel(
                        height: 300.0,
                        imageUrls: _.recommendedUrls,
                        onPageChanged: (index) =>
                            _.currentCarouselItem.value = index,
                        tag: "smallCarouselController",
                        controller: controller,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
