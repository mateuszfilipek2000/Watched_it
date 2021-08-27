import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/modules/MovieDetail/controllers/swipeable_image_view_f_controller.dart';

class SwipeableWidgetView extends StatelessWidget {
  SwipeableWidgetView({
    Key? key,
    required this.height,
    required this.navigationIndicatorAlignment,
    required String tag,
    this.width = double.infinity,
  })  : controller = Get.find<SwipeableWidgetViewController>(tag: tag),
        super(key: key);

  final double height;
  final double width;
  final Alignment navigationIndicatorAlignment;
  final SwipeableWidgetViewController controller;

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
              child: Obx(
                () => AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: controller.getActiveChild(),
                ),
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
                      Container(
                        margin: EdgeInsets.all(5.0),
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Obx(() => Text(
                              "${controller.activeIndex.value + 1}/${controller.children.length}",
                              style: TextStyle(color: Colors.white),
                            )),
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
