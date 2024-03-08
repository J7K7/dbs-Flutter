import 'package:flutter/material.dart';
import './UiUtils.dart';
import './AppStrings.dart';
import 'AppColors.dart';


Widget mainButton(
  String text, {
  Color color = primary100,
  Color textColor = text300,
  required Function()? onPress,
  double radius = 4,
  double elevation = 1.8,
  FocusNode? focusNode,
  FontWeight fontWeight = FontWeight.w500,
  Size minSize = const Size(70, textButtonHeight),
  EdgeInsetsGeometry padding = const EdgeInsets.all(8.0), // New parameter for padding
}) {
  return ElevatedButton(
    onPressed: onPress,
    focusNode: focusNode,
    style: ElevatedButton.styleFrom(
      minimumSize: minSize,
      elevation: elevation,
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    ),
    child: Padding(
      padding: padding, // Use the provided padding
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fsXLarge,
            color: textColor,
            fontWeight: fontWeight,
          ),
        ),
      ),
    ),
  );
}
