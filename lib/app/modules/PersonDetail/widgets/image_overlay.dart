import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:watched_it_getx/app/modules/PersonDetail/controllers/image_overlay_controller.dart';

class ImageOverlay extends StatelessWidget {
  const ImageOverlay({Key? key, required this.imagePath}) : super(key: key);
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageOverlayController>(
      init: ImageOverlayController(),
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
                      aspectRatio: 1 / 1.5,
                      child: Image.network(
                        imagePath,
                        fit: BoxFit.cover,
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
