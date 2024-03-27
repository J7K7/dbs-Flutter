import 'dart:async';
import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:dbs_frontend/Utilities/SharedPreferences.dart';
import 'package:dbs_frontend/pages/HomeScreen/homePage.dart';
import 'package:dbs_frontend/pages/HomeScreen/screen.dart';
import 'package:dbs_frontend/pages/LandingPage/screen.dart';
import 'package:dbs_frontend/pages/Login/screen.dart';
import 'package:dbs_frontend/pages/ViewAllProducts/screen.dart';
import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  var opacity = 0.2.obs;
  Timer? _timer;
  int _secondsRemaining = 4;

  @override
  void onInit() {
    super.onInit();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      // Update the opacity value every second
      opacity(opacity.value + 0.2);
      _secondsRemaining--;

      // Check if 5 seconds have elapsed, and stop the timer
      if (_secondsRemaining == 0) {
        _timer?.cancel();
      }
    });
    initializePreferences();
  }

  Future<void> initializePreferences() async {
    await SharedPrefs.init(); // Ensure _prefsInstance is initialized
    String xyz = '2';
    SharedPrefs.setString(CATEGORYID, xyz);

    Future.delayed(const Duration(seconds: 1), () {
      if (SharedPrefs.isContains(LOGINDATA)) {
        Get.to(() => HomeScreen());
      } else {
        Get.to(() => LandingScreen());
      }
    });
  }
}
