// import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/AppTextStyle.dart';
import 'package:dbs_frontend/pages/HomeScreen/homePageController.dart';
import 'package:dbs_frontend/pages/ProductDetails/screen.dart';
import 'package:dbs_frontend/pages/searchProducts/controller.dart';
import 'package:dbs_frontend/pages/searchProducts/productCard.dart';
import 'package:flutter/material.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:ums_demo/AppCommon/CommonFunctions.dart';
// import 'package:ums_demo/Themes/UiUtils.dart';
// import 'package:ums_demo/pages/SplashScreen/Controller.dart';

class ProductListScreen extends StatelessWidget {
  ProductListScreen({Key? key}) : super(key: key);

  final _controller = Get.put(ProductListController());

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;

    double screenWidth = MediaQuery.of(context).size.width;
    // final homePageController = Get.put(HomePageController());
    // print(screenWidth);
    // _controller.callAPIGetProducts();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // leading: IconButton(
        //     icon: const Icon(Icons.arrow_back_ios_sharp),
        //     onPressed: () {
        //       print("Back Button Is pressed");
        //       homePageController.clearSelectedDates();
        //       Get.back();
        //     }),
        title: Text(
          'PROFILE',
          style: TextStyle(
            fontSize: (screenWidth * 0.035).clamp(10, 20),
            letterSpacing: 1.5,
          ),
        ),
        // actions: [
        //   // IconButton(
        //   //   icon: Icon(Icons.filter_list), // You can also use Icons.filter_alt
        //   //   onPressed: () {
        //   //     // Implement your filter logic here
        //   //     // This onPressed callback will be triggered when the icon is pressed
        //   //     print('Filter button pressed');
        //   //   },
        //   // ),
        //   // IconButton(
        //   //   icon: const Icon(
        //   //     Icons.shopping_cart,
        //   //   ),
        //   //   onPressed: () {
        //   //     print("Shopping Button Is pressed");

        //   //     print(screenWidth);
        //   //   },
        //   // )
        // ],
      ),
      body: Obx(
        () => _controller.isLoading.value
            ? spinKitWidgetWaveSpinner()
            : _controller.listOfProducts.isEmpty
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage('assets/images/Product_not_found.png'),
                        fit: BoxFit.fill,
                      ),
                    ))
                : ResponsiveBuilder(
                    builder: (context, sizingInformation) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: screenWidth <= 600
                                  ? GetBuilder<ProductListController>(
                                      builder: (controller) {
                                        return ListView.separated(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          separatorBuilder: (c, i) => vSpace(),
                                          itemCount:
                                              controller.listOfProducts.length,
                                          itemBuilder: (context, index) {
                                            var item = controller
                                                .listOfProducts[index];
                                            print(
                                                "item inside the productList:");
                                            print(item);
                                            return ProductCard(
                                              product: item,
                                              onPress: () {
                                                Get.to(ProductDetailsScreen(
                                                    product: item));
                                                Transition.circularReveal;
                                              },
                                            );
                                          },
                                        );
                                      },
                                    )
                                  : GridView.builder(
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: responsiveItemCount(
                                            context,
                                            sizingInformation), // Dynamic count
                                        mainAxisSpacing: 16,
                                        childAspectRatio: getAspectRatio(
                                            screenWidth, sizingInformation),

                                        crossAxisSpacing: screenWidth * 0.001,
                                      ),
                                      itemCount:
                                          _controller.listOfProducts.length,
                                      itemBuilder: (context, index) {
                                        var item =
                                            _controller.listOfProducts[index];
                                        return ProductCard(
                                          product: item,
                                          onPress: () {
                                            Get.to(ProductDetailsScreen(
                                                product: item));
                                            Transition.fade;
                                          },
                                        );
                                      },
                                    ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}

int responsiveItemCount(BuildContext context, SizingInformation info) {
  double screenWidth = MediaQuery.of(context).size.width;
  if (screenWidth <= 600) {
    return 1; // Mobile: 1 column
  } else if (info.deviceScreenType == DeviceScreenType.desktop) {
    return 3;
  } else if (screenWidth > 600 && screenWidth <= 1300) {
    // Adjust breakpoint for medium screens
    return 2; // Medium: 2 columns
  }
  return 3; // Large: 3 columns
}

// Decide by the hit and trail.
double getAspectRatio(double screenWidth, SizingInformation info) {
  // double screenWidth = MediaQuery.of(context).size.width;

  if (info.deviceScreenType == DeviceScreenType.tablet ||
      info.deviceScreenType == DeviceScreenType.mobile) {
    // print("Here");
    // print(info.deviceScreenType);
    if (screenWidth < 650) {
      return 0.84;
    } else if (screenWidth >= 650 && screenWidth <= 750) {
      return 0.86;
    } else if (screenWidth >= 750 && screenWidth < 900) {
      return 0.91;
    } else if (screenWidth > 900 && screenWidth < 1000) {
      return 1;
    } else if (screenWidth >= 1000 && screenWidth <= 1200) {
      return 1.05;
    } else if (screenWidth <= 1300) {
      return 1.1;
    } else {
      return 0.85;
    }
  } else if (info.deviceScreenType == DeviceScreenType.desktop) {
    return 0.95;
  }
  return 0.84;
}
