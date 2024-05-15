import 'package:dbs_frontend/Themes/AppTextStyle.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:dbs_frontend/pages/SplashScreen/Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:ums_demo/pages/SplashScreen/Controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final _controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => Opacity(
                opacity: _controller.opacity.value,
                child:
                    const Text('DBS', style: AppTextStyles.headingTextStyle)),
          ),
          Center(
            child: Text(
              'DYNAMIC BOOKING SYSTEM',
              style: AppTextStyles.subheadingTextStyle
                  .copyWith(fontSize: screenWidth * 0.035),
            ),
          ),
          spinKitWidgetWaveSpinner(),
        ],
      ),
    );
  }
}
