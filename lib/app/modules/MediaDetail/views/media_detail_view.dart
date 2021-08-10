import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';

import '../controllers/media_detail_controller.dart';

//when navigating to this route you must pass MinimalMedia object as an argument

class MediaDetailView extends GetView<MediaDetailController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
                          child: Image.network(
                            ImageUrl.getPosterImageUrl(
                              url: controller.minimalMedia.value?.posterPath
                                  as String,
                              size: PosterSizes.w780,
                            ),
                            loadingBuilder: (BuildContext context, Widget child,
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
      ],
    );
  }
}


/*
Image.network(
                          ImageUrl.getPosterImageUrl(
                            url: controller.minimalMedia.value?.posterPath
                                as String,
                            size: PosterSizes.w185,
                          ),
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),

*/