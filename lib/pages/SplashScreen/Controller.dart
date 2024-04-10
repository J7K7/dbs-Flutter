import 'dart:async';
import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:dbs_frontend/Utilities/SharedPreferences.dart';
import 'package:dbs_frontend/pages/ErrorPage.dart';
import 'package:dbs_frontend/pages/HomeScreen/homePage.dart';
import 'package:dbs_frontend/pages/HomeScreen/homePageController.dart';
import 'package:dbs_frontend/pages/BottomNavigationBar/screen.dart';
import 'package:dbs_frontend/pages/LandingPage/screen.dart';
import 'package:dbs_frontend/pages/Login/screen.dart';
import 'package:dbs_frontend/pages/SplashScreen/Screen.dart';
import 'package:dbs_frontend/pages/searchProducts/screen.dart';
// import '../HomeScreen/homePageController.dart';

// import 'package:dbs_frontend/pages/searchProducts/screen.dart';
import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  var opacity = 0.2.obs;
  Timer? _timer;
  int _secondsRemaining = 4;
  int _failedAttempts = 0;
  Rx<bool> isHomePageLoading = false.obs;
  // HomePageController saduName = Get.find<HomePageController>();
  // final homePageController = Get.put(HomePageController());

  // print(saduName.)
  @override
  void onInit() {
    super.onInit();
    print("Splash controller onInit ma aiva");
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
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
  // initializePreferences();

  Future<void> initializePreferences() async {
    print("initializePreferences");
    await SharedPrefs.init(); // Ensure _prefsInstance is initialized
    String businessCategoryId = '1';
    SharedPrefs.setString(CATEGORYID, businessCategoryId);

    // Initialize HomePageController before fetching data
    Get.put(HomePageController());

    // Fetch data before navigating

    print("initializePreferences ni conditon pela ");
    if (SharedPrefs.isContains(LOGINDATA)) {
      // SharedPrefs.clearAllData();
      isHomePageLoading(true);
      await fetchHomePageData();
      isHomePageLoading(false);
      // This delay is needed for fetching the products data
      print("aapdu here");
      Get.offAll(() => HomeScreen());
    } else {
      print("aapdu Rhere else");
      // await Future.delayed(const Duration(seconds: 1));

      Get.offAll(() => HomeScreen());
    }
  }

// Function to restart the application
  void restartApplication() {
    // Increment the failed attempts counter
    _failedAttempts++;

    print("_failedAttempts");
    print(_failedAttempts);
    // Check if failed attempts exceed 2
    if (_failedAttempts > 2) {
      // If exceeded, navigate to the error page
      Get.off(() => ErrorPage());
      print("FAILED BHAI FAILEDD RETRY PACHI BHIIIII");
    } else {
      // If not exceeded, restart the application
      Get.off(() => SplashScreen());
      onInit();
    }
  }

  Future<void> fetchHomePageData() async {
    await Get.find<HomePageController>().getAllCategories();
    await Get.find<HomePageController>().fetchPopularProducts();
    await Get.find<HomePageController>().getAllLatestProductsByCategories(-1);
    // await Future.delayed(const Duration(seconds: 1));
  }
}
