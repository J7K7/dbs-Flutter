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
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:dio/dio.dart'; // Import for MultipartFile
import 'package:http/http.dart' as http; // Import for MediaType
import 'package:http_parser/http_parser.dart';

class ProfileController extends GetxController {
  Rx<bool> isProfilePageLoading = false.obs;
  Rx<bool> isUpdateProfileLoading = false.obs;
  Rx<UserModel?> userData = Rx<UserModel?>(null);
  var profilePic = ''.obs;
  var profilePicMimeType = ''.obs;
  RxBool isEditing = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    isProfilePageLoading(true);
    ApiService.get(
      API_GETPROFILE,
      success: (data) async {
        // await Future.delayed(const Duration(seconds: 1));
        isProfilePageLoading(false);
        print("------ PROFILE DATA MALIIIII GAYOOOOO ------ ");
        print(data);
        print(data['response']['profilePic']);

        final user = UserModel.fromJson(data['response']);
        print("USer inside API call 2: ");
        print(user);

        userData.value = user;
        print(userData.value!.profilePic);

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

  Future<void> updateUserData(String? firstName, String? lastName,
      String? profilePic, BuildContext context) async {
    isUpdateProfileLoading(true);

    // if (firstName == null || lastName == null || profilePic == null) {
    //   showErrorToastMessage(context, 'All fields are required.');
    //   isUpdateProfileLoading(false);
    //   return;
    // }

    // FormData formData = FormData();

    // formData.fields.addAll({
    //   'firstName': firstName!,
    //   'lastName': lastName!,
    // } as Iterable<MapEntry<String, String>>);

    // String fileName = profilePic.path.split('/').last;
    // formData.files.add(MapEntry(
    //   'profilePic',
    //   await MultipartFile.fromPath(
    //     'profilePic',
    //     profilePic.path,
    //     filename: fileName,
    //   ),
    // ));

    dio.FormData? formData;

    formData = dio.FormData.fromMap({
      'firstName': firstName,
      'lastName': lastName,
      'profileImage': profilePic,
      'profilePic': ''
    });

    // if (profilePic.isNotEmpty) {
    //   String imageName = path.basename(imageFilePath.value);

    //   // debugPrint('Image ----------------- $imageName');

    print("profilePic : ");
    print(profilePic);

    String imageName = path.basename(profilePic!);

    // formData.files.add(MapEntry(
    //     'profileImage',
    //     await dio.MultipartFile.fromFile(profilePic!,
    //         contentType: MediaType('application', 'pdf'),
    //         filename: imageName)));
    // }
    print("profilePicMimeType : ");
    print(profilePicMimeType.value);
    print(MediaType('image', profilePicMimeType.value.split('/').last));
    formData.files.add(MapEntry(
      'profileImage',
      await dio.MultipartFile.fromFile(
        profilePic,
        contentType: MediaType(
            'image',
            profilePicMimeType.value
                .split('/')
                .last), // Set MIME type to image/jpeg
        filename: imageName,
      ),
    ));
    //   // debugPrint('Image ---------- Take Time');
    // }

    print(formData.fields);
    print(formData.files);

    ApiService.put(
      API_UPDATEPROFILE,
      formData: formData,
      success: (data) async {
        print("SUCESSS MA AIVU");
        print(data);

        final userDataMap = data['updatedUser'] as Map<String, dynamic>;
        print("userDataMap : ");
        print(userDataMap);
        final user = UserModel.fromJson(userDataMap);
        print("USER : ");
        print(userData);
        userData.value = user;

        // Show success message or navigate to another screen if needed
        showSuccessToastMessage(context, 'Profile updated successfully');
        isUpdateProfileLoading(false);
        // userData.clear();
        await fetchUserData();

        // You can also navigate to another screen after successful update
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AnotherScreen()));
      },
      failed: (data) {
        isUpdateProfileLoading(false);
        print("Failed to update profile data: $data");
        showErrorToastMessage(
            context, 'Failed to update profile. Please try again.');
      },
      error: (msg) {
        isUpdateProfileLoading(false);
        print("Error occurred while updating profile data: $msg");
        showErrorToastMessage(
            context, 'An error occurred. Please try again later.');
      },
    );
  }
}
