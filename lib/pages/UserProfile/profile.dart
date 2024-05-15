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

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    final profileController = Get.put(ProfileController());
    // final user = profileController.userData;
    print("user : ");
    print(profileController.userData.value?.profilePic);

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
                  // CircleAvatar(
                  //   radius: (screenWidth * 0.15).clamp(10, 100),
                  //   // // backgroundImage: AssetImage('assets/images/champaklal.jpg'),
                  //   backgroundImage:
                  //       AssetImage('assets/images/profileCheAA.png'),
                  // ),

                  // CircleAvatar(
                  //   radius: (screenWidth * 0.15).clamp(10, 100),
                  //   backgroundImage: () {
                  //     final user = profileController.userData.value;
                  //     if (user != null && user.profilePic != null) {
                  //       return NetworkImage(user.profilePic.toString());
                  //     } else {
                  //       return AssetImage('assets/images/error_image.png');
                  //     }
                  //   }(),
                  // ),
                  Container(
                    width: (screenWidth * 0.3)
                        .clamp(50, 150), // Adjust width as needed
                    height: (screenWidth * 0.3)
                        .clamp(50, 150), // Adjust height as needed
                    child: ClipOval(
                      child: CircleAvatar(
                        radius: (screenWidth * 0.3).clamp(50, 150) /
                            2, // Radius is half of width or height
                        backgroundColor: Colors
                            .transparent, // Transparent background to prevent white border
                        child: profileController.userData.value?.profilePic !=
                                null
                            ? getImageWidget(
                                profileController.userData.value?.profilePic,
                                isUser: true)
                            : errorImageWidget(),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 3.0, // Adjust positioning as needed
                    right: 3.0, // Adjust positioning as needed
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // White background for icon
                        shape: BoxShape.circle, // Make it a circle
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(4.0), // Padding for icon
                        child: Icon(
                          Icons.edit,
                          size: 18.0, // Adjust icon size as needed
                          color: Colors.grey.shade800, // Icon color
                        ),
                      ),
                    ),
                  ),
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
            // Personal Information Section
            Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth * 0.15, 0, 0, 0),
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Name'),
                      subtitle: Obx(() {
                        final user = profileController.userData.value;
                        print("AYA ");
                        print(user);
                        return Text(
                            '${user?.firstName ?? ''} ${user?.lastName ?? ''}');
                      }),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth * 0.15, 0, 0, 0),
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
                    padding: EdgeInsets.fromLTRB(screenWidth * 0.15, 0, 0, 0),
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
            ),
            SizedBox(height: 20),

            Container(
              width: screenWidth * 0.55,
              child: mainButton(
                'LOGOUT',
                onPress: () {
                  SharedPrefs.clearAllData();
                  print("Logout");
                  Get.offAll(LandingScreen());
                },
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
