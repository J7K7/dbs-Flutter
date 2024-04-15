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
  EdgeInsetsGeometry padding =
      const EdgeInsets.all(8.0), // New parameter for padding
  bool isEnabled = true, // New parameter for button enable/disable
}) {
  return ElevatedButton(
    onPressed: isEnabled
        ? onPress
        : null, //null, // Disable the button if isEnabled is false
    focusNode: focusNode,
    style: ElevatedButton.styleFrom(
      // foregroundColor: bg200,
      minimumSize: minSize,
      // disabledForegroundColor: primary300.withOpacity(0.38),
      // disabledBackgroundColor: primary300.withOpacity(0.12),
      elevation: elevation,
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      onPrimary: bg200, // Text color when hovered
      onSurface: primary300, // Background color when hovered
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

Widget mainOutLinedButton(
  String text, {
  Color color = Colors.transparent,
  Color textColor = primary100,
  required Function()? onPress,
  double radius = 4,
  double elevation = 1.8,
  FocusNode? focusNode,
  FontWeight fontWeight = FontWeight.w500,
  Size minSize = const Size(70, textButtonHeight),
  EdgeInsetsGeometry padding =
      const EdgeInsets.all(8.0), // New parameter for padding
}) {
  return OutlinedButton(
    onPressed: onPress,
    focusNode: focusNode,
    style: OutlinedButton.styleFrom(
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

// Modification left
Widget outlinedButton(String text,
        {Color color = primary100,
        required Function()? onPress,
        FocusNode? focusNode,
        Size minSize = const Size(120, mainButtonHeight)}) =>
    OutlinedButton(
      onPressed: onPress,
      focusNode: focusNode,
      style: OutlinedButton.styleFrom(
        minimumSize: minSize,
        side: BorderSide(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(color: color),
      ),
    );

Widget iconButton(
  String text, {
  Color color = primary100,
  Color textColor = text300,
  required Function()? onPress,
  double radius = 13,
  double elevation = 1.8,
  FocusNode? focusNode,
  FontWeight fontWeight = FontWeight.w500,
  Size minSize = const Size(70, textButtonHeight),
  EdgeInsetsGeometry padding = const EdgeInsets.all(8.0),
}) {
  return ElevatedButton(
    onPressed: onPress,
    focusNode: focusNode,
    style: ElevatedButton.styleFrom(
      foregroundColor: bg200,
      minimumSize: minSize,
      disabledForegroundColor: primary300.withOpacity(0.38),
      disabledBackgroundColor: primary300.withOpacity(0.12),
      elevation: elevation,
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    ),
    child: Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Transform.scale(
            scale: 1.5, // Adjust scale factor for desired thickness
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.transparent,
              size: 18.0,
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fsXLarge,
              color: textColor,
              fontWeight: fontWeight,
            ),
          ),
          Transform.scale(
            scale: 2.0, // Adjust scale factor for desired thickness
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
              size: 18.0,
            ),
          ),
        ],
      ),
    ),
  );
}
