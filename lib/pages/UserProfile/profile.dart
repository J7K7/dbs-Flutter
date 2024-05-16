import 'dart:ffi';
import 'dart:io';

import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/Buttons.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:dbs_frontend/Utilities/SharedPreferences.dart';
import 'package:dbs_frontend/pages/LandingPage/screen.dart';
import 'package:dbs_frontend/pages/UserProfile/profileController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:mime/mime.dart';

// class ProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     var screenHeight = MediaQuery.of(context).size.height;

//     final profileController = Get.put(ProfileController());
//     // final user = profileController.userData;
//     print("user : ");
//     print(profileController.userData.value?.profilePic);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'PROFILE',
//           style: TextStyle(
//             fontSize: (screenWidth * 0.035).clamp(10, 20),
//             letterSpacing: 1.5,
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: EdgeInsets.fromLTRB(0, screenHeight * 0.07, 0, 0),
//               child: Stack(
//                 children: [
//                   // CircleAvatar(
//                   //   radius: (screenWidth * 0.15).clamp(10, 100),
//                   //   // // backgroundImage: AssetImage('assets/images/champaklal.jpg'),
//                   //   backgroundImage:
//                   //       AssetImage('assets/images/profileCheAA.png'),
//                   // ),

//                   // CircleAvatar(
//                   //   radius: (screenWidth * 0.15).clamp(10, 100),
//                   //   backgroundImage: () {
//                   //     final user = profileController.userData.value;
//                   //     if (user != null && user.profilePic != null) {
//                   //       return NetworkImage(user.profilePic.toString());
//                   //     } else {
//                   //       return AssetImage('assets/images/error_image.png');
//                   //     }
//                   //   }(),
//                   // ),
//                   Container(
//                     width: (screenWidth * 0.3)
//                         .clamp(50, 150), // Adjust width as needed
//                     height: (screenWidth * 0.3)
//                         .clamp(50, 150), // Adjust height as needed
//                     child: ClipOval(
//                       child: CircleAvatar(
//                         radius: (screenWidth * 0.3).clamp(50, 150) /
//                             2, // Radius is half of width or height
//                         backgroundColor: Colors
//                             .transparent, // Transparent background to prevent white border
//                         child: profileController.userData.value?.profilePic !=
//                                 null
//                             ? getImageWidget(
//                                 profileController.userData.value?.profilePic,
//                                 isUser: true)
//                             : errorImageWidget(),
//                       ),
//                     ),
//                   ),

//                   Positioned(
//                     bottom: 3.0, // Adjust positioning as needed
//                     right: 3.0, // Adjust positioning as needed
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white, // White background for icon
//                         shape: BoxShape.circle, // Make it a circle
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.all(4.0), // Padding for icon
//                         child: Icon(
//                           Icons.edit,
//                           size: 18.0, // Adjust icon size as needed
//                           color: Colors.grey.shade800, // Icon color
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: 20),
//             Text(
//               '${profileController.userData.value?.firstName ?? ''} ${profileController.userData.value?.lastName ?? ''}',
//               style: TextStyle(
//                 fontSize: (screenWidth * 0.035).clamp(10, 24),
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 20),

//             Container(
//               width: screenWidth * 0.25,
//               child: mainOutLinedButton(
//                 'EDIT PROFILE',
//                 onPress: () {
//                   SharedPrefs.clearAllData();
//                   print("Edit profile clicked ");
//                   Get.offAll(LandingScreen());
//                 },
//               ),
//             ),
//             SizedBox(height: 20),

//             // Personal Information Section
//             Center(
//               child: Column(
//                 // mainAxisAlignment: MainAxisAlignment.center,
//                 // crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(screenWidth * 0.15, 0, 0, 0),
//                     child: ListTile(
//                       leading: Icon(Icons.person),
//                       title: Text('Name'),
//                       subtitle: Obx(() {
//                         final user = profileController.userData.value;
//                         print("AYA ");
//                         print(user);
//                         return Text(
//                             '${user?.firstName ?? ''} ${user?.lastName ?? ''}');
//                       }),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(screenWidth * 0.15, 0, 0, 0),
//                     child: ListTile(
//                       leading: Icon(Icons.email),
//                       title: Text('Email'),
//                       subtitle: Obx(() {
//                         final user = profileController.userData.value;
//                         return Text('${user?.email ?? ''}');
//                       }),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(screenWidth * 0.15, 0, 0, 0),
//                     child: ListTile(
//                       leading: Icon(Icons.phone),
//                       title: Text('Phone'),
//                       subtitle: Obx(() {
//                         final user = profileController.userData.value;
//                         return Text('+91 ${user?.phoneNumber ?? ''}');
//                       }),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),

//             Container(
//               width: screenWidth * 0.55,
//               child: mainButton(
//                 'LOGOUT',
//                 onPress: () {
//                   SharedPrefs.clearAllData();
//                   print("Logout");
//                   Get.offAll(LandingScreen());
//                 },
//               ),
//             ),
//             SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }
// }
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    final profileController = Get.put(ProfileController());

    final ImagePicker _picker = ImagePicker();
    print("profileController.profilePic.value : ");
    print(profileController.profilePic.value);
    print(profileController.userData.value!.profilePic);

    // Future<void> _pickImageFromGallery(BuildContext context) async {
    //   final pickedFile = await _picker.pickImage(
    //     source: ImageSource.gallery,
    //     // imageQuality: 50, // Adjust image quality as needed
    //   );

    //   if (pickedFile != null) {
    //     // File selected
    //     print('Image selected: ${pickedFile.path}');
    //     print('Image selected mime: ${pickedFile.mimeType}');

    //     // Update profile picture
    //     final profileController = Get.find<ProfileController>();
    //     // final userData = profileController.userData.value;

    //     // if (userData != null) {
    //     //   // Update the profilePic field with the file path
    //     //   profileController.userData.value!.profilePic = pickedFile.path;

    //     //   // Now, you can update the UI with the selected image
    //     //   // If you're using GetX, the Obx widget will automatically update the UI
    //     // }

    //     profileController.profilePic.value = pickedFile.path;
    //   } else {
    //     // User canceled image selection
    //     print('No image selected');
    //   }
    // }
    Future<void> _pickImageFromGallery(BuildContext context) async {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        // File selected
        print('Image selected: ${pickedFile.path}');

        // Get the MIME type for the selected file
        final file = File(pickedFile.path);
        final mimeType = lookupMimeType(file.path);

        print("mimeType : ");
        print(mimeType);
        // Update profile picture with file path and MIME type
        final profileController = Get.find<ProfileController>();
        profileController.profilePic.value = pickedFile.path;
        profileController.profilePicMimeType.value = mimeType ?? '';

        // Now, you can update the UI with the selected image
        // If you're using GetX, the Obx widget will automatically update the UI
      } else {
        // User canceled image selection
        print('No image selected');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PROFILE',
          style: TextStyle(
            fontSize: (screenWidth * 0.035).clamp(10, 20),
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, screenHeight * 0.07, 0, 0),
              child: Stack(
                children: [
                  Container(
                    width: (screenWidth * 0.3).clamp(50, 150),
                    height: (screenWidth * 0.3).clamp(50, 150),
                    // child: Obx(
                    //   () => ClipOval(
                    //     // borderRadius: BorderRadius.circular(100),

                    //     child: profileController.userData.value!.profilePic !=
                    //             null
                    //         ? getImageWidget(
                    //             profileController.userData.value!.profilePic,
                    //             isUser: true)
                    //         : errorImageWidget(), // You can set a default image here
                    //   ),
                    // ),

                    child: Obx(
                      () => ClipOval(
                        child: profileController.profilePic.value != ''
                            ? Image.file(
                                File(profileController.profilePic.value!),
                                fit: BoxFit.cover,
                                width: (screenWidth * 0.3).clamp(50, 150),
                                height: (screenWidth * 0.3).clamp(50, 150),
                              )
                            : profileController.userData.value!.profilePic !=
                                    null
                                ? getImageWidget(
                                    profileController
                                        .userData.value!.profilePic,
                                    isUser: true)
                                : errorImageWidget(), // You can set a default image here
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 3.0,
                      right: 3.0,
                      child: Obx(() => profileController.isEditing!.value
                          ? GestureDetector(
                              onTap: () => _pickImageFromGallery(context),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.edit,
                                    size: 18.0,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                              ),
                            )
                          : vSpace(0))),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              '${profileController.userData.value?.firstName ?? ''} ${profileController.userData.value?.lastName ?? ''}',
              style: TextStyle(
                fontSize: (screenWidth * 0.035).clamp(10, 24),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: (screenWidth * 0.25).clamp(200, 600),
              child: Obx(() => profileController.isEditing.value
                  ? SizedBox()
                  : mainOutLinedButton(
                      'EDIT PROFILE',
                      onPress: () {
                        profileController.isEditing.value = true;
                      },
                    )),
            ),
            SizedBox(height: 20),
            Obx(() => profileController.isEditing.value
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Container(
                        width: screenWidth * 0.65,
                        child: Form(
                          child: Column(
                            children: [
                              TextFormField(
                                initialValue: profileController
                                        .userData.value?.firstName ??
                                    '',
                                decoration: InputDecoration(
                                  labelText: 'First Name',
                                  focusColor: primary100,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your first name';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  final userData =
                                      profileController.userData.value;
                                  if (userData != null) {
                                    // Access properties safely
                                    final lastName = userData.lastName;

                                    if (lastName != null) {
                                      profileController
                                          .userData.value!.firstName = value;
                                      // profileController.updateUserData(
                                      //   value,
                                      //   lastName,
                                      //   null,
                                      //   context,
                                      // );
                                    } else {
                                      print('Last name is null');
                                      // Handle the case where last name is null
                                    }
                                  } else {
                                    print('User data is null');
                                    // Handle the case where user data is null
                                  }
                                },
                              ),
                              TextFormField(
                                initialValue: profileController
                                        .userData.value?.lastName ??
                                    '',
                                decoration: InputDecoration(
                                  labelText: 'Last Name',
                                  focusColor: primary100,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your last name';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  profileController.userData.value?.lastName =
                                      value;
                                  // profileController.updateUserData(
                                  //     profileController
                                  //         .userData.value?.firstName,
                                  //     profileController
                                  //         .userData.value?.lastName,
                                  //     null,
                                  //     context);
                                },
                              ),
                              TextFormField(
                                readOnly: true,
                                initialValue:
                                    profileController.userData.value?.email ??
                                        '',
                                decoration: InputDecoration(labelText: 'Email'),
                                enabled: false,
                              ),
                              TextFormField(
                                readOnly: true,
                                initialValue: profileController
                                        .userData.value?.phoneNumber ??
                                    '',
                                decoration:
                                    InputDecoration(labelText: 'Phone Number'),
                                enabled: false,
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: (screenWidth * 0.35).clamp(300, 700),
                                child: mainButton(
                                  'UPDATE',
                                  onPress: () async {
                                    // Save changes and update the user's personal information
                                    // For simplicity, let's just print the updated values.
                                    print(
                                        'Updated First Name: ${profileController.userData.value?.firstName}');
                                    print(
                                        'Updated Last Name: ${profileController.userData.value?.lastName}');
                                    print(
                                        'Updated Email: ${profileController.userData.value?.email}');
                                    print(
                                        'Updated Phone: ${profileController.userData.value?.phoneNumber}');
                                    print(
                                        'Updated ProfilePic: ${profileController.profilePic.value}');
                                    // Set editing mode to false
                                    profileController.isEditing.value = false;
                                    await profileController.updateUserData(
                                      profileController
                                          .userData.value?.firstName,
                                      profileController
                                          .userData.value?.lastName,
                                      profileController.profilePic.value,
                                      context,
                                    );
                                  },
                                ),
                              ),
                              vSpace(20),
                              Container(
                                width: (screenWidth * 0.35).clamp(300, 700),
                                child: mainOutLinedButton(
                                  'DISCARD',
                                  onPress: () async {
                                    profileController.isEditing.value = false;
                                    await profileController.fetchUserData();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.fromLTRB(screenWidth * 0.15, 0, 0, 0),
                          child: ListTile(
                            leading: Icon(Icons.person),
                            title: Text('Name'),
                            subtitle: Obx(() {
                              final user = profileController.userData.value;
                              return Text(
                                  '${user?.firstName ?? ''} ${user?.lastName ?? ''}');
                            }),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding:
                              EdgeInsets.fromLTRB(screenWidth * 0.15, 0, 0, 0),
                          child: ListTile(
                            leading: Icon(Icons.email),
                            title: Text('Email'),
                            subtitle: Obx(() {
                              final user = profileController.userData.value;
                              return Text('${user?.email ?? ''}');
                            }),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding:
                              EdgeInsets.fromLTRB(screenWidth * 0.15, 0, 0, 0),
                          child: ListTile(
                            leading: Icon(Icons.phone),
                            title: Text('Phone'),
                            subtitle: Obx(() {
                              final user = profileController.userData.value;
                              return Text('+91 ${user?.phoneNumber ?? ''}');
                            }),
                          ),
                        ),
                      ],
                    ),
                  )),
            SizedBox(height: 20),
            Container(
                width: (screenWidth * 0.55).clamp(300, 700),
                child: Obx(
                  () => profileController.isEditing.value
                      ? vSpace(0)
                      : mainButton(
                          'LOGOUT',
                          onPress: () {
                            SharedPrefs.clearAllData();
                            print("Logout");
                            Get.offAll(LandingScreen());
                          },
                        ),
                )),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
