import 'package:flutter/material.dart';
import 'package:watched_it_getx/app/shared_widgets/swipeable_stack/swipe_directions.dart';
import 'dart:math' as Math;

import 'package:watched_it_getx/app/shared_widgets/swipeable_stack/swipeable_stack_working_modes.dart';

List<String> networkImages = [
  "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/f3simt2nobpDrv44MoRQSFpuyJa.jpg",
  "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/vsPbevLCHxoPBqHQVNZI4UgB117.jpg",
  "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/f3simt2nobpDrv44MoRQSFpuyJa.jpg",
  "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/vsPbevLCHxoPBqHQVNZI4UgB117.jpg",
  "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/f3simt2nobpDrv44MoRQSFpuyJa.jpg",
  "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/vsPbevLCHxoPBqHQVNZI4UgB117.jpg",
  "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/f3simt2nobpDrv44MoRQSFpuyJa.jpg",
  "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/vsPbevLCHxoPBqHQVNZI4UgB117.jpg",
];

class SwipeableStack extends StatefulWidget {
  const SwipeableStack({
    Key? key,
    required this.height,
    required this.width,
    required this.onSwipe,
    required this.deviceSize,
    required this.children,
    required this.onCardChange,
    required this.onCardTap,
    this.startingIndex = 0,
    this.workingMode = SwipeableStackWorkingMode.horizontalWithTop,
  }) : super(key: key);

  final double height;
  final double width;
  final void Function(SwipeDirection dir) onSwipe;
  final Size deviceSize;
  final List<Widget> children;
  final void Function(int index) onCardChange;
  final int startingIndex;
  final SwipeableStackWorkingMode workingMode;
  final void Function(int) onCardTap;

  @override
  _SwipeableStackState createState() => _SwipeableStackState();
}

class _SwipeableStackState extends State<SwipeableStack>
    with SingleTickerProviderStateMixin {
  Offset _foregroundCardOffset = Offset(0, 0);
  Offset firstHit = Offset(0, 0);

  late Offset globalPosition;

  late AnimationController positionController;

  late Animation<Offset> positionAnimation;
  late Animation<double> rotationAnimation;

  Tween<Offset> positionTween =
      Tween<Offset>(begin: Offset(0, 0), end: Offset(0, 0));
  Tween<double> rotationTween = Tween<double>(begin: 0.0, end: 0.0);

  bool isDragged = false;

  double _foregroundCardAngle = 0.0;
  double horizontalDragValue = 0.0;
  // Offset globalHitOffset = Offset(0, 0);

  late int foregroundCardIndex = widget.startingIndex;
  //List<Widget> objects = networkImages;

  @override
  void didUpdateWidget(covariant SwipeableStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    foregroundCardIndex = widget.startingIndex;
  }

  @override
  void initState() {
    //foregroundCardIndex = widget.startingIndex;
    positionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        setState(() {});
      });

    positionAnimation = positionTween.animate(
        CurvedAnimation(curve: Curves.easeOutBack, parent: positionController))
      ..addListener(() {
        _foregroundCardOffset = positionAnimation.value;
      });

    rotationAnimation = rotationTween.animate(
        CurvedAnimation(curve: Curves.easeOutBack, parent: positionController))
      ..addListener(() {
        _foregroundCardAngle = rotationAnimation.value;
      });

    super.initState();
  }

  Widget _foregroundCard() => GestureDetector(
        onTap: () => widget.onCardTap(foregroundCardIndex),
        onPanStart: (DragStartDetails details) {
          if (!positionController.isAnimating && !isDragged) {
            isDragged = true;
            positionTween.begin = positionTween.end;
            rotationTween.begin = _foregroundCardAngle;
            positionController.reset();
            firstHit = details.localPosition;
            // horizontalDragValue = details.globalPosition.dx;
            horizontalDragValue = 0;
          }
        },
        onPanUpdate: (DragUpdateDetails details) {
          if (!positionController.isAnimating && isDragged) {
            setState(() {
              horizontalDragValue += details.delta.dx;
              globalPosition = details.globalPosition;

              ///the angle variable is between -1/4 and 1/4 (card reaches the maximum of minus and positive 45 degree angle on screen edges)
              _foregroundCardAngle =
                  1 / 2 * (horizontalDragValue / widget.deviceSize.width);

              //before setting offset we need to
              _foregroundCardOffset = Offset(
                details.localPosition.dx - firstHit.dx,
                details.localPosition.dy - firstHit.dy,
              );
            });
          }
        },
        onPanEnd: (_) {
          if (!positionController.isAnimating && isDragged) {
            //checking if widget was dragged enough to be counted as swipe
            switch (widget.workingMode) {
              case SwipeableStackWorkingMode.horizontalWithTop:
                if (globalPosition.dy <= widget.deviceSize.height * 0.2) {
                  widget.onSwipe(SwipeDirection.Top);
                  AnimateCard(SwipeDirection.Top);
                  print("top action");
                } else if (globalPosition.dx <= widget.deviceSize.width * 0.2) {
                  widget.onSwipe(SwipeDirection.Left);
                  AnimateCard(SwipeDirection.Left);
                  print("left action");
                } else if (globalPosition.dx >= widget.deviceSize.width * 0.8) {
                  widget.onSwipe(SwipeDirection.Right);
                  AnimateCard(SwipeDirection.Right);
                  print("right action");
                } else
                  setState(() {
                    positionTween.begin = _foregroundCardOffset;
                    positionTween.end = Offset(0, 0);
                    rotationTween.begin = _foregroundCardAngle;
                    rotationTween.end = 0;
                    positionController.forward();
                  });
                break;
              case SwipeableStackWorkingMode.horizontal:
                if (globalPosition.dx <= widget.deviceSize.width * 0.2) {
                  widget.onSwipe(SwipeDirection.Left);
                  AnimateCard(SwipeDirection.Left);
                  print("left action");
                } else if (globalPosition.dx >= widget.deviceSize.width * 0.8) {
                  widget.onSwipe(SwipeDirection.Right);
                  AnimateCard(SwipeDirection.Right);
                  print("right action");
                } else
                  setState(() {
                    positionTween.begin = _foregroundCardOffset;
                    positionTween.end = Offset(0, 0);
                    rotationTween.begin = _foregroundCardAngle;
                    rotationTween.end = 0;
                    positionController.forward();
                  });
                break;
            }

            // if (globalPosition.dy <= widget.deviceSize.height * 0.2) {
            //   widget.onSwipe(SwipeDirection.Top);
            //   AnimateCard(SwipeDirection.Top);
            //   print("top action");
            // } else if (globalPosition.dy >= widget.deviceSize.height * 0.8) {
            //   widget.onSwipe(SwipeDirection.Bottom);
            //   AnimateCard(SwipeDirection.Bottom);
            //   print("bottom action");
            // } else if (globalPosition.dx <= widget.deviceSize.width * 0.2) {
            //   widget.onSwipe(SwipeDirection.Left);
            //   AnimateCard(SwipeDirection.Left);
            //   print("left action");
            // } else if (globalPosition.dx >= widget.deviceSize.width * 0.8) {
            //   widget.onSwipe(SwipeDirection.Right);
            //   AnimateCard(SwipeDirection.Right);
            //   print("right action");
            // } else
            //   setState(() {
            //     positionTween.begin = _foregroundCardOffset;
            //     positionTween.end = Offset(0, 0);
            //     rotationTween.begin = _foregroundCardAngle;
            //     rotationTween.end = 0;
            //     positionController.forward();
            //   });
            isDragged = false;
          }
        },
        child: Transform.translate(
          offset: _foregroundCardOffset,
          child: Transform.rotate(
            angle: Math.pi * _foregroundCardAngle,
            child: SizedBox(
              width: widget.width,
              height: widget.height,
              child: FittedBox(
                child: widget.children[foregroundCardIndex],
                fit: BoxFit.cover,
                clipBehavior: Clip.hardEdge,
              ),
            ),
          ),
        ),
      );

  Widget _backgroundCard() => Container(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: SizedBox(
          height: widget.height,
          width: widget.width,
          child: FittedBox(
            child: widget.children[foregroundCardIndex + 1],
            fit: BoxFit.cover,
            clipBehavior: Clip.hardEdge,
          ),
        ),
      );

  @override
  void dispose() {
    positionController.dispose();
    super.dispose();
  }

  void AnimateCard(SwipeDirection dir) async {
    positionTween.begin = _foregroundCardOffset;
    rotationTween.begin = _foregroundCardAngle;
    rotationTween.end = 0;

    //card offset reaches this values when it touches screen edges
    //left edge of the screen
    double maxLeftHorizontalValue =
        (-1) * ((widget.deviceSize.width / 2.0) - (widget.width / 2.0));
    //right edge of the screen
    double maxRightHorizontalValue =
        (widget.deviceSize.width / 2.0) + (widget.width / 2.0);
    //top edge of the screen
    double maxTopVerticalValue =
        (-1) * ((widget.deviceSize.height / 2.0) - (widget.height / 2.0));
    //bottom edge of the screen
    double maxBottomVerticalValue =
        (widget.deviceSize.height / 2.0) + (widget.height / 2.0);

    switch (dir) {
      case SwipeDirection.Left:
        positionTween.end = Offset(
            maxLeftHorizontalValue - widget.width, _foregroundCardOffset.dy);

        break;
      case SwipeDirection.Right:
        positionTween.end =
            Offset(maxRightHorizontalValue, _foregroundCardOffset.dy);

        break;
      case SwipeDirection.Top:
        positionTween.end = Offset(
            _foregroundCardOffset.dx, maxTopVerticalValue - widget.height);

        break;
      case SwipeDirection.Bottom:
        positionTween.end =
            Offset(_foregroundCardOffset.dx, maxBottomVerticalValue);

        break;
    }
    //positionController.forward();

    widget.onCardChange(foregroundCardIndex + 1);
    await positionController.forward().whenComplete(
      () {
        resetAnimations();
        foregroundCardIndex++;
      },
    );
  }

  void resetAnimations() {
    positionController.reset();
    setState(() {
      positionTween = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, 0));
      rotationTween = Tween<double>(begin: 0.0, end: 0.0);
      _foregroundCardOffset = Offset(0, 0);
      _foregroundCardAngle = 0.0;

      positionAnimation = positionTween.animate(CurvedAnimation(
          curve: Curves.easeOutBack, parent: positionController))
        ..addListener(() {
          _foregroundCardOffset = positionAnimation.value;
        });

      rotationAnimation = rotationTween.animate(CurvedAnimation(
          curve: Curves.easeOutBack, parent: positionController))
        ..addListener(() {
          _foregroundCardAngle = rotationAnimation.value;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Stack(
        children: [
          foregroundCardIndex <= widget.children.length - 2
              ? _backgroundCard()
              : Container(),
          foregroundCardIndex <= widget.children.length - 1
              ? _foregroundCard()
              : Container(
                  child: Center(
                    child: Text("No more objects"),
                  ),
                ),
        ],
      ),
    );
  }
}
