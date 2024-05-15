import 'package:dbs_frontend/Themes/AppTextStyle.dart';
import 'package:dbs_frontend/pages/SuccessScreen/successController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

class SuccessAnimationPage extends StatelessWidget {
  final SuccessAnimationController controller =
      Get.put(SuccessAnimationController());

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    print(screenWidth);
    var screenHeight = MediaQuery.of(context).size.height;
    var size = screenWidth < screenHeight ? screenWidth : screenHeight;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Booking Successful'),
      // ),
      body: Center(
        child: Padding(
          padding:
              // screenWidth < 300
              //     ? const EdgeInsets.fromLTRB(0, 0, 0, 0):
              const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/Animations/success2.json', // Replace with your animation asset
                width: size * 0.8,
                height: size * 0.8,
                repeat: true, // Adjust animation properties as needed
                reverse: false,
                animate: true,
                onLoaded: (composition) {
                  // The onLoaded callback is called when the animation is loaded
                  // Calculate the duration of the animation and use it to delay navigation
                  Future.delayed(
                      Duration(
                          milliseconds: composition.duration.inMilliseconds),
                      () {
                    // After the animation duration, navigate to orders page
                    controller.navigateToOrdersPage();
                  });
                },
              ),
              SizedBox(height: 16),
              Obx(
                () => Container(
                  width: screenWidth * 0.7,
                  child: Center(
                    child: Text(
                      '${controller.successMessage.value}', // Your success message
                      style: AppTextStyles.mediumHeadingTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.04),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
