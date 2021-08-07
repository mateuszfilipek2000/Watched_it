import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/modules/home/controllers/swipeable_view_controller.dart';

class SwipeableImageView extends StatelessWidget {
  const SwipeableImageView({
    Key? key,
    required this.height,
    this.width = double.infinity,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GetX<SwipeableViewController>(
        init: SwipeableViewController(),
        builder: (controller) {
          return Container(
            width: this.width,
            height: this.height,
            child: controller.objects.length != 0
                ? GestureDetector(
                    onHorizontalDragUpdate: (data) =>
                        controller.handleSwipe(data),
                    onHorizontalDragEnd: (dragEndDetails) =>
                        controller.handleSwipeEnd(dragEndDetails),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        FittedBox(
                          alignment: Alignment.bottomCenter,
                          fit: BoxFit.cover,
                          clipBehavior: Clip.antiAlias,
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            child: Image.network(
                              ImageUrl.getPosterImageUrl(
                                url: controller.getActiveObjectBackdropUrl(),
                              ),
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              key: UniqueKey(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: 10.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  controller.getNavigationBar(dotSize: 10.0),
                            ),
                          ),
                        ),
                        // Align(
                        //   alignment: Alignment.bottomLeft,
                        //   child: Container(
                        //     margin: EdgeInsets.only(bottom: 40.0),
                        //     color: Colors.black54,
                        //     padding: EdgeInsets.all(5.0),
                        //     child: Text(
                        //       controller.getActiveObjectTitle(),
                        //       style: TextStyle(
                        //         fontSize: 18, color: Colors.white,
                        //         // foreground: Paint()
                        //         //   ..style = PaintingStyle.stroke
                        //         //   ..strokeWidth = 0.8
                        //         //   ..color = Colors.white,
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  )
                : CircularProgressIndicator(),
          );
        });
  }
}
