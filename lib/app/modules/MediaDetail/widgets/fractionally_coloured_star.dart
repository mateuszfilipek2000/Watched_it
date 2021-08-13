import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class FractionallyColouredStar extends StatelessWidget {
  const FractionallyColouredStar({
    Key? key,
    required this.fraction,
  }) : super(key: key);

  final double fraction;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: StarClipper(5),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow, Colors.yellow, Colors.grey, Colors.grey],
            stops: [
              0.0,
              fraction,
              fraction,
              1.0,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
    );
  }
}
