import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/AppTextStyle.dart';
import 'package:dbs_frontend/Themes/Buttons.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:dbs_frontend/pages/LandingPage/screen.dart';
import 'package:dbs_frontend/pages/ViewAllProducts/screen.dart';
import 'package:flutter/material.dart';
import 'package:dbs_frontend/Utilities/SharedPreferences.dart';
import 'dart:ui' as ui;
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    print(screenHeight);
    print(screenWidth);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              size: 36,
            ),
            onPressed: () {
              print("LOGOUT Button Is pressed");
              SharedPrefs.clearLoginData();
              Get.offAll(const LandingScreen());
              // print();
            },
          )
        ],
      ),
      body: Stack(
        children: [
// Black background
          Positioned.directional(
            width: screenWidth,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: screenWidth,
                  height: screenHeight * 0.20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors
                            .black, // Change these colors as per your gradient
                        primary300,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

// Container wrapping search bar and search button

          // Container wrapping search bar and search button
          Positioned(
            top: screenHeight * 0.05, // Adjust the top position as needed
            left: screenWidth * 0.1, // Adjust the left position as needed
            right: screenWidth * 0.1, // Adjust the right position as needed
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Search bar
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Search bar
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors
                                        .grey)), // Add border only to the bottom
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.search), // Change the icon to search
                              SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search...',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 16,
                        ), // Add some spacing between search bar and "From Date" input field

                        // "From Date" input field
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors
                                        .grey)), // Add border only to the bottom
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_month),
                              SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'From Date...',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                      height:
                          16), // Add some spacing between search bar and button

                  // Search button
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: mainButton(
                      'Search',
                      onPress: () {},
                      color: primary100,
                      textColor: Colors.white,
                      fontWeight: FontWeight.bold,
                      elevation: 0,
                      radius: 8,
                    ),
                  ),

                  vSpace(16),

                  mainButton("View All Products", onPress: () {
                    Get.to(ViewAllProducts());
                  }),
                ],
              ),
            ),
          ),

          // Above content
        ],
      ),
    );
  }
}
