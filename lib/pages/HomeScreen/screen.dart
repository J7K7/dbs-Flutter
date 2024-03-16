import 'package:dbs_frontend/Themes/AppTextStyle.dart';
import 'package:dbs_frontend/Themes/Buttons.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:dbs_frontend/pages/SplashScreen/Controller.dart';
import 'package:dbs_frontend/pages/ViewAllProducts/screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:ums_demo/pages/SplashScreen/Controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  // final _controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Home Screen'), automaticallyImplyLeading: false),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'DBS Home Page',
            style: AppTextStyles.subheadingTextStyle,
          ),
          mainButton("View All Products", onPress: () {
            Get.to(ViewAllProducts());
          }),
        ],
      ),
    );
  }
}
