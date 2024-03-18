// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import '../Themes/AppColors.dart';
// import '../Themes/AppStrings.dart';
// import '../Themes/UiUtils.dart';

class LoginModel {
  String? accessToken;
  // String? userType;
  String? email;
  // String? password;

  LoginModel({
    this.accessToken,
    this.email,
    // this.password,
    // this.image
  });

  LoginModel.fromJson(Map<String, dynamic> data) {
    accessToken = data['token'];
    email = data['email'];
    // password = data['password'];
    // image = data['image'];
  }

  // get imageWideget => image != null
  //     ? CachedNetworkImage(
  //   imageUrl: IMAGE_PATH + image!,
  //   placeholder: (context, url) => const SizedBox(),
  //   errorWidget: (context, url, error) => errorImageWidget1("user1", color : kGrey),
  //   fit : BoxFit.cover
  // ) : errorImageWidget1('user1', color : kGrey);

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['token'] = accessToken;
    data['email'] = email;
    // data['password'] = password;

    return data;
  }
}
