import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/controllers/swipeable_image_view_f_controller.dart';

class SwipeableWidgetView extends GetView<SwipeableWidgetViewController> {
  const SwipeableWidgetView({
    Key? key,
    required this.height,
    required this.navigationIndicatorAlignment,
    this.width = double.infinity,
  }) : super(key: key);

  final double height;
  final double width;
  final Alignment navigationIndicatorAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      child: GestureDetector(
        onHorizontalDragUpdate: (data) => controller.handleSwipe(data),
        onHorizontalDragEnd: (dragEndDetails) =>
            controller.handleSwipeEnd(dragEndDetails),
        child: Stack(
          fit: StackFit.expand,
          children: [
            FittedBox(
              alignment: Alignment.center,
              fit: BoxFit.cover,
              clipBehavior: Clip.antiAlias,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: controller.getActiveChild(),
              ),
            ),
            Align(
              alignment: navigationIndicatorAlignment,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 10.0,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // for (var i = 0; i < controller.children.length; i++)
                      //   Container(
                      //     width: 10,
                      //     height: 10,
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       color: i == controller.activeIndex.value
                      //           ? Colors.blue
                      //           : Colors.grey,
                      //     ),
                      //   )
                      Text(
                        "${controller.activeIndex.value + 1}/${controller.children.length}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
