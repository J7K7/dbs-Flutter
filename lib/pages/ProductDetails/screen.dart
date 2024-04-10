import 'package:cached_network_image/cached_network_image.dart';
import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:dbs_frontend/Themes/AppTextStyle.dart';
import 'package:dbs_frontend/Themes/Buttons.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:dbs_frontend/pages/OrderSelectionPage/slotSelection.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dbs_frontend/models/product_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;
    double viewportFraction = screenWidth >= 850 ? 0.5 : 0.8;
    double aspectRatio = orientation == Orientation.portrait ? 16 / 9 : 2.5;

    return Scaffold(
      extendBodyBehindAppBar:
          true, // Extend body behind app bar for transparency
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent app bar
        elevation: 0, // Remove shadow
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel
            vSpace(screenHeight * 0.08),
            GestureDetector(
              onTap: () {
                // Handle onTap action, e.g., show the image in full view
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Container(
                        width: orientation == Orientation.portrait
                            ? double.infinity
                            : screenWidth * 0.7,
                        height: screenHeight * 0.6,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CarouselSlider(
                            items: product.images != null &&
                                    product.images!.isNotEmpty
                                ? product.images!.map((image) {
                                    return ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child:
                                            getImageWidget(image['imagePath']));
                                  }).toList()
                                : [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: errorImageWidget()),
                                  ],
                            options: CarouselOptions(
                              autoPlay: false, // Stop auto-play in full view
                              aspectRatio: aspectRatio, // Maintain aspect ratio
                              enlargeCenterPage: false, // Disable enlargement
                              viewportFraction: 1.0, // Full viewport
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: CarouselSlider(
                items: product.images != null && product.images!.isNotEmpty
                    ? product.images!.map((image) {
                        return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: getImageWidget(image['imagePath']));
                      }).toList()
                    : [
                        errorImageWidget(),
                      ],
                // items: product.features!.map((feature) {
                //   return errorImageWidget();
                // }).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: aspectRatio,
                  enlargeCenterPage: true,
                  viewportFraction: viewportFraction,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.easeInBack,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            // Product Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                product.productName ?? 'productName Unavailable',
                style: AppTextStyles.subheadingTextStyle,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            // Product Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                product.productDescription ?? 'No description available',
                style: AppTextStyles.mediumBodyTextStyle,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            // Features
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: product.features!.map((feature) {
                  return ListTile(
                    leading: Icon(feature['iconData'] ?? Icons.check),
                    title: Text(feature.featureName ?? '',
                        style: AppTextStyles.mediumHeadingTextStyle
                            .copyWith(fontWeight: FontWeight.bold)),
                    subtitle: Text(feature.featureDescription ?? '',
                        style: AppTextStyles.bodyTextStyle),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0, // Remove shadow
        // color: Colors.transparent, // Transparent background
        child: Center(
          child: product.activeToDate!.isBefore(DateTime.now())
              ? Text(
                  "Product Unavailable at this moment!",
                  style: TextStyle(color: Colors.red),
                )
              : mainButton(
                  "Book Product",
                  onPress: () {
                    print(product.images);
                    print(screenWidth);
                    print(product.productId);
                    print(orientation);
                    Get.to(SlotSelectionPage(product: product));
                  },
                ),
        ),
      ),
    );
  }
}
