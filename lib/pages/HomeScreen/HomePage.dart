import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:dbs_frontend/Themes/AppTextStyle.dart';
import 'package:dbs_frontend/Themes/Buttons.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:dbs_frontend/Utilities/SharedPreferences.dart';
import 'package:dbs_frontend/models/image_model.dart';
import 'package:dbs_frontend/models/product_model.dart';
import 'package:dbs_frontend/pages/ProductDetails/screen.dart';
import 'package:dbs_frontend/pages/SplashScreen/Controller.dart';
import 'package:dbs_frontend/pages/searchProducts/controller.dart';
import 'package:dbs_frontend/pages/searchProducts/productCard.dart';
import 'package:dbs_frontend/pages/searchProducts/screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import './homePageController.dart';
import 'dart:math';

double calculateProductCardHeight(double screenWidth) {
  // Constants for font sizes and line spacing
  // const double nameFontSize = 24.0;
  // const double descriptionFontSize = 16.0;
  // const double lineSpacingMultiplier = 1.2;

  // Assuming image width is 16:9 aspect ratio
  double maxWidth = 280;
  screenWidth = min(screenWidth, maxWidth);
  double imageWidth = screenWidth;
  double imageHeight = (imageWidth / 16) * 9;

  // // Calculate text heights
  // double nameTextHeight = lineSpacingMultiplier * nameFontSize;
  // double descriptionTextHeight = lineSpacingMultiplier *
  //     descriptionFontSize *
  //     3; // Assuming 3 lines for description

  // // Padding and margins
  // double paddingVertical = 8.0; // Example padding values, adjust as needed

  // Calculate total card height

  //Variable  to hold the calculated height
  // The value 168 is very imp for maintaning the ui
  // it is based upon the calculation of padding and etc.. and some trial
  double cardHeight = imageHeight + 168;

  return cardHeight;
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homePageController = Get.put(HomePageController());
    // final splashController =Get.find(SplashController())
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    print("SCREENWIDTH");
    print(screenWidth);
    print(screenHeight);
    print(calculateProductCardHeight(screenWidth * 0.5));
    // final FocusNode textFieldFocusNode = FocusNode();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Obx(
            () => homePageController.getLoadingState() == true
                ? Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        // Your existing code...
                        // 30% OF TEH ABOVE PART OF HOME PAGE
                        // Stack portion
                        Expanded(
                          flex: 10,
                          child: Stack(
                            children: [
                              // Black background with blur effect
                              Positioned(
                                width: screenWidth,
                                height: screenHeight >= 900
                                    ? screenHeight * 0.17
                                    : screenHeight * 0.22,
                                child: ClipRRect(
                                  child: BackdropFilter(
                                    filter: ui.ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                      width: screenWidth,
                                      decoration: const BoxDecoration(
                                        // borderRadius: BorderRadius.only(
                                        //   bottomLeft: Radius.circular(95),
                                        //   bottomRight: Radius.circular(95),
                                        // ),
                                        image: DecorationImage(
                                          // image: AssetImage('assets/images/download.jpg'),
                                          image: AssetImage(
                                              'assets/images/download.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                        // gradient: LinearGradient(
                                        //   begin: Alignment.center,
                                        //   end: Alignment.bottomCenter,
                                        //   colors: [
                                        //     Colors
                                        //         .black, // Change these colors as per your gradient
                                        //     primary300,
                                        //   ],
                                        // ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Container wrapping search bar and search button
                              Positioned(
                                top: screenHeight * 0.05,
                                left: screenWidth * 0.1,
                                right: screenWidth * 0.1,
                                child: Container(
                                  width: screenWidth * 0.3,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    // color: bg100,
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      // Search bar
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Obx(
                                            () => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12),
                                                  decoration:
                                                      const BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      InkWell(
                                                          child: const Icon(
                                                              Icons.search)),
                                                      const SizedBox(width: 8),
                                                      Expanded(
                                                        child: TextField(
                                                          decoration:
                                                              const InputDecoration(
                                                            hintText:
                                                                'Search...',
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                          onChanged: (value) {
                                                            homePageController
                                                                .setSearchQuery(
                                                                    value); // Update search query
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12),
                                                  child: Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () async {
                                                          // print(selectedDate);
                                                          await homePageController
                                                              .selectDate(
                                                                  context);
                                                        },
                                                        child: const Icon(Icons
                                                            .calendar_month),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Expanded(
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            // print(selectedDate);
                                                            await homePageController
                                                                .selectDate(
                                                                    context);
                                                          },
                                                          child: TextField(
                                                            decoration:
                                                                InputDecoration(
                                                              // Category 1

                                                              hintText: SharedPrefs
                                                                          .isContains(
                                                                              CATEGORYID) ==
                                                                      '1'
                                                                  ? homePageController
                                                                              .selectedDate
                                                                              .value !=
                                                                          null
                                                                      ? DateFormat('yyyy-MM-dd').format(homePageController
                                                                          .selectedDate
                                                                          .value!)
                                                                      : 'Select Date'
                                                                  : homePageController.checkInDate.value !=
                                                                              null &&
                                                                          homePageController.checkOutDate.value !=
                                                                              null
                                                                      ? '${DateFormat('yyyy-MM-dd').format(homePageController.checkInDate.value!)} - ${DateFormat('yyyy-MM-dd').format(homePageController.checkOutDate.value!)}'
                                                                      : 'Select Date',

                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                            controller:
                                                                homePageController
                                                                    .textEditingController,
                                                            enabled: false,
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          // Call the function to cancel selected dates
                                                          homePageController
                                                              .clearSelectedDates();
                                                        },
                                                        child: const Icon(
                                                          Icons.cancel_sharp,
                                                          color: accent100,
                                                        ), // Add cancel icon
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                      const SizedBox(height: 12),
                                      // Search button
                                      Container(
                                        child: mainButton(
                                          'Search',
                                          onPress: () {
                                            // print("Search............");
                                            // print(homePageController.searchQuery);
                                            // print(homePageController.selectedDate);
                                            // print(homePageController.checkInDate);
                                            // print(homePageController.checkOutDate);
                                            homePageController.handleSearch();
                                            // Get.to(ProductListScreen());
                                          },
                                          color: primary100,
                                          textColor: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          elevation: 0,
                                          radius: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //

                        // SCROBLLABLE 60%
                        Expanded(
                            flex: screenHeight >= 1050
                                ? 30
                                : (screenHeight >= 900 && screenHeight < 1050)
                                    ? 25
                                    : (screenHeight >= 750 &&
                                            screenHeight < 900)
                                        ? 20
                                        : (screenHeight >= 600 &&
                                                screenHeight < 750)
                                            ? 15
                                            : 10,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  DefaultTabController(
                                    length:
                                        homePageController.categories.length +
                                            1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: TabBar(
                                            isScrollable: true,
                                            labelColor: primary100,
                                            indicatorSize:
                                                TabBarIndicatorSize.label,
                                            unselectedLabelColor: accent300,
                                            tabs: [
                                              const Tab(
                                                child: Text(
                                                  'ALL',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                // productCategoryId = 0;
                                              ),
                                              // Generate tabs for categories
                                              ...List<Widget>.generate(
                                                homePageController
                                                    .categories.length,
                                                (index) {
                                                  final category =
                                                      homePageController
                                                          .categories[index];
                                                  return Tab(
                                                    key: ValueKey<int>(category
                                                        .productCategoryId),
                                                    child: Text(
                                                      category.categoryName
                                                          .toUpperCase(),
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                            indicatorColor: primary100,
                                            indicatorWeight: 3,
                                            onTap: (index) async {
                                              if (index == 0) {
                                                // If the first tab (ALL) is selected, set the product category ID to 0
                                                homePageController
                                                    .productCategoryId
                                                    .value = -1;

                                                // Call the function to fetch products based on the selected category
                                                await homePageController
                                                    .getAllLatestProductsByCategories(
                                                        homePageController
                                                            .productCategoryId
                                                            .value);

                                                print("ALL ma Tap Kairu");
                                                print(index);
                                              } else {
                                                // If any other tab is selected, set the product category ID to the corresponding category ID
                                                homePageController
                                                        .productCategoryId
                                                        .value =
                                                    homePageController
                                                        .categories[index - 1]
                                                        .productCategoryId;

                                                // Call the function to fetch products based on the selected category
                                                await homePageController
                                                    .getAllLatestProductsByCategories(
                                                        homePageController
                                                            .productCategoryId
                                                            .value);

                                                print("Category ma Tap Kairu");
                                                print(index);
                                              }
                                            },
                                          ),
                                        ),
                                        Obx(() => Container(
                                            height: calculateProductCardHeight(
                                                screenWidth * 0.5),
                                            // color: Colors.yellow,
                                            // constraints:BoxConstraints(maxHeight: 350),
                                            child: homePageController
                                                        .isCategoryDataLoading ==
                                                    true
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator(), // Show loading indicator
                                                  )
                                                : TabBarView(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    children: [
                                                      if (homePageController
                                                          .productsByCategory
                                                          .isEmpty)
                                                        const Center(
                                                          child: Text(
                                                            'No Products Found',
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                        )
                                                      else
                                                        for (int i = 0;
                                                            i <
                                                                homePageController
                                                                        .categories
                                                                        .length +
                                                                    1;
                                                            i++)
                                                          SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    12),
                                                            child: Row(
                                                              children:
                                                                  List.generate(
                                                                homePageController
                                                                        .productsByCategory
                                                                        .length +
                                                                    1,
                                                                (index) {
                                                                  return index ==
                                                                          homePageController
                                                                              .productsByCategory
                                                                              .length
                                                                      ? index <=
                                                                              2
                                                                          ? vSpace(
                                                                              0)
                                                                          : GestureDetector(
                                                                              onTap: () {
                                                                                // print(homePageController.categories[i - 1].categoryName);
                                                                                print("I bhai");
                                                                                print(i);
                                                                                // Handle the button tap action\
                                                                                if (i > 0) {
                                                                                  homePageController.viewAllByCategory(homePageController.categories[i - 1].productCategoryId);
                                                                                } else if (i <= 0) {
                                                                                  homePageController.viewAllByCategory();
                                                                                }
                                                                                print(homePageController.productCategoryId);
                                                                              },
                                                                              child: Container(
                                                                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    const Text(
                                                                                      'View All Products',
                                                                                      // style: TextStyle(fontWeight: FontWeight.bold, color: primary100, fontSize: 16),
                                                                                      style: AppTextStyles.bodyTextStyle,
                                                                                    ),
                                                                                    Text(
                                                                                      i <= 0 ? '' : 'in ${homePageController.categories[i - 1].categoryName}',
                                                                                      // style: TextStyle(fontWeight: FontWeight.bold, color: primary100, fontSize: 16),
                                                                                      style: AppTextStyles.bodyTextStyle,
                                                                                    ),
                                                                                    SizedBox(width: 8),
                                                                                    Icon(Icons.arrow_forward, size: 40, color: primary100),
                                                                                    SizedBox(width: 8),
                                                                                    const Text(
                                                                                      'View All',
                                                                                      style: TextStyle(fontWeight: FontWeight.bold, color: primary100, fontSize: 18),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            )
                                                                      : Container(
                                                                          width:
                                                                              screenWidth * 0.5,
                                                                          constraints:
                                                                              BoxConstraints(maxWidth: 280),
                                                                          child:
                                                                              ProductCard(
                                                                            product:
                                                                                homePageController.productsByCategory[index],
                                                                            isFeatureDisplay:
                                                                                false,
                                                                            onPress:
                                                                                () {
                                                                              Get.to(
                                                                                ProductDetailsScreen(
                                                                                  product: homePageController.productsByCategory[index],
                                                                                ),
                                                                              );
                                                                              Transition.circularReveal;
                                                                            },
                                                                          ),
                                                                        );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                    ],
                                                  )))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'POPULAR',
                                              style: AppTextStyles
                                                  .subheadingTextStyle,
                                            ),
                                            GestureDetector(
                                              onTap: () => {
                                                homePageController
                                                    .viewAllByCategory(),
                                              },
                                              child: const Text(
                                                'VIEW ALL',
                                                style:
                                                    AppTextStyles.bodyTextStyle,
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ),
                                  Container(
                                    height: calculateProductCardHeight(
                                        screenWidth * 0.5),
                                    padding: EdgeInsets.all(12),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        children: homePageController
                                                    .isLoading ==
                                                false
                                            ? List.generate(
                                                homePageController
                                                    .popularProducts
                                                    .length, (index) {
                                                return Container(
                                                  width: screenWidth * 0.5,
                                                  constraints: BoxConstraints(
                                                    maxWidth: 280,
                                                  ),
                                                  child: ProductCard(
                                                    product: homePageController
                                                        .popularProducts[index],
                                                    isFeatureDisplay: false,
                                                    onPress: () {
                                                      // Handle product card tap
                                                      // print('Product ${index + 1} tapped');
                                                      Get.to(ProductDetailsScreen(
                                                          product:
                                                              homePageController
                                                                      .popularProducts[
                                                                  index]));
                                                      Transition.circularReveal;
                                                    },
                                                  ),
                                                );
                                              })
                                            : [],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                      ]),
          ),
        ));
  }
}
