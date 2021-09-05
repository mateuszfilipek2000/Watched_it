import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:watched_it_getx/app/data/models/reviews.dart';
import 'package:watched_it_getx/app/modules/MovieDetail/controllers/media_review_controller.dart';
import 'package:provider/provider.dart';

class MediaReviewView extends StatelessWidget {
  const MediaReviewView({
    Key? key,
    required this.fetchReviews,
    required this.id,
  }) : super(key: key);

  final Future<Reviews?> Function(int) fetchReviews;
  final int id;

  @override
  Widget build(BuildContext context) {
    return GetX<MediaReviewController>(
      init: MediaReviewController(id: id, fetchReviews: fetchReviews),
      tag: context.read<String>(),
      builder: (_) {
        return _.reviews.value == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                controller: _.scrollController,
                itemCount: _.listOfReviews.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(
                          25,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _.listOfReviews[index].author,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    _.listOfReviews[index].createdAt
                                        .getDashedDate(),
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              _.listOfReviews[index].content,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
