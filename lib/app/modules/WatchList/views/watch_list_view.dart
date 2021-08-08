import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';

import '../controllers/watch_list_controller.dart';

class WatchListView extends GetView<WatchListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        title: Text("My Watchlists"),
      ),
      backgroundColor: Color(0xFF1c1d25),
      body: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Obx(
                    () => Row(
                      children: <MediaButton>[
                        for (var i = 0; i < controller.buttonTexts.length; i++)
                          MediaButton(
                            color: i == controller.activeMediaIndex.value
                                ? Colors.blue
                                : Colors.grey,
                            id: i,
                            onPressed: controller.changeActiveMedia,
                            text: controller.buttonTexts[i],
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Expanded(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: PopupMenuButton(
                      onSelected: (Text text) => controller.changeSortingMethod(
                        int.parse(
                          text.data as String,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Sorted By",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Icon(
                                Icons.filter_alt_rounded,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Obx(() => Text(
                                controller.sortingMethodsTexts[
                                    controller.activeSortingMethod.value],
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              )),
                        ],
                      ),
                      itemBuilder: (context) => <PopupMenuEntry<Text>>[
                        for (var i = 0;
                            i < controller.sortingMethodsTexts.length;
                            i++)
                          PopupMenuItem(
                            value: Text(i.toString()),
                            child: Text(
                              controller.sortingMethodsTexts[i],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                height: 2,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 5),
                child: Obx(
                  () => controller.watchlistFetchingStatus.value == false
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          child: ListView.builder(
                            itemCount: controller.watchlist.length,
                            itemBuilder: (context, index) {
                              return RawMaterialButton(
                                onPressed: () {},
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Image.network(
                                            ImageUrl.getPosterImageUrl(
                                              url: controller.watchlist[index]
                                                  .posterPath as String,
                                              size: PosterSizes.w185,
                                            ),
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller
                                                    .watchlist[index].title,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                "Premiere date: " +
                                                    controller.watchlist[index]
                                                        .getDateString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              //Text(),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MediaButton extends StatelessWidget {
  const MediaButton({
    Key? key,
    required this.text,
    required this.id,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final int id;
  final Color color;
  final Function(int) onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => this.onPressed(this.id),
      child: Text(
        this.text,
        style: TextStyle(
          color: this.color,
        ),
      ),
    );
  }
}
