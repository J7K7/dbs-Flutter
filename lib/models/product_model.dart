import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:dbs_frontend/models/feature_model.dart';
import 'package:dbs_frontend/models/image_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductModel {
  int? productId;
  String? productName;
  String? productDescription; // Added field
  int? advanceBookingDuration;
  DateTime? activeFromDate;
  DateTime? activeToDate;
  List<ImageModel>? images;
  List<FeatureModel>? features;
  List<dynamic>? slots;

  ProductModel({
    this.productId,
    this.productName,
    this.productDescription, // Added field
    this.advanceBookingDuration,
    this.activeFromDate,
    this.activeToDate,
    this.images,
    this.features,
    this.slots,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    productDescription = json['productDescription']; // Parse productDescription
    advanceBookingDuration = json['advanceBookingDuration'];
    activeFromDate = DateTime.parse(json['active_fromDate']);
    activeToDate = DateTime.parse(json['active_toDate']);
    if (json['images'] != null) {
      images = <ImageModel>[];
      json['images'].forEach((v) {
        images!.add(ImageModel.fromJson(v));
      });
    }
    if (json['features'] != null) {
      features = <FeatureModel>[];
      json['features'].forEach((v) {
        features!.add(FeatureModel.fromJson(v));
      });
    }
    slots = json['slots'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['productName'] = productName;
    data['productDescription'] =
        productDescription; // Include productDescription
    data['advanceBookingDuration'] = advanceBookingDuration;
    data['active_fromDate'] = activeFromDate!.toString();
    data['active_toDate'] = activeToDate!.toString();
    // data['active_fromDate'] = activeFromDate!.toIso8601String();
    // data['active_toDate'] = activeToDate!.toIso8601String();
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (features != null) {
      data['features'] = features!.map((v) => v.toJson()).toList();
    }
    data['slots'] = slots;
    return data;
  }

  // get imageWideget => images != null && images!.isNotEmpty
  //     ? CachedNetworkImage(
  //         imageUrl: PRODUCT_IMAGE_PATH + images![0]['imagePath']!,
  //         errorWidget: (context, url, error) => errorIconWidget(size: 50),
  //         fit: BoxFit.fill)
  //     : errorImageWidget();

  get imageWideget => images != null && images!.isNotEmpty
      ? CachedNetworkImage(
          imageUrl: PRODUCT_IMAGE_PATH + images![0]['imagePath']!,
          errorWidget: (context, url, error) => errorIconWidget(size: 50),
          placeholder: (context, url) => CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.red)), // Optional placeholder
          // Shows entire image content, might have padding
          fit: BoxFit.fill)
      : errorImageWidget();
}
