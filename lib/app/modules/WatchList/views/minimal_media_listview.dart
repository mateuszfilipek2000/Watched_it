import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:watched_it_getx/app/modules/WatchList/controllers/minimal_media_listview_controller.dart';
import 'package:watched_it_getx/app/shared_widgets/minimal_media_tile.dart';

//when navigating to this screen pass required arguments in this way:
/*
  "user": AppUser,
  "ListTitle": String,
  "ButtonTexts": List<String>,
  "SortingMethodTexts": List<String>,
  "MinimalMediaRetrievalFuture": Future<List<MinimalMedia>?,

currently working only with tv and movie media types
*/
class MinimalMediaListView extends GetView<MinimalMediaListViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        title: Text(controller.title),
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
                                controller.sortingMethodTexts[
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
                            i < controller.sortingMethodTexts.length;
                            i++)
                          PopupMenuItem(
                            value: Text(i.toString()),
                            child: Text(
                              controller.sortingMethodTexts[i],
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
                  () => controller.mediaListFetchingStatus.value == false
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          child: ListView.builder(
                            itemCount: controller.mediaList.length,
                            itemBuilder: (context, index) {
                              return MinimalMediaTile(
                                media: controller.mediaList[index],
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