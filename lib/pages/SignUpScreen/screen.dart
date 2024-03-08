import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Themes/AppColors.dart';
import '../../Themes/Buttons.dart';
import '../../Themes/UiUtils.dart';
// import 'package:ums_demo/pages/SignInScreen/Controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  // final _controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('REGISTER' ),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:

                // Obx(
                // () =>

                Form(
              // key: _controller.formKey,
              child: Column(
                children: [
                  vSpace(40),

                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          // controller: _controller.txtName,
                          // focusNode: _controller.focusNodes[0],
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          // decoration: textInputDecoration('Name'),
                          decoration: textInputDecoration('First Name'),
                          validator: (value) =>
                              value!.isEmpty ? "Enter First Name!" : null,
                          // onFieldSubmitted: (_) => fieldFocusChange(context,
                          //     _controller.focusNodes[0], _controller.focusNodes[1]),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          // controller: _controller.txtName,
                          // focusNode: _controller.focusNodes[0],
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          // decoration: textInputDecoration('Name'),
                          decoration: textInputDecoration('Last Name'),
                          validator: (value) =>
                              value!.isEmpty ? "Enter Last Name!" : null,
                          // onFieldSubmitted: (_) => fieldFocusChange(context,
                          //     _controller.focusNodes[0], _controller.focusNodes[1]),
                        ),
                      )
                    ],
                  ),

                  vSpace(10),
                  TextFormField(
                    // controller: _controller.txtEmail,
                    // focusNode: _controller.focusNodes[1],
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: textInputDecoration('Email'),
                    // validator: (value) => _controller.isValidEmail(),
                    // onFieldSubmitted: (_) => fieldFocusChange(context,
                    //     _controller.focusNodes[1], _controller.focusNodes[2]),
                  ),
                  vSpace(10),
                  TextFormField(
                    // controller: _controller.txtMobileNo,
                    // focusNode: _controller.focusNodes[2],
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    decoration: textInputDecoration('Mobile No'),
                    // validator: (value) => _controller.validateMobile(),
                    // onFieldSubmitted: (_) => fieldFocusChange(context,
                    //     _controller.focusNodes[2], _controller.focusNodes[3]),
                  ),
                  vSpace(10),

                  // Obx(
                  //   () =>

                  TextFormField(
                    // controller: _controller.txtPassword,
                    // focusNode: _controller.focusNodes[4],
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: textInputDecoration(
                      'Password',
                      // trailing: IconButton(
                      //     onPressed: _controller.showPassword,
                      //     icon: _controller.obscureText!.value
                      //         ? const Icon(Icons.visibility_off)
                      //         : const Icon(Icons.visibility))
                    ),
                    // obscureText: _controller.obscureText.value,
                    validator: (value) =>
                        value!.isEmpty ? "Enter Password!" : null,
                    // onFieldSubmitted: (_) => fieldFocusChange(
                    //     context,
                    //     _controller.focusNodes[4],
                    //     _controller.focusNodes[5]),
                  ),
                  // ),
                  vSpace(10),

                  // Obx(
                  //   () =>

                  TextFormField(
                    // controller: _controller.txtPassword,
                    // focusNode: _controller.focusNodes[4],
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: textInputDecoration(
                      'Confirm Password',
                      // trailing: IconButton(
                      //     onPressed: _controller.showPassword,
                      //     icon: _controller.obscureText!.value
                      //         ? const Icon(Icons.visibility_off)
                      //         : const Icon(Icons.visibility))
                    ),
                    // obscureText: _controller.obscureText.value,
                    validator: (value) =>
                        value!.isEmpty ? "Enter Confirm Password!" : null,
                    // onFieldSubmitted: (_) => fieldFocusChange(
                    //     context,
                    //     _controller.focusNodes[4],
                    //     _controller.focusNodes[5]),
                  ),
                  // ),

                  vSpace(10),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     textButton('Profile Image',
                  //         onPress: _controller.getImage,
                  //         focusNode: _controller.focusNodes[5]),
                  //     _controller.imageFilePath!.isNotEmpty
                  //         ? SizedBox(
                  //             width: 100,
                  //             height: 100,
                  //             child: ClipOval(
                  //               child: Image.file(
                  //                   File(_controller.imageFilePath!.value),
                  //                   fit: BoxFit.cover),
                  //             ),
                  //           )
                  //         : const SizedBox(),
                  //   ],
                  // ),
                  vSpace(10),
                  // _controller.isLoading.value
                  //     ? const CircularProgressIndicator()
                  //     : mainButton('Sign Up',
                  //         onPress: _controller.submitAndSignIn,
                  //         focusNode: _controller.focusNodes[6],
                  //         color: kPrimaryColor,
                  //         minSize: Size(Get.width, 50)),

                  mainButton('REGISTER', onPress: () {
                    print(
                        'Button pressed'); // Print statement inside onPressed method
                  }, color: primary100, padding: EdgeInsets.all(10)),
                ],
              ),
            ),
            // ),
          ),
        ),
      ),
    );
  }
}
