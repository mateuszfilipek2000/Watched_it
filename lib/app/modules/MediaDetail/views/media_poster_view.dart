import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';

import '../controllers/media_poster_view_controller.dart';

//when navigating to this route you must pass MinimalMedia object as an argument

class MediaPosterView extends GetView<MediaPosterViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Obx(
            () => controller.minimalMedia.value == null
                ? Container(
                    color: Colors.black,
                  )
                : FittedBox(
                    fit: BoxFit.cover,
                    child: controller.minimalMedia.value?.posterPath == null
                        ? Image.asset('assets/images/no_image_placeholder.png')
                        : Opacity(
                            opacity: controller.bgOpacity.value,
                            child: Hero(
                              tag: controller.minimalMedia.value?.title
                                  as String,
                              child: Image.network(
                                ImageUrl.getPosterImageUrl(
                                  url: controller.minimalMedia.value?.posterPath
                                      as String,
                                  size: PosterSizes.w780,
                                ),
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    controller.animationController.forward();
                                    return child;
                                  }
                                  return Container(
                                    color: Colors.black,
                                  );
                                },
                              ),
                            ),
                          ),
                  ),
          ),
          Obx(
            () => GestureDetector(
              onVerticalDragStart: (DragStartDetails details) =>
                  controller.handleDragStart(details),
              onVerticalDragUpdate: (DragUpdateDetails details) =>
                  controller.handleDragUpdate(details),
              onVerticalDragEnd: (DragEndDetails details) =>
                  controller.handleDragEnd(),
              child: Container(
                color: Colors.transparent,
                margin: EdgeInsets.only(
                  bottom: controller.swipeIndicatorPadding.value,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Opacity(
                    opacity: controller.indicatorOpacity.value,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_drop_up_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          "Swipe Up",
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
