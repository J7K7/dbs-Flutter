import 'dart:async';
import 'package:dbs_frontend/pages/HomeScreen/screen.dart';
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
    // await SharedPrefs.init(); // Ensure _prefsInstance is initialized

    Future.delayed(const Duration(seconds: 5), () {
      Get.to(() => HomeScreen());
    });
  }
}
