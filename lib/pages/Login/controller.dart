import 'package:dbs_frontend/AppCommon/ApiService.dart';
import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:dbs_frontend/Utilities/SharedPreferences.dart';
import 'package:dbs_frontend/pages/HomeScreen/homePage.dart';
import 'package:dbs_frontend/pages/BottomNavigationBar/screen.dart';
import 'package:dbs_frontend/pages/SplashScreen/Controller.dart';
import 'package:dbs_frontend/pages/SplashScreen/Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var obscureText = true.obs;
  var isLoading = false.obs;

  final formKey = GlobalKey<FormState>();
  final focusNodes = List.generate(3, (index) => FocusNode());

  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();
  SplashController splashCtrl = Get.find();

  @override
  void onInit() {
    // txtEmail.text = 'abc@gmail.com';
    // txtPassword.text = '123456';
    super.onInit();
  }

  void showPassword() {
    obscureText(!obscureText.value);
    update();
  }

  String? isValidEmail() {
    var ans = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (txtEmail.text.isEmpty) {
      return 'Enter Email Address!';
    } else if (ans.hasMatch(txtEmail.text)) {
      return null;
    }
    return 'Enter Valid Email Address!';
  }

  void submitAndLogin() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Map<String, dynamic> mapParam = {
        'email': txtEmail.text.trim(),
        'password': txtPassword.text.trim()
      };
      callAPILoginUser(mapParam);
    }
  }

  void callAPILoginUser(Map<String, dynamic> param) async {
    isLoading(true);
    print(param);
    ApiService.post(
      API_LOGIN,
      param: param,
      success: (data) async {
        print("Me login ho chuka hu");
        print(data['response']['token']);
        SharedPrefs.setCustomObject(LOGINDATA, data['response']);
        print(SharedPrefs.getCustomObject(LOGINDATA));
        txtEmail.clear();
        txtPassword.clear();
        // Get.offAll(() => NavigationDrawerShow());
        // Get.offAll(() => HomeScreen());
        await splashCtrl.fetchHomePageData();
        // await Future.delayed(const Duration(seconds: 1));
        isLoading(false);

        Get.offAll(() => HomeScreen(), transition: Transition.cupertino);

        return;
      },
      failed: (data) {
        isLoading(false);
        showGetXBar(data["msg"]);
        debugPrint(data);
        return;
      },
      error: (msg) {
        isLoading(false);
        showGetXBar('Provided Email or Password is incorrect.');
        debugPrint(msg);
        return;
      },
    );
  }
}
