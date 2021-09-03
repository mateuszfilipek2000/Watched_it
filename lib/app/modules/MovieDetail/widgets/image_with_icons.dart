import 'package:flutter/material.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';

class ImageWithIcons extends StatelessWidget {
  const ImageWithIcons({
    Key? key,
    required this.imagePath,
    required this.onBookmarkTap,
    required this.onIconTap,
    required this.topIconInactive,
    required this.topIconActive,
    required this.bottomIconInactive,
    required this.bottomIconActive,
    this.isTopActive,
    this.isBottomActive,
  }) : super(key: key);

  final String? imagePath;
  final Function onBookmarkTap;
  final Function onIconTap;
  final IconData topIconInactive;
  final IconData topIconActive;
  final IconData bottomIconInactive;
  final IconData bottomIconActive;
  final bool? isTopActive;
  final bool? isBottomActive;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1.5,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                ),
                child: imagePath == null
                    ? Image.asset(
                        'assets/images/no_image_placeholder.png',
                        fit: BoxFit.fill,
                      )
                    : Image.network(
                        imagePath!,
                        fit: BoxFit.fill,
                      )),
          ),
          Positioned(
            //alignment: Alignment.bottomRight,
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => onIconTap(),
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: Center(
                  child: Icon(
                    isBottomActive != null
                        ? isBottomActive as bool
                            ? bottomIconActive
                            : bottomIconInactive
                        : bottomIconInactive,
                    size: 20.0,
                    color: isBottomActive != null
                        ? isBottomActive as bool
                            ? Colors.red
                            : Colors.grey
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => onBookmarkTap(),
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Icon(
                    isTopActive != null
                        ? isTopActive as bool
                            ? topIconActive
                            : topIconInactive
                        : topIconInactive,
                    color: isTopActive != null
                        ? isTopActive as bool
                            ? Colors.blue
                            : Colors.grey
                        : Colors.grey,
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
