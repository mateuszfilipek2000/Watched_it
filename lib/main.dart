import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Watched It",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

extension leadingZeros on int {
  String addLeadingZeros(int numberOfTotalDigits) =>
      this.toString().padLeft(numberOfTotalDigits, '0');
}
