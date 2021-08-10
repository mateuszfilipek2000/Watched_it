import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:watched_it_getx/app/shared_widgets/minimal_media_tile.dart';

import '../controllers/search_page_controller.dart';

class SearchPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchPageController>(
      init: SearchPageController(),
      builder: (_) {
        return SafeArea(
          child: Column(
            children: [
              Container(
                height: 70,
                color: Colors.black38,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        child: TextField(
                          onChanged: (String val) =>
                              _.handleControllerTextChange(val),
                          //autofocus: true,
                          autocorrect: true,
                          controller: _.searchFieldController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.search_outlined),
                            focusColor: Colors.white,
                            hintText: _.searchInputHint.value,
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _.searchResults.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.all(5),
                        child: MinimalMediaTile(
                          media: _.searchResults[index],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
