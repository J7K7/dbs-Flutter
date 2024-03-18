import 'package:dbs_frontend/Themes/AppTextStyle.dart';
import 'package:dbs_frontend/pages/Login/screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Themes/AppColors.dart';
import '../../Themes/Buttons.dart';
import '../../Themes/UiUtils.dart';
import './Controller.dart';

// import 'package:ums_demo/pages/SignInScreen/Controller.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  //Get.put(): This method creates a new instance of the specified controller and registers it with the GetX dependency injection system. If an instance of the controller already exists, it will replace it with the new one.

  // Get.find(): This method retrieves an existing instance of the specified controller from the GetX dependency injection system. If an instance of the controller doesn't exist, it will throw an error.

  final _controller = Get.put(RegisterController());
  // final _controller = Get.find<RegisterController>();

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
          children: [
            vSpace(screenHeight * 0.07),
            Image.asset('assets/icons/logo.png',
                width: screenWidth * 0.2, height: screenHeight * 0.1),
            vSpace(screenHeight * 0.01),
            const Text(
              'REGISTER',
              // style: TextStyle(
              //   fontSize: 32, // Adjust as needed
              //   fontWeight: FontWeight.bold,
              //   color: Colors.black,
              // ),

              style: AppTextStyles.headingTextStyle,
            ),
            vSpace(screenHeight * 0.01),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                // key: formKey,
                key: _controller.formKey,

                child: Column(
                  children: [
                    vSpace(screenHeight * 0.03),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _controller.txtFirstName,
                            focusNode: _controller.focusNodes[0],
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            decoration: textInputDecoration('First Name'),
                            validator: (value) =>
                                value!.isEmpty ? "Enter First Name" : null,
                            onFieldSubmitted: (_) => fieldFocusChange(
                                context,
                                _controller.focusNodes[0],
                                _controller.focusNodes[1]),
                          ),
                        ),
                        hSpace(screenWidth * 0.015),
                        Expanded(
                          child: TextFormField(
                            controller: _controller.txtLastName,
                            focusNode: _controller.focusNodes[1],
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            decoration: textInputDecoration('Last Name'),
                            validator: (value) =>
                                value!.isEmpty ? "Enter Last Name" : null,
                            onFieldSubmitted: (_) => fieldFocusChange(
                                context,
                                _controller.focusNodes[0],
                                _controller.focusNodes[1]),
                          ),
                        )
                      ],
                    ),
                    vSpace(screenHeight * 0.015),
                    TextFormField(
                      controller: _controller.txtEmail,
                      focusNode: _controller.focusNodes[2],
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: textInputDecoration('Email'),
                      validator: (value) => _controller.isValidEmail(),
                      onFieldSubmitted: (_) => fieldFocusChange(context,
                          _controller.focusNodes[1], _controller.focusNodes[2]),
                    ),
                    vSpace(screenHeight * 0.015),
                    TextFormField(
                      controller: _controller.txtMobileNo,
                      focusNode: _controller.focusNodes[3],
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      decoration: textInputDecoration('Mobile No'),
                      validator: (value) => _controller.validateMobile(),
                      onFieldSubmitted: (_) => fieldFocusChange(context,
                          _controller.focusNodes[2], _controller.focusNodes[3]),
                    ),
                    vSpace(screenHeight * 0.015),
                    Obx(
                      () => TextFormField(
                        controller: _controller.txtPassword,
                        focusNode: _controller.focusNodes[4],
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
                            value!.isEmpty ? "Enter Password" : null,
                        onFieldSubmitted: (_) => fieldFocusChange(
                            context,
                            _controller.focusNodes[4],
                            _controller.focusNodes[5]),
                      ),
                    ),
                    vSpace(screenHeight * 0.015),
                    // Obx(
                    //   () =>
                    TextFormField(
                      controller: _controller.txtConfirmPassword,
                      focusNode: _controller.focusNodes[5],
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: textInputDecoration('Confirm Password'),
                      obscureText: true,
                      validator: (String? confirmPassword) {
                        if (confirmPassword == null ||
                            confirmPassword.isEmpty) {
                          return "Enter Password";
                        }

                        if (confirmPassword !=
                            _controller.txtPassword.value.text) {
                          return "Passwords do not match.";
                        }

                        return null;
                      },
                      onFieldSubmitted: (_) => fieldFocusChange(context,
                          _controller.focusNodes[4], _controller.focusNodes[5]),
                    ),
                    // ),
                    vSpace(screenHeight * 0.020),
                    _controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : mainButton('REGISTER',
                            onPress: _controller.submitAndSignIn,
                            focusNode: _controller.focusNodes[6],
                            color: primary100,
                            minSize: Size(Get.width, 50)),

                    vSpace(screenHeight * 0.02),
                    RichText(
                      text: TextSpan(
                        text: 'Already have an account ? ',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'LOGIN',
                            style: const TextStyle(
                              color: primary100,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(LoginScreen());
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
