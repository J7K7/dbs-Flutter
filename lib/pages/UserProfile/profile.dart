import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/Buttons.dart';
import 'package:dbs_frontend/Utilities/SharedPreferences.dart';
import 'package:dbs_frontend/pages/LandingPage/screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Text editing controllers for form fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Reactive variable to track if form data is edited
  var isFormEdited = false.obs;

  @override
  void onInit() {
    // Set default values for the form fields
    firstNameController.text = 'Champaklal'; // Example default value
    lastNameController.text = 'Gada'; // Example default value
    emailController.text = 'champaklal@example.com'; // Example default value
    phoneController.text = '1234567890'; // Example default value
    super.onInit();
  }

  // Function to handle update button press
  void handleUpdate() {
    // Perform update action here
    print('Updating profile...');
    // Clear the form edited flag after updating
    isFormEdited.value = false;
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    // Get instance of ProfileController
    final ProfileController profileController = Get.put(ProfileController());

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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: (screenWidth * 0.15).clamp(10, 100),
                    backgroundImage: AssetImage('assets/images/champaklal.jpg'),
                  ),
                  Positioned(
                    bottom: 5.0, // Adjust positioning as needed
                    right: 5.0, // Adjust positioning as needed
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // White background for icon
                        shape: BoxShape.circle, // Make it a circle
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(2.0), // Padding for icon
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

              SizedBox(height: 20),
              Text(
                'CHAMPAKLAL JAYANTILAL GADA',
                style: TextStyle(
                  fontSize: (screenWidth * 0.035).clamp(10, 24),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              // Form
              Container(
                width: screenWidth * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            // width: double.infinity, // Occupy full available width
                            height: 50.0, // Set desired height
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Rounded corners
                              color: Colors.white, // White background
                              border: Border.all(
                                  color: Colors.grey.shade200,
                                  width: 1.0), // Light grey border
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.0), // Padding for text
                              child: TextField(
                                controller:
                                    profileController.firstNameController,
                                onChanged: (_) =>
                                    profileController.isFormEdited.value = true,
                                decoration: InputDecoration(
                                  border:
                                      InputBorder.none, // Hide default border
                                  hintText: 'First Name', // Display hint text
                                  hintStyle: TextStyle(
                                      color: Colors
                                          .grey.shade400), // Hint text color
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            // width: double.infinity, // Occupy full available width
                            height: 50.0, // Set desired height
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Rounded corners
                              color: Colors.white, // White background
                              border: Border.all(
                                  color: Colors.grey.shade200,
                                  width: 1.0), // Light grey border
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.0), // Padding for text
                              child: TextField(
                                controller:
                                    profileController.lastNameController,
                                onChanged: (_) =>
                                    profileController.isFormEdited.value = true,
                                decoration: InputDecoration(
                                  border:
                                      InputBorder.none, // Hide default border
                                  hintText: 'Last Name', // Display hint text
                                  hintStyle: TextStyle(
                                      color: Colors
                                          .grey.shade400), // Hint text color
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
                    Container(
                      width: double.infinity, // Occupy full available width
                      height: 50.0, // Set desired height
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10.0), // Rounded corners
                        color: Colors.white, // White background
                        border: Border.all(
                            color: Colors.grey.shade200,
                            width: 1.0), // Light grey border
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0), // Padding for text
                        child: TextField(
                          controller: profileController.emailController,
                          onChanged: (_) =>
                              profileController.isFormEdited.value = true,
                          decoration: InputDecoration(
                            border: InputBorder.none, // Hide default border
                            hintText: 'Email', // Display hint text
                            hintStyle: TextStyle(
                                color: Colors.grey.shade400), // Hint text color
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                    Container(
                      width: double.infinity, // Occupy full available width
                      height: 50.0, // Set desired height
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10.0), // Rounded corners
                        color: Colors.white, // White background
                        border: Border.all(
                            color: Colors.grey.shade200,
                            width: 1.0), // Light grey border
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0), // Padding for text
                        child: TextField(
                          controller: profileController.phoneController,
                          onChanged: (_) =>
                              profileController.isFormEdited.value = true,
                          decoration: InputDecoration(
                            border: InputBorder.none, // Hide default border
                            hintText: 'Phone Number', // Display hint text
                            hintStyle: TextStyle(
                                color: Colors.grey.shade400), // Hint text color
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    // Update Button
                    Obx(() => mainButton(
                          'UPDATE PROFILE',
                          onPress: profileController.isFormEdited.value
                              ? profileController.handleUpdate
                              : null,
                        )),
                  ],
                ),
              ),
              SizedBox(height: 10),
              // Logout Button
              Container(
                width: screenWidth * 0.8,
                child: mainButton(
                  'LOGOUT',
                  onPress: () {
                    SharedPrefs.clearAllData();
                    print("Logout");
                    Get.offAll(LandingScreen());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
