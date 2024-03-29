import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:dbs_frontend/Themes/AppTextStyle.dart';
import 'package:dbs_frontend/Themes/Buttons.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:dbs_frontend/Utilities/SharedPreferences.dart';
import 'package:dbs_frontend/models/image_model.dart';
import 'package:dbs_frontend/models/product_model.dart';
import 'package:dbs_frontend/pages/ProductDetails/screen.dart';
import 'package:dbs_frontend/pages/searchProducts/controller.dart';
import 'package:dbs_frontend/pages/searchProducts/productCard.dart';
import 'package:dbs_frontend/pages/searchProducts/screen.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import './homePageController.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    List<String> categories = [
      'ALL',
      'CATEGORY 1',
      'CATEGORY 2',
      'CATEGORY 3',
      'CATEGORY 4',
      'CATEGORY 5',
      'CATEGORY 6',
      'CATEGORY 7',
      'CATEGORY 8',
      'CATEGORY 9',
      'CATEGORY10'
    ];

    // Controllers
    final homePageController = Get.put(HomePageController());
    final _controller = Get.put(ProductListController());
    // _controller.callAPISearchProducts();

    return Scaffold(
      body: Column(
        children: [
          // 30% OF TEH ABOVE PART OF HOME PAGE
          // Stack portion
          Container(
            height: screenHeight * 0.3,
            child: Stack(
              children: [
                // Black background with blur effect
                Positioned(
                  width: screenWidth,
                  height: screenHeight * 0.22,
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: screenWidth,
                        decoration: const BoxDecoration(
                          // borderRadius: BorderRadius.only(
                          //   bottomLeft: Radius.circular(25),
                          //   bottomRight: Radius.circular(25),
                          // ),
                          image: DecorationImage(
                            // image: AssetImage('assets/images/download.jpg'),
                            image: AssetImage('assets/images/download.jpg'),
                            fit: BoxFit.cover,
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors
                                  .black, // Change these colors as per your gradient
                              primary300,
                            ],
                          ),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: bg100,
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Search bar
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Obx(
                              () => Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        // IconButton(
                                        //     onPressed: () => {},
                                        //     icon: Icon(Icons.search)),
                                        InkWell(
                                            onTap: () => {},
                                            child: Icon(Icons.search)),
                                        SizedBox(width: 8),
                                        // Expanded(
                                        //   // child: Obx(() => TextField(
                                        //   //   decoration: InputDecoration(
                                        //   //     hintText: 'Search...',
                                        //   //     border: InputBorder.none,
                                        //   //   ),
                                        //   // ),)
                                        // ),

                                        Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: 'Search...',
                                              border: InputBorder.none,
                                            ),
                                            onChanged: (value) {
                                              homePageController.setSearchQuery(
                                                  value); // Update search query
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Row(
                                      children: [
                                        // IconButton(
                                        //     padding: EdgeInsets.all(0),
                                        //     onPressed: () async => {
                                        //           await homePageController
                                        //               .selectDate(context)
                                        //         },
                                        // icon: Icon(Icons.calendar_month)),
                                        Icon(Icons.calendar_month),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () async {
                                              print("Hiiiii");
                                              // print(selectedDate);
                                              await homePageController
                                                  .selectDate(context);
                                            },
                                            child: TextField(
                                              decoration: InputDecoration(
                                                // Category 1

                                                hintText: SharedPrefs
                                                            .isContains(
                                                                CATEGORYID) ==
                                                        '1'
                                                    ? homePageController
                                                                .selectedDate
                                                                .value !=
                                                            null
                                                        ? DateFormat(
                                                                'yyyy-MM-dd')
                                                            .format(
                                                                homePageController
                                                                    .selectedDate
                                                                    .value!)
                                                        : 'Select Date'
                                                    : homePageController
                                                                    .checkInDate
                                                                    .value !=
                                                                null &&
                                                            homePageController
                                                                    .checkOutDate
                                                                    .value !=
                                                                null
                                                        ? '${DateFormat('yyyy-MM-dd').format(homePageController.checkInDate.value!)} - ${DateFormat('yyyy-MM-dd').format(homePageController.checkOutDate.value!)}'
                                                        : 'Select Date',

                                                border: InputBorder.none,
                                              ),
                                              controller: homePageController
                                                  .textEditingController,
                                              enabled: false,
                                            ),
                                          ),
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
                              print("Search............");
                              print(homePageController.searchQuery);
                              print(homePageController.selectedDate);
                              print(homePageController.checkInDate);
                              print(homePageController.checkOutDate);
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
              child: SingleChildScrollView(
            child: Column(children: [
              Align(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(12),
                  child: Container(
                    child: Row(
                      children: [
                        hSpace(2),
                        for (var category in categories)
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: ChoiceChip(
                                label: Text(category),
                                selected: false,
                                labelStyle: const TextStyle(
                                  color: primary100,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                shape: const BeveledRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  side: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                backgroundColor: Colors.white,
                                onSelected: (isSelected) {
                                  // Handle chip selection
                                  Get.to(ProductListScreen());
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'LATEST',
                          style: AppTextStyles.subheadingTextStyle,
                        ),
                        GestureDetector(
                          onTap: () => {homePageController.viewAll()},
                          child: Text(
                            'VIEW ALL',
                            style: AppTextStyles.bodyTextStyle,
                          ),
                        ),
                      ]),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(10, (index) {
                        // Create a dummy product for each iteration
                        ProductModel dummyProduct = ProductModel(
                          productId: index + 1,
                          productName: 'Product ${index + 1}',
                          productDescription:
                              'Description of Product ${index + 1}',
                          advanceBookingDuration: 0,
                          activeFromDate: DateTime.now(),
                          activeToDate: DateTime.now().add(Duration(days: 30)),
                          images: [ImageModel(imagePath: 'room.jpg')],
                          slots: [],
                        );

                        return Container(
                          width: screenWidth * 0.5,
                          // Set the width of each product card

                          constraints: BoxConstraints(maxWidth: 280),
                          child: ProductCard(
                            product: dummyProduct,
                            onPress: () {
                              // Handle product card tap
                              print('Product ${index + 1} tapped');
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'POPULAR',
                          style: AppTextStyles.subheadingTextStyle,
                        ),
                        GestureDetector(
                          onTap: () => {homePageController.viewAll()},
                          child: Text(
                            'VIEW ALL',
                            style: AppTextStyles.bodyTextStyle,
                          ),
                        ),
                      ]),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(_controller.listOfProducts.length,
                          (index) {
                        return Container(
                          width: screenWidth * 0.5,
                          height: 300,
                          // Set the width of each product card
                          constraints: BoxConstraints(maxWidth: 280),
                          child: SingleChildScrollView(
                            child: ProductCard(
                              product: _controller.listOfProducts[index],
                              isFeatureDisplay: false,
                              onPress: () {
                                // Handle product card tap
                                // print('Product ${index + 1} tapped');
                                Get.to(ProductDetailsScreen(
                                    product:
                                        _controller.listOfProducts[index]));
                                Transition.circularReveal;
                              },
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'RECOMMENDED',
                          style: AppTextStyles.subheadingTextStyle,
                        ),
                        GestureDetector(
                          onTap: () => {homePageController.viewAll()},
                          child: Text(
                            'VIEW ALL',
                            style: AppTextStyles.bodyTextStyle,
                          ),
                        ),
                      ]),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(10, (index) {
                        // Create a dummy product for each iteration
                        ProductModel dummyProduct = ProductModel(
                          productId: index + 1,
                          productName: 'Product ${index + 1}',
                          productDescription:
                              'Description of Product ${index + 1}',
                          advanceBookingDuration: 0,
                          activeFromDate: DateTime.now(),
                          activeToDate: DateTime.now().add(Duration(days: 30)),
                          images: [ImageModel(imagePath: 'room.jpg')],
                          slots: [],
                        );

                        return Container(
                          width: screenWidth * 0.5,
                          // Set the width of each product card

                          constraints: BoxConstraints(maxWidth: 280),
                          child: ProductCard(
                            product: dummyProduct,
                            onPress: () {
                              // Handle product card tap
                              print('Product ${index + 1} tapped');
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ]),
          ))
        ],
      ),
    );
  }
}
