import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/Buttons.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final TextAlign messageAlign;
  final String okText;
  final String? cancelText;
  final Function() okPress;
  final Function()? cancelPress;

  const CustomDialog(
      {Key? key,
      required this.title,
      required this.message,
      this.messageAlign = TextAlign.center,
      required this.okText,
      required this.okPress,
      this.cancelText,
      this.cancelPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: bg200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10, top: 20),
        child: Wrap(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(title, style: Get.textTheme.headline5),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4, bottom: 16),
              height: 1,
              color: accent300,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                message,
                textAlign: messageAlign,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              ),
            ),
            Container(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (cancelPress != null)
                  // outlinedButton(cancelText!, onPress: cancelPress),
                  hSpace(),
                mainButton(okText, radius: 8, onPress: okPress),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
