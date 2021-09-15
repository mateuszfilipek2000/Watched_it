import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/shared_widgets/swipeable_stack/swipe_directions.dart';
import 'package:watched_it_getx/app/shared_widgets/swipeable_stack/swipeable_stack.dart';
import '../controllers/discover_view_controller.dart';

class DiscoverViewView extends StatelessWidget {
  DiscoverViewView() : controller = Get.put(DiscoverViewController());

  final DiscoverViewController controller;
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.topCenter,
      fit: StackFit.expand,
      children: [
        Obx(
          () => controller.currentPosterUrl.value == null
              ? FittedBox(
                  fit: BoxFit.cover,
                  child: Image.asset(
                    "assets/images/no_image_placeholder.png",
                    fit: BoxFit.cover,
                  ),
                )
              : FittedBox(
                  fit: BoxFit.cover,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Image.network(
                      controller.currentPosterUrl.value!,
                      fit: BoxFit.cover,
                      key: UniqueKey(),
                    ),
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
          child: GetBuilder<DiscoverViewController>(
            //init: Get.put(DiscoverViewController()),
            builder: (controller) {
              return SwipeableStack(
                height: (deviceSize.width / 2) * 1.5,
                width: deviceSize.width / 2,
                onSwipe: controller.handleSwipe,
                deviceSize: deviceSize,
                onCardChange: controller.changeStackObjectIndex,
                startingIndex: controller.currentStackObjectIndex,
                children: controller.objects,
                onCardTap: controller.getToMediaDetailsPage,
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: EdgeInsets.only(bottom: 15.0),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                bottomLeft: const Radius.circular(15),
              ),
            ),
            child: Obx(
              () => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () =>
                        controller.changeDiscoverMedia(MediaType.movie),
                    child: Text(
                      "Movies",
                      style: TextStyle(
                        color: controller.selectedMediaType.value ==
                                MediaType.movie
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        controller.changeDiscoverMedia(MediaType.tv),
                    child: Text(
                      "Tv Shows",
                      style: TextStyle(
                        color:
                            controller.selectedMediaType.value == MediaType.tv
                                ? Colors.blue
                                : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
