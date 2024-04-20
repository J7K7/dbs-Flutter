import 'package:cached_network_image/cached_network_image.dart';
import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
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
    child: FittedBox(
      fit: BoxFit.fill,
      child: Icon(
        Icons.error,
        color: primary100, // Example error icon color
        size: size,
      ),
    ),
  );
}

Image errorImageWidget() => Image.asset(defaultErrorImageUrl, fit: BoxFit.fill);

// Widget getImageWidget(String imagePath) {
//   return CachedNetworkImage(
//       imageUrl: PRODUCT_IMAGE_PATH + imagePath,
//       errorWidget: (context, url, error) => errorIconWidget(size: 50),
//       placeholder: (context, url) => const CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1e2022)),
//           ),
//       fit: BoxFit.fill);
// }

Widget getImageWidget(String imagePath) {
  return CachedNetworkImage(
    imageUrl: PRODUCT_IMAGE_PATH + imagePath,
    errorWidget: (context, url, error) => errorIconWidget(size: 50),
    placeholder: (context, url) => Center(
      child: SizedBox(
        width: 40, // Specify the desired width
        height: 40, // Specify the desired height
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1e2022)),
        ),
      ),
    ),
    fit: BoxFit.fill,
  );
}

// // Input Text Styles //
// InputDecoration textInputDecoration(String hint, {Widget? trailing}) =>
//     InputDecoration(hintText: hint, labelText: hint, suffixIcon: trailing,);
void showGetXBar(String message) {
  Get.snackbar("", "",
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      backgroundColor: primary200,
      // titleText: Center(
      //   child: Text(message,
      //       style: AppTextStyles.snackBarTextStyle
      //           .copyWith(fontWeight: FontWeight.bold)),
      // ),
      messageText: Center(
        child: Text(message,
            style: AppTextStyles.snackBarTextStyle
                .copyWith(fontWeight: FontWeight.bold)),
      ),
      forwardAnimationCurve: ElasticInCurve(0.4));
}

void showErrorDialog(String errorMessage, Function() confirmPress,
    Function() cancelPress) async {
  Get.defaultDialog(
    title: "Attention",
    content: Column(
      children: [
        Text(
          errorMessage,
          style: AppTextStyles.mediumBodyTextStyle,
          textAlign: TextAlign.center,
        ),
      ],
    ),
    confirm: ElevatedButton(
      onPressed: confirmPress,
      child: Text("Proceed", style: AppTextStyles.buttonTextStyle),
      style: ElevatedButton.styleFrom(
          backgroundColor: primary100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          )),
    ),
    cancel: ElevatedButton(
        onPressed: cancelPress,
        child: Text("Cancel", style: AppTextStyles.mediumBodyTextStyle),
        style: ElevatedButton.styleFrom(
            // backgroundColor: primary100,
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ))),
    barrierDismissible: false,
  );
}

void showErrorToastMessage(BuildContext context, String message,
    {double bottomPadding = 15}) {
  DelightToastBar(
    builder: (context) => Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, bottomPadding),
      child: ToastCard(
        leading: Icon(
          Icons.error_outline_outlined,
          color: Color(0xFFDC143C),
          size: 28,
        ),
        title: Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFFDC143C),
            fontSize: 14,
          ),
        ),
      ),
    ),
    snackbarDuration: Duration(seconds: 3),
    autoDismiss: true,
    animationCurve: Curves.easeOutCubic,
  ).show(context);
}

void showSuccessToastMessage(BuildContext context, String message,
    {double bottomPadding = 15}) {
  DelightToastBar(
    builder: (context) => Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, bottomPadding),
      child: ToastCard(
        leading: Icon(
          Icons.check,
          color: Colors.green,
          size: 28,
        ),
        title: Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.green,
            fontSize: 14,
          ),
        ),
      ),
    ),
    snackbarDuration: Duration(seconds: 2),
    autoDismiss: true,
    animationCurve: Curves.easeOutCubic,
  ).show(context);
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
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: primary100, width: 2.0)),
        // hoverColor: primary100,
        labelStyle: TextStyle(color: primary100));
