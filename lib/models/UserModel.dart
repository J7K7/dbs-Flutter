// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import '../Themes/AppColors.dart';
// import '../Themes/AppStrings.dart';
// import '../Themes/UiUtils.dart';

class UserModel {
  int? userId;
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? profilePic;

  UserModel({
    this.userId,
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.profilePic,
  });

  UserModel.fromJson(Map<String, dynamic> data) {
    userId = data['userId'];
    email = data['email'];
    password = data['password'];
    firstName = data['firstName'];
    lastName = data['lastName'];
    phoneNumber = data['phoneNumber'];
    profilePic = data['profilePic'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['userId'] = userId;
    data['email'] = email;
    data['password'] = password;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phoneNumber'] = phoneNumber;
    data['profilePic'] = profilePic;

    return data;
  }
}
