import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/modules/PersonDetail/controllers/image_overlay_controller.dart';
import 'package:watched_it_getx/app/modules/PersonDetail/widgets/image_overlay.dart';

class PersonImageViewController extends GetxController {
  bool isOverlayOpen = false;

  late OverlayEntry overlayEntry;

  @override
  void onClose() {
    if (overlayEntry.mounted) overlayEntry.remove();
    super.onClose();
  }

  void showImageOverlay(BuildContext context, String imagePath) async {
    if (isOverlayOpen == false) {
      OverlayState? overlayState = Overlay.of(context);
      overlayEntry = OverlayEntry(
        builder: (_) => ImageOverlay(
          imagePath: imagePath,
        ),
      );
      if (overlayState != null) {
        overlayState.insert(overlayEntry);
        isOverlayOpen = true;
      }
    }
  }

  void hideOverlay() async {
    if (isOverlayOpen) {
      ImageOverlayController imageOverlayController =
          Get.find<ImageOverlayController>();
      imageOverlayController.animController.stop();
      TickerFuture animControllerStatus =
          imageOverlayController.animController.reverse();
      animControllerStatus.whenComplete(() {
        if (overlayEntry.mounted) {
          overlayEntry.remove();
          isOverlayOpen = false;
        }
      });
    }
  }

  void openImageFullScreen(String imagePath) {
    Get.to(
      () => Image.network(
        imagePath,
        fit: BoxFit.contain,
      ),
      fullscreenDialog: true,
    );
  }
}

// class AnimatedPictureOverlay extends StatefulWidget {
//   const AnimatedPictureOverlay({Key? key, required this.imagePath})
//       : super(key: key);

//   final String imagePath;

//   @override
//   _AnimatedPictureOverlayState createState() => _AnimatedPictureOverlayState();
// }

// class _AnimatedPictureOverlayState extends State<AnimatedPictureOverlay>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _animController;
//   late final Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();

//     _animController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 100),
//     )..addListener(() {
//         setState(() {});
//       });

//     _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animController,
//         curve: Curves.easeInOutBack,
//       ),
//     );

//     _animController.forward();
//   }

//   @override
//   void dispose() {
//     _animController.reverse();

//     _animController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height / 1.5,
//       child: Transform.scale(
//         scale: _animController.value,
//         child: AspectRatio(
//           aspectRatio: 1 / 1.5,
//           child: Image.network(
//             widget.imagePath,
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AnimatedOpacityOverlay extends StatefulWidget {
//   const AnimatedOpacityOverlay({Key? key, required this.imagePath})
//       : super(key: key);

//   final String imagePath;

//   @override
//   _AnimatedOpacityOverlayState createState() => _AnimatedOpacityOverlayState();
// }

// class _AnimatedOpacityOverlayState extends State<AnimatedOpacityOverlay>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _animController;
//   late final Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();

//     _animController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 100),
//     )..addListener(() {
//         setState(() {});
//       });

//     _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animController,
//         curve: Curves.easeIn,
//       ),
//     );

//     _animController.forward();
//   }

//   @override
//   void dispose() {
//     _animController.reverse();

//     _animController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Opacity(
//       opacity: _animController.value,
//       child: BackdropFilter(
//         filter: ImageFilter.blur(
//           sigmaX: 5,
//           sigmaY: 5,
//         ),
//         child: Container(
//           height: double.infinity,
//           width: double.infinity,
//           color: Colors.black.withOpacity(0.6),
//           child: Align(
//             alignment: Alignment.center,
//             child: AnimatedPictureOverlay(
//               imagePath: widget.imagePath,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
