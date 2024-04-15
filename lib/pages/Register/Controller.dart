import 'package:dbs_frontend/pages/BottomNavigationBar/screen.dart';
import 'package:dbs_frontend/pages/Login/screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../AppCommon/ApiService.dart';
// import 'package:ums_demo/AppCommon/CommonFunctions.dart';
import '../../Themes/AppStrings.dart';
// import 'package:dio/dio.dart' as dio;
import '../../Themes/UiUtils.dart';

class RegisterController extends GetxController {
  var obscureText = true.obs;
  var isLoading = false.obs;
  var imageFilePath = ''.obs;

  final formKey = GlobalKey<FormState>();
  final focusNodes = List.generate(8, (index) => FocusNode());

  final txtFirstName = TextEditingController();
  final txtLastName = TextEditingController();
  final txtEmail = TextEditingController();
  final txtMobileNo = TextEditingController();
  final txtPassword = TextEditingController();
  final txtConfirmPassword = TextEditingController();

  void showPassword() {
    obscureText(!obscureText.value);
    update();
  }

  // void getImage() async{
  //   final imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if(imageFile != null){
  //     imageFilePath.value = imageFile.path;
  //   }
  //   debugPrint('Image ------- ${imageFilePath.value}');
  // }

  String? isValidEmail() {
    var ans = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (txtEmail.text.isEmpty) {
      return 'Enter Email Address';
    } else if (ans.hasMatch(txtEmail.text)) {
      return null;
    }
    return 'Enter Valid Email Address';
  }

  String? validateMobile() {
    RegExp regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10}$)');
    if (txtMobileNo.text.isEmpty) {
      return 'Enter Mobile Number';
    } else if (!regExp.hasMatch(txtMobileNo.text)) {
      return 'Enter Valid Mobile Number';
    }
    return null;
  }

  void submitAndSignIn() async {
    print("me 61 line pe hu");
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      // dio.FormData? formData;

      // formData = dio.FormData.fromMap({
      //   'email': txtEmail.text,
      //   'password': txtPassword.text,
      //   'phoneNumber': txtMobileNo.text,
      //   'firstName': txtFirstName.text,
      //   'lastName': txtLastName.text,
      //   // 'image': imageFilePath,
      //   // 'dob': txtDob.text,
      // });

      Map<String, dynamic> mapParam = {
        'email': txtEmail.text,
        'password': txtPassword.text,
        'phoneNumber': txtMobileNo.text,
        'firstName': txtFirstName.text,
        'lastName': txtLastName.text,
      };

      // if (imageFilePath.value.isNotEmpty) {
      //   String imageName = path.basename(imageFilePath.value);

      //   // debugPrint('Image ----------------- $imageName');

      //   formData.files.add(MapEntry(
      //       'image',
      //       await dio.MultipartFile.fromFile(imageFilePath.value,
      //           filename: imageName)));

      //   // debugPrint('Image ---------- Take Time');
      // }

      // print("Data : ");
      // print(formData.fields);
      callAPISignInUser(mapParam);
    }
  }

  void callAPISignInUser(Map<String, dynamic> param) {
    isLoading(true);

    // print("API_REGISTER");
    // print(API_REGISTER);

    // print("response");
    // print(Response)

    ApiService.post(API_REGISTER,
        // 'user/register',
        param: param, success: (data) async {
      // txtFirstName.clear();
      // txtLastName.clear();
      // txtEmail.clear();
      // txtPassword.clear();
      // txtConfirmPassword.clear();
      // txtMobileNo.clear();

      // txtDob.clear();
      // imageFilePath.value = '';
      isLoading(false);

      // This will change ------------
      Get.offAll(() => LoginScreen(), transition: Transition.cupertino);
    }, failed: (data) {
      // print("Inside failed callback ");
      // print(data);
      isLoading(false);
      showGetXBar(data["msg"]);
      // debugPrint(data);
    }, error: (msg) {
      // print("Error : ");
      // print(msg);
      // print();
      isLoading(false);
      showGetXBar('Provided data is incorrect. + $msg');
      debugPrint(msg);
    });
  }
}
