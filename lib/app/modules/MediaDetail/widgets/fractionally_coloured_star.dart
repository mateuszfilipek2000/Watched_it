import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'dart:math' as math;

//TODO MAKE IT ADJUSTABLE TO DIFFERENT SCREEN SIZES
class FractionallyColouredStar extends StatelessWidget {
  const FractionallyColouredStar({
    Key? key,
    required this.fraction,
  }) : super(key: key);

  final double fraction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipPath(
          clipper: StarClipper(5),
          child: Container(
            // width: 30,
            // height: 30,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.yellow,
                  Colors.yellow,
                  Colors.grey,
                  Colors.grey
                ],
                stops: [
                  0.0,
                  fraction,
                  fraction,
                  1.0,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                // begin: Alignment.bottomCenter,
                // end: Alignment.topCenter,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
