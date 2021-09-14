import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:watched_it_getx/app/shared_widgets/media_images_view/media_images_overlay_controller.dart';

class MediaImageOverlay extends StatelessWidget {
  const MediaImageOverlay(
      {Key? key, required this.imagePath, required this.aspectRatio})
      : super(key: key);
  final String imagePath;
  final double aspectRatio;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MediaImagesOverlayController>(
      init: MediaImagesOverlayController(),
      builder: (_) => Opacity(
        opacity: _.animController.value,
        child: Container(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black.withOpacity(0.6),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: Transform.scale(
                    scale: _.animation.value,
                    child: AspectRatio(
                      aspectRatio: this.aspectRatio,
                      child: Image.network(
                        imagePath,
                        fit: BoxFit.fitWidth,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) {
                            if (_.isControllerRunning == false) {
                              _.runAnimationController();
                              _.isControllerRunning = true;
                            }
                            return child;
                          } else
                            return Container();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
