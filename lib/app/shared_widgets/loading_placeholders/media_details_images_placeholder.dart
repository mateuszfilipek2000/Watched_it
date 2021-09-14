import 'package:flutter/material.dart';

class MediaDetailsImageViewPlaceholder extends StatelessWidget {
  const MediaDetailsImageViewPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        return Container(
          color: Theme.of(context).colorScheme.surface,
        );
      },
    );
  }
}
