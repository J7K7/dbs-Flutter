// import 'dart:js';

import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/AppTextStyle.dart';
import 'package:dbs_frontend/pages/Login/controller.dart';
import 'package:dbs_frontend/pages/Register/screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Themes/Buttons.dart';
import '../../Themes/UiUtils.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:ums_demo/AppCommon/CommonFunctions.dart';
// import 'package:ums_demo/Themes/AppColors.dart';
// import 'package:ums_demo/Themes/UiUtils.dart';
// import 'package:get/get.dart';
// import 'package:ums_demo/pages/LoginScreen/CardWidget.dart';

// import 'package:ums_demo/Themes/Buttons.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  final _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            Get.back(); // Navigate back using GetX
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            vSpace(screenHeight * 0.19),
            Image.asset('assets/icons/logo.png',
                width: screenWidth * 0.2, height: screenHeight * 0.1),
            vSpace(screenHeight * 0.01),
            const Text(
              'WELCOME BACK',
              style: AppTextStyles.headingTextStyle,
            ),
            vSpace(screenHeight * 0.01),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(
                () => Form(
                  // key: formKey,
                  key: _controller.formKey,
                  child: Column(
                    children: [
                      vSpace(screenHeight * 0.03),
                      vSpace(screenHeight * 0.015),
                      TextFormField(
                        controller: _controller.txtEmail,
                        focusNode: _controller.focusNodes[0],
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: textInputDecoration('Email'),
                        validator: (value) => _controller.isValidEmail(),
                        onFieldSubmitted: (_) => fieldFocusChange(
                            context,
                            _controller.focusNodes[0],
                            _controller.focusNodes[1]),
                      ),
                      vSpace(screenHeight * 0.015),
                      Obx(
                        () => TextFormField(
                          controller: _controller.txtPassword,
                          focusNode: _controller.focusNodes[1],
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: textInputDecoration('Password',
                              trailing: IconButton(
                                  onPressed: _controller.showPassword,
                                  icon: _controller.obscureText.value
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility))),
                          obscureText: _controller.obscureText.value,
                          validator: (value) =>
                              value!.isEmpty ? "Enter Password!" : null,
                          onFieldSubmitted: (_) => fieldFocusChange(
                              context,
                              _controller.focusNodes[1],
                              _controller.focusNodes[2]),
                        ),
                      ),
                      vSpace(screenHeight * 0.020),
                      _controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : mainButton('LOGIN',
                              onPress: _controller.submitAndLogin,
                              focusNode: _controller.focusNodes[2],
                              color: primary100,
                              minSize: Size(Get.width, 50)),
                      vSpace(screenHeight * 0.02),
                      RichText(
                        text: TextSpan(
                          text: "Don't have an account ? ",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'REGISTER',
                              style: const TextStyle(
                                color: primary100,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(RegisterScreen());
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
