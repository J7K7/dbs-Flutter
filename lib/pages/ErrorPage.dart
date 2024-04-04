import 'package:dbs_frontend/Themes/Buttons.dart';
import 'package:dbs_frontend/Utilities/SharedPreferences.dart';
import 'package:dbs_frontend/pages/LandingPage/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Container(
          width: screenWidth * 0.8,
          height: screenHeight * 0.8,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[200], // Background color of the container
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
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
                width: screenWidth * 0.7,
                height: screenHeight * 0.5,
                fit: BoxFit.cover,
              ),
              // SizedBox(height: 20),
              Text(
                'Oops, something went wrong!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Container(
                width: screenWidth * 0.5,
                child: mainOutLinedButton(
                  'RETRY',
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
        ),
      ),
    );
  }
}
