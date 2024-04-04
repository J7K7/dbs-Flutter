import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/Buttons.dart';
// import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:dbs_frontend/pages/Login/screen.dart';
import 'package:dbs_frontend/pages/Register/screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Image
          Container(
            alignment: Alignment.center,
            height: screenHeight * 0.7,
            // width: screenWidth*0.7,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/OnlineSales.gif'),
                fit: BoxFit.contain,
                // colorFilter: ColorFilter.mode(
                //   bg100,
                //   BlendMode.dstATop,
                // ),
              ),
            ),
          ),

          // Gradient
          // Positioned.fill(
          //   child: Container(
          //     decoration: const BoxDecoration(
          //       gradient: LinearGradient(
          //         begin: Alignment.center,
          //         end: Alignment.bottomCenter,
          //         colors: [
          //           Color.fromRGBO(30, 32, 34, 0),
          //           bg100,
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // Text and buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              //height: screesnHeight * 0.2,
              padding: EdgeInsets.fromLTRB(screenWidth * 0.02,
                  screenHeight * 0.05, screenWidth * 0.02, screenHeight * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'BOOK YOUR SERVICES IN SECONDS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth / 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: primary100,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Schedule your next appointment within a few seconds. Easily reserve and manage your appointments.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth / 30,
                      fontFamily: 'Poppins',
                      color: primary100,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  mainOutLinedButton('LOGIN', onPress: () {
                    Get.to(LoginScreen());
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginScreen()),
                    // );
                  }),
                  SizedBox(height: screenHeight * 0.01),
                  mainButton('REGISTER', onPress: () {
                    Get.to(RegisterScreen());
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => RegisterScreen()),
                    // );
                  }),
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
