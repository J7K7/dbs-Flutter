import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


// App Dimens //
const double mainButtonHeight = 42;
const double textButtonHeight = 36;
const double outlineButtonHeight = 32;
const double textInputTextSize = 14;
const double filterBarHeight = 40;


Widget spinKitWidgetWave({double size = 40}) => Center(
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

void fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

SizedBox vSpace([double space = 8]) => SizedBox(height: space);
SizedBox hSpace([double space = 8]) => SizedBox(width: space);

// // Input Text Styles //
// InputDecoration textInputDecoration(String hint, {Widget? trailing}) =>
//     InputDecoration(hintText: hint, labelText: hint, suffixIcon: trailing,);


InputDecoration textInputDecoration(String hint, {Widget? trailing}) =>
    InputDecoration(
      hintText: hint,
      labelText: hint,
      suffixIcon: trailing,
      border: OutlineInputBorder( // Apply border here
        borderRadius: BorderRadius.circular(4.0), // Adjust border radius as needed
      ),
      focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: primary200 , width: 2.0)),
    );


