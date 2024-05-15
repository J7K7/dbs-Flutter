import 'package:dbs_frontend/AppCommon/ApiService.dart';
import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:dbs_frontend/Utilities/SharedPreferences.dart';
import 'package:dbs_frontend/models/UserModel.dart';
import 'package:dbs_frontend/pages/HomeScreen/homePage.dart';
import 'package:dbs_frontend/pages/BottomNavigationBar/screen.dart';
import 'package:dbs_frontend/pages/SplashScreen/Controller.dart';
import 'package:dbs_frontend/pages/SplashScreen/Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Rx<bool> isProfilePageLoading = false.obs;
  Rx<UserModel?> userData = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void fetchUserData() async {
    isProfilePageLoading(true);
    ApiService.get(
      API_GETPROFILE,
      success: (data) async {
        // await Future.delayed(const Duration(seconds: 1));
        isProfilePageLoading(false);
        print("------ PROFILE DATA MALIIIII GAYOOOOO ------ ");
        print(data);

        final userDataMap = data['response'] as Map<String, dynamic>;
        print("USer inside API call : ");
        print(userDataMap);
        final user = UserModel.fromJson(userDataMap);
        print("USer inside API call : ");
        print(user);
        userData.value = user;
        return;
      },
      failed: (data) {
        isProfilePageLoading(false);
        print("------ PROFILE DATA NAHI MAILOOOO  ------ ");
        print(data);
        return;
      },
      error: (msg) {
        isProfilePageLoading(false);
        print("------ PROFILE DATA MAA AVI GAI  ERROR  ------ ");
        print(msg);
        return;
      },
    );
  }
}
