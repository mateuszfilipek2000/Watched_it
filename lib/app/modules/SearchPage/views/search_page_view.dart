import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_page_controller.dart';

class SearchPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<SearchPageController>(
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
                      flex: 8,
                      child: Container(
                        margin: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        child: TextFormField(
                          decoration: InputDecoration(
                            focusColor: Colors.white,
                            hintText: _.searchInputHint.value,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.search_outlined,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
