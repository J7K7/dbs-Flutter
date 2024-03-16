import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:dbs_frontend/Themes/AppTextStyle.dart';

// App Dimens //
const double mainButtonHeight = 42;
const double textButtonHeight = 36;
const double outlineButtonHeight = 32;
const double textInputTextSize = 14;
const double filterBarHeight = 40;

Widget spinKitWidgetWave({double size = 100}) => Center(
        child: SpinKitWave(
      color: primary100,
      size: size,
    ));
Widget spinKitWidgetWaveSpinner({double size = 100}) => Center(
        child: SpinKitWaveSpinner(
      color: primary100,
      trackColor: primary100,
      waveColor: primary300,
      size: size,
    ));

void hideKeyboard(context) => FocusScope.of(context).requestFocus(FocusNode());

void fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

SizedBox vSpace([double space = 8]) => SizedBox(height: space);
SizedBox hSpace([double space = 8]) => SizedBox(width: space);

Widget errorIconWidget({double size = 50}) {
  return Container(
    color: accent200, // Example background color
    child: Icon(
      Icons.error,
      color: primary100, // Example error icon color
      size: size, // Example error icon size
    ),
  );
}

Image errorImageWidget() => Image.asset(defaultErrorImageUrl, fit: BoxFit.fill);

// // Input Text Styles //
// InputDecoration textInputDecoration(String hint, {Widget? trailing}) =>
//     InputDecoration(hintText: hint, labelText: hint, suffixIcon: trailing,);
void showGetXBar(String message) {
  Get.snackbar("", "",
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      backgroundColor: primary200,
      // titleText: Center(
      //   child: Text(title,
      //       style: Get.textTheme.headlineMedium?.copyWith(color: bg200)),
      // ),
      messageText: Center(
        child: Text(message, style: AppTextStyles.snackBarTextStyle),
      ),
      forwardAnimationCurve: ElasticInCurve(0.4));
}

InputDecoration textInputDecoration(String hint, {Widget? trailing}) =>
    InputDecoration(
      hintText: hint,
      labelText: hint,
      suffixIcon: trailing,
      border: OutlineInputBorder(
        // Apply border here
        borderRadius:
            BorderRadius.circular(4.0), // Adjust border radius as needed
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: primary200, width: 2.0)),
    );
