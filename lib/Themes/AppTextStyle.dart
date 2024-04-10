import 'package:flutter/material.dart';
import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/AppStrings.dart';

// Define text styles
class AppTextStyles {
  // Heading text style
  static const TextStyle headingTextStyle = TextStyle(
    fontFamily: fontPoppinsBold,
    fontWeight: FontWeight.bold,
    fontSize: fsXXXLarge,
    color: text100,
  );

  // Subheading text style
  static const TextStyle subheadingTextStyle = TextStyle(
    fontFamily: fontPoppinsMedium,
    fontWeight: FontWeight.bold,
    fontSize: fsXXLarge,
    color: text100,
  );

  //medium heading Text
  static const TextStyle mediumHeadingTextStyle = TextStyle(
    fontFamily: fontPoppinsMedium,
    // fontWeight: FontWeight.bold,
    fontSize: fsLarge,
    color: text100,
  );

  // Body text style
  static const TextStyle bodyTextStyle = TextStyle(
    fontFamily: fontPoppins,
    fontSize: fsNormal,
    color: text200,
  );
  // medium BodyText
  static const TextStyle mediumBodyTextStyle = TextStyle(
    fontFamily: fontPoppins,
    fontSize: fsMedium,
    color: text200,
  );

  // Button text style
  static const TextStyle buttonTextStyle = TextStyle(
    fontFamily: fontPoppinsSemiBold,
    fontSize: fsMedium,
    color: text300,
  );

  static const TextStyle snackBarTextStyle = TextStyle(
    fontFamily: fontPoppins,
    fontSize: fsLarge,
    color: text300,
  );

  // Caption text style
  static const TextStyle captionTextStyle = TextStyle(
    fontFamily: fontPoppinsLight,
    fontSize: fsCaption,
    color: text200,
  );
}
