import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:watched_it_getx/app/modules/splash_screen/controllers/login_controller.dart';

class AnimatedLoginButtonView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedLoginButtonView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AnimatedLoginButtonView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
