import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/shared_widgets/swipeable_stack/swipe_directions.dart';
import 'package:watched_it_getx/app/shared_widgets/swipeable_stack/swipeable_stack.dart';
import '../controllers/discover_view_controller.dart';

class DiscoverViewView extends StatelessWidget {
  //DiscoverViewView() : controller = Get.put(DiscoverViewController());

  //final DiscoverViewController controller;
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.topCenter,
      //fit: StackFit.expand,
      children: [
        Container(),
        Center(
          child: GetBuilder<DiscoverViewController>(
            init: Get.put(DiscoverViewController()),
            builder: (controller) {
              return SwipeableStack(
                height: (deviceSize.width / 2) * 1.5,
                width: deviceSize.width / 2,
                onSwipe: (SwipeDirection dir) {
                  print(describeEnum(dir));
                },
                deviceSize: deviceSize,
                children: controller.objects,
              );
            },
          ),
        ),
      ],
    );
  }
}
