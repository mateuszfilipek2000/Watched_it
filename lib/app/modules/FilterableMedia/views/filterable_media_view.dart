import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/available_watchlist_sorting_options.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/modules/FilterableMedia/controllers/filterable_media_view_controller.dart';
import 'package:watched_it_getx/app/shared_widgets/section.dart';

class FilterableMediaView extends StatelessWidget {
  FilterableMediaView(
      {required String title,
      required List<String> sortingOptions,
      required List<String> buttonTitles,
      required Future<Map<String, dynamic>?> Function(
              int, MediaType, AvailableWatchListSortingOptions)
          getMoreObjects})
      : controller = Get.put(FilterableMediaViewController(
          title: title,
          sortingOptions: sortingOptions,
          getMoreObjects: getMoreObjects,
          buttonTitles: buttonTitles,
        ));

  final FilterableMediaViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.title,
        ),
      ),
      body: Container(
        // isFirst: true,
        margin: EdgeInsets.all(10),
        //padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
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
                      children: <TextButton>[
                        for (var i = 0; i < controller.buttonTitles.length; i++)
                          TextButton(
                            onPressed: () => controller.changeActiveMedia(i),
                            child: Text(
                              controller.buttonTitles[i],
                              style: TextStyle(
                                color: i == controller.activeMediaIndex.value
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                            ),
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
                                style: Theme.of(context).textTheme.button,
                              ),
                              Icon(
                                Icons.filter_alt_rounded,
                              ),
                            ],
                          ),
                          Obx(() => Text(
                                controller.sortingOptions[
                                    controller.activeSortingMethod.value],
                                style: Theme.of(context).textTheme.caption,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              )),
                        ],
                      ),
                      itemBuilder: (context) => <PopupMenuEntry<Text>>[
                        for (var i = 0;
                            i < controller.sortingOptions.length;
                            i++)
                          PopupMenuItem(
                            value: Text(i.toString()),
                            child: Text(
                              controller.sortingOptions[i],
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
                  () => controller.isLoadingResults.value == true
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          child: ListView.builder(
                            itemCount: controller.results.length,
                            itemBuilder: (context, index) {
                              return Material(
                                color: Theme.of(context).primaryColor,
                                child: ListTile(
                                  leading: controller
                                              .results[index].imagePath ==
                                          null
                                      ? null
                                      : Image.network(
                                          controller.results[index].imagePath!,
                                        ),
                                  title: Text(controller.results[index].title),
                                  isThreeLine:
                                      controller.results[index].subtitle !=
                                          null,
                                  subtitle: Text(
                                    controller.results[index].subtitle!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  onTap: () =>
                                      controller.getToMediaDetails(index),
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

// class MediaButton extends StatelessWidget {
//   const MediaButton({
//     Key? key,
//     required this.text,
//     required this.id,
//     required this.color,
//     required this.onPressed,
//   }) : super(key: key);

//   final String text;
//   final int id;
//   final Color color;
//   final Function(int) onPressed;
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: () => this.onPressed(this.id),
//       child: Text(
//         this.text,
//         style: TextStyle(
//           color: this.color,
//         ),
//       ),
//     );
//   }
// }
