import 'package:cached_network_image/cached_network_image.dart';
import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:dbs_frontend/Themes/AppTextStyle.dart';
import 'package:dbs_frontend/Themes/Buttons.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:dbs_frontend/Utilities/SharedPreferences.dart';
import 'package:dbs_frontend/pages/BottomNavigationBar/screen.dart';
import 'package:dbs_frontend/pages/OrderSelectionPage/Day/dayWiseSelection.dart';
import 'package:dbs_frontend/pages/OrderSelectionPage/Day/dayWiseSelectionController.dart';
import 'package:dbs_frontend/pages/OrderSelectionPage/Slot/slotSelection.dart';
import 'package:dbs_frontend/pages/OrderSelectionPage/Slot/slotSelectionController.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dbs_frontend/models/product_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  ProductDetailsScreen({super.key, required this.product});
  final homeScreenController = Get.put(HomeScreenController());
  // final SlotSelectionController slotSelectionController=Get.put(SlotSelectionController(product: product));
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;
    double viewportFraction = screenWidth >= 850 ? 0.5 : 0.8;
    double aspectRatio = orientation == Orientation.portrait ? 16 / 9 : 2.5;
    print("BUSINESS_CATEGORYID");
    print(SharedPrefs.getString(BUSINESS_CATEGORYID));

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
                product.productName?.toUpperCase() ?? 'productName Unavailable',
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
                  "BOOK PRODUCT",
                  onPress: () {
                    // print(product.images);
                    print("Before it sending to the slot selection page");

                    // print(orientation);
                    if (SharedPrefs.getString(BUSINESS_CATEGORYID) == '1') {
                      SlotSelectionController controller =
                          Get.put<SlotSelectionController>(
                        SlotSelectionController(product: product),
                      );
                      controller.selectProduct(product);

                      Get.to(SlotSelectionPage(),
                          transition: Transition.cupertino);
                      // print(product.productId);
                    } else if (SharedPrefs.getString(BUSINESS_CATEGORYID) ==
                        '2') {
                      DayWiseSelectionController controller =
                          Get.put<DayWiseSelectionController>(
                        DayWiseSelectionController(product: product),
                      );
                      controller.selectProduct(product);
                      Get.to(DayWiseOrderSelectionPage(product: product),
                          transition: Transition.cupertino);
                    } else {
                      print("No SHared Preference found why ??");
                    }
                    // SharedPrefs.getString(BUSINESS_CATEGORYID) == '1'
                    //     ? Get.to(SlotSelectionPage(product: product),
                    //         transition: Transition.cupertino)
                    //     : Get.to(DayWiseOrderSelectionPage(product: product),
                    //         arguments: [homeScreenController, context],
                    //         transition: Transition.cupertino);
                  },
                ),
        ),
      ),
    );
  }
}
