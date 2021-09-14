import 'package:flutter/material.dart';
import 'package:watched_it_getx/app/shared_widgets/section.dart';

class MediaDetailsReviewsViewPlaceholder extends StatelessWidget {
  const MediaDetailsReviewsViewPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Section(
            child: Container(
              height: size.height * 0.4,
            ),
          ),
          Section(
            child: Container(
              height: size.height * 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
