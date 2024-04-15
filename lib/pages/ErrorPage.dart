import 'package:dbs_frontend/Themes/Buttons.dart';
import 'package:dbs_frontend/Utilities/SharedPreferences.dart';
import 'package:dbs_frontend/pages/LandingPage/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:dbs_frontend/Themes/AppColors.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          // child: Container(
          //   width: screenWidth * 0.8,
          //   height: screenHeight * 0.8,
          //   padding: EdgeInsets.all(20),
          //   decoration: BoxDecoration(
          //     color: Colors.grey[200], // Background color of the container
          //     borderRadius: BorderRadius.circular(20), // Rounded corners
          //   ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display the SVG image
              // SvgPicture.asset(
              //   'assets/images/error.svg', // Path to your SVG file
              //   width: screenWidth * 0.35,
              //   height: screenHeight * 0.35,
              //   fit: BoxFit.cover,
              // ),

              // Display the GIF image
              Image.asset(
                'assets/images/errorGif.gif', // Path to your GIF file
                width: screenWidth * 0.9,
                height: screenHeight * 0.6,
                fit: BoxFit.fill,
              ),
              // SizedBox(height: 20),
              Text(
                'Something Went Wrong !',
                style: TextStyle(
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.bold,
                  color: primary100,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Sorry, An unexpected error occured, it will be resolved shortly !',
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  color: primary100,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                width: screenWidth * 0.5,
                child: mainOutLinedButton(
                  'TRY AGAIN',
                  onPress: () {
                    // Clear the Login Data
                    SharedPrefs.clearAllData();
                    // Add any actions you want to perform when the button is pressed
                    Get.off(LandingScreen());
                  },
                ),
              ),
            ],
          ),
          // ),
        ),
      ),
    );
  }
}
