import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/modules/TvDetail/controllers/tv_detail_controller.dart';
import 'package:provider/provider.dart';
import 'package:watched_it_getx/app/shared_widgets/section.dart';

class TvReviewsView extends StatelessWidget {
  const TvReviewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.find<TvDetailController>(tag: context.read<String>())
            .reviews!
            .results
            .length ==
        0) {
      return Center(
        child: Text("No Reviews Yet"),
      );
    }
    return Container(
      height: double.infinity,
      child: ListView.builder(
        itemCount: Get.find<TvDetailController>(tag: context.read<String>())
            .reviews!
            .results
            .length,
        itemBuilder: (context, index) {
          return Section(
            sectionTitle:
                Get.find<TvDetailController>(tag: context.read<String>())
                    .reviews!
                    .results[index]
                    .author,
            width: double.infinity,
            child: Text(
              Get.find<TvDetailController>(tag: context.read<String>())
                  .reviews!
                  .results[index]
                  .content,
            ),
          );
        },
      ),
    );
  }
}
