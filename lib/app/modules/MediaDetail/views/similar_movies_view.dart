import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/controllers/similar_movies_controller.dart';
import 'package:watched_it_getx/app/shared_widgets/imagecarousel/image_carousel.dart';

class SimilarMoviesView extends StatelessWidget {
  const SimilarMoviesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<SimilarMoviesController>(
      init: SimilarMoviesController(),
      builder: (_) {
        return _.recommendations.value == null
            ? Center(
                child: ImageCarousel(
                  height: 300.0,
                ),
              )
            : Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: ImageCarousel(
                    height: 300.0,
                  ),
                ),
              );
      },
    );
  }
}
