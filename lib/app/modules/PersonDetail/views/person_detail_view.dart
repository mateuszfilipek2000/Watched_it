import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/person_detail_controller.dart';

class PersonDetailView extends GetView<PersonDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PersonDetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PersonDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
