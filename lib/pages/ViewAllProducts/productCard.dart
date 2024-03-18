// import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:dbs_frontend/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/AppTextStyle.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// import 'package:flutter/material.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
// import 'package:get/get.dart';
// import 'package:dbs_frontend/models/feature_model.dart';
// import 'package:dbs_frontend/models/image_model.dart';
// import ''

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final Function() onPress;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget featuresWidget = Wrap(
      spacing: 8,
      runSpacing: 8,
      children: product.features != null
          ? product.features!.map<Widget>((feature) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: bg100,
                  boxShadow: const [
                    BoxShadow(
                      color: accent200,
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      feature['iconData'] ?? Icons.check,
                      size: 16,
                      color: primary200,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        feature['featureName'] ?? '',
                        style: AppTextStyles.bodyTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            }).toList()
          : [], // Empty list if features are not available
    );
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Card(
      color: bg200,
      shadowColor: accent200,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: screenWidth * 0.025, horizontal: screenHeight * 0.010),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              // height: screenHeight * 0.30,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child:
                      product.imageWideget, // You can set a default image here
                ),
              ),
            ),
            vSpace(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product.productName ?? '',
                  style: AppTextStyles.subheadingTextStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                vSpace(5),
                Text(
                  product.productDescription != null
                      ? product.productDescription!
                      : 'Description not available',
                  style: AppTextStyles.bodyTextStyle,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                vSpace(16),
                screenWidth <= 600
                    ? featuresWidget
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: featuresWidget,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
