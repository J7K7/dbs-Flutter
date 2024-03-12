import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:dbs_frontend/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/AppTextStyle.dart';
// import 'package:dbs_frontend/pages/ViewAllProducts/productCard.dart';
// import 'package:flutter/material.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
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
    return Card(
      color: bg200,
      shadowColor: accent200,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 200,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: product.images != null && product.images!.isNotEmpty
                      ? Image.network(
                          product.images![0]['imagePath'],
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            // Return your custom error image widget here
                            return Container(
                              color: accent200, // Example background color
                              child: const Icon(
                                Icons.error,
                                color: primary100, // Example error icon color
                                size: 50, // Example error icon size
                              ),
                            );
                          },
                        )
                      : Image.network(
                          defaultErrorImageUrl,
                          fit: BoxFit.fill,
                        ) // You can set a default image here
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
                Wrap(
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
