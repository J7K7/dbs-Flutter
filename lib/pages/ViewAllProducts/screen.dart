// import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/AppTextStyle.dart';
import 'package:dbs_frontend/pages/ViewAllProducts/controller.dart';
import 'package:dbs_frontend/pages/ViewAllProducts/productCard.dart';
import 'package:flutter/material.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:ums_demo/AppCommon/CommonFunctions.dart';
// import 'package:ums_demo/Themes/UiUtils.dart';
// import 'package:ums_demo/pages/SplashScreen/Controller.dart';

class ViewAllProducts extends StatelessWidget {
  ViewAllProducts({Key? key}) : super(key: key);

  final _controller = Get.put(ProductListController());

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;

    double screenWidth = MediaQuery.of(context).size.width;
    // print(screenWidth);
    _controller.callAPIGetProducts();
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              print("Back Button Is pressed");
              Get.back();
            }),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              print("Shopping Button Is pressed");

              print(screenWidth);
            },
          )
        ],
      ),
      body: Obx(
        () => _controller.isLoading.value
            ? spinKitWidgetWaveSpinner()
            : ResponsiveBuilder(
                builder: (context, sizingInformation) {
                  return Column(
                    children: [
                      vSpace(10),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text('All Products',
                                  style: AppTextStyles.headingTextStyle),
                            ),
                            IconButton(
                                icon: const Icon(Icons.view_list_rounded),
                                onPressed: () {}),
                            IconButton(
                                icon: const Icon(Icons.grid_view),
                                onPressed: () {}),
                          ],
                        ),
                      ),
                      Expanded(
                        child: screenWidth <= 600
                            ? GetBuilder<ProductListController>(
                                builder: (controller) {
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    separatorBuilder: (c, i) => vSpace(),
                                    itemCount: controller.listOfProducts.length,
                                    itemBuilder: (context, index) {
                                      var item =
                                          controller.listOfProducts[index];
                                      // print(item.images![0]['imagePath']);
                                      return ProductCard(
                                        product: item,
                                        onPress: () {},
                                      );
                                    },
                                  );
                                },
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: responsiveItemCount(context,
                                      sizingInformation), // Dynamic count
                                  mainAxisSpacing: 5,
                                  childAspectRatio: getAspectRatio(
                                      screenWidth, sizingInformation),

                                  crossAxisSpacing: 5,
                                ),
                                itemCount: _controller.listOfProducts.length,
                                itemBuilder: (context, index) {
                                  var item = _controller.listOfProducts[index];
                                  return ProductCard(
                                    product: item,
                                    onPress: () {},
                                  );
                                },
                              ),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}

int responsiveItemCount(BuildContext context, SizingInformation info) {
  // double screenWidth = MediaQuery.of(context).size.width;
  if (info.deviceScreenType == DeviceScreenType.mobile) {
    return 1; // Mobile: 1 column
  } else if (info.deviceScreenType == DeviceScreenType.tablet) {
    // Adjust breakpoint for medium screens
    return 2; // Medium: 2 columns
  } else {
    return 3; // Large: 3 columns
  }
}

double getAspectRatio(double screenWidth, SizingInformation info) {
  // double screenWidth = MediaQuery.of(context).size.width;

  if (info.deviceScreenType == DeviceScreenType.tablet) {
    if (screenWidth < 600) {
      return 0.8;
    } else if (screenWidth >= 600 && screenWidth <= 750) {
      return 0.87;
    } else if (screenWidth >= 750 && screenWidth < 900) {
      return 0.91;
    } else if (screenWidth > 900 && screenWidth < 1000) {
      return 1;
    } else if (screenWidth >= 1000 && screenWidth <= 1200) {
      return 1.05;
    } else {
      return 1.1;
    }
  } else if (info.deviceScreenType == DeviceScreenType.desktop) {
    return 0.85;
  }
  return 0.6;
}
