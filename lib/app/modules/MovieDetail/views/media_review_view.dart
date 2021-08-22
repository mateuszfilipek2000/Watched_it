import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:watched_it_getx/app/modules/MovieDetail/controllers/media_review_controller.dart';
import 'package:provider/provider.dart';

class MediaReviewView extends StatelessWidget {
  const MediaReviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<MediaReviewController>(
      init: MediaReviewController(tag: context.read<int>().toString()),
      tag: context.read<int>().toString(),
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
                        color: Colors.black38,
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
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    _.listOfReviews[index].createdAt
                                        .getDashedDate(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              _.listOfReviews[index].content,
                              style: TextStyle(
                                color: Colors.white54,
                              ),
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
