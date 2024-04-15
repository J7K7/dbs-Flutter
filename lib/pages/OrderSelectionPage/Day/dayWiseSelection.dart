import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/AppTextStyle.dart';
import 'package:dbs_frontend/Themes/Buttons.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:dbs_frontend/models/product_model.dart';
import 'package:dbs_frontend/pages/BottomNavigationBar/screen.dart';
import 'package:dbs_frontend/pages/OrderSelectionPage/Day/dayWiseSelectionController.dart';
import 'package:dbs_frontend/pages/ProductDetails/screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DayWiseOrderSelectionPage extends StatelessWidget {
  final ProductModel product;
  // DayWiseOrderSelectionPage({Key? key, required this.product})
  //     : super(key: key);
  // // final dayWiseSelectionController = Get.put(DayWiseSelectionController(product : product));
  // final dayWiseSelectionController =
  //     Get.put(DayWiseSelectionController(product: product));

  late final dayWiseSelectionController;

  DayWiseOrderSelectionPage({Key? key, required this.product})
      : super(key: key) {
    final ProductModel localProduct =
        this.product; // Assign received product to a local variable
    dayWiseSelectionController =
        Get.put(DayWiseSelectionController(product: localProduct));
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    print("product");
    print(product);

    print("image is : ");
    // var imageUrls = product.images!.first['imagePath'];
    var imageUrls = product.images;
    print(imageUrls);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SELECT DATE',
          style: TextStyle(
            fontSize: screenHeight * 0.02,
            fontFamily: 'Poppins',
            color: primary100,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
// Product Image
              Container(
                width: screenWidth * 0.90,
                padding: EdgeInsets.only(top: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: product.images != null && product.images!.isNotEmpty
                      ? getImageWidget(product.images![0]['imagePath']!)
                      : errorImageWidget(),
                ),
              ),
              // Product Name
              Padding(
                padding: EdgeInsets.fromLTRB(
                  screenWidth * 0.1,
                  screenHeight * 0.02,
                  screenWidth * 0.1,
                  0,
                ),
                child: Text(
                  product.productName?.toUpperCase() ??
                      'Product Name Unavailable',
                  style: AppTextStyles.subheadingTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.02),
                child: _showCalendar(),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    screenWidth * 0.1,
                    screenHeight * 0.01,
                    screenWidth * 0.1,
                    screenHeight * 0.01),
                child: _buildDateSelection(
                    dayWiseSelectionController.selectedDates,
                    screenWidth,
                    screenHeight),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(screenWidth * 0.1,
                    screenHeight * 0.01, screenWidth * 0.1, screenHeight * 0.1),
                child: _buildQuantitySelection(),
              ),
            ],
          ),
        ),
      ),
      // ... (your existing code)
      //       bottomNavigationBar: BottomAppBar(
      //         elevation: 0,
      //         child: Container(
      //           padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               // Spacer to fill remaining space

      //               Flexible(
      //                 // Wraps price text in 1/3rd space
      //                 // flex: 1,
      //                 fit: FlexFit.tight,
      //                 child: RichText(
      //                   text: TextSpan(
      //                     children: [
      //                       TextSpan(
      //                         text: 'Price',
      //                         style: TextStyle(
      //                           fontSize: 16,
      //                           color: text200,
      //                         ),
      //                       ),
      //                       TextSpan(
      //                         text: '\n\u{20B9}150',
      //                         style: TextStyle(
      //                             fontSize: 20,
      //                             fontWeight: FontWeight.bold,
      //                             color: primary100),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),

      //               // const SizedBox(width: 8.0), // Add a small spacer
      //               // Spacer(),
      //               Expanded(
      //                 // Wraps button in 2/3rd space
      //                 // flex: 2,
      //                 child: mainButton(
      //                   "Book Now",
      //                   onPress: () {
      //                     print(screenWidth);
      //                     print(product.productId);
      //                     // Get.to(SlotSelectionPage(product: product)); // Assuming your navigation logic
      //                   },
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       )

      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Row(
          children: [
            Expanded(
              child: iconButtonWithArrow("CONTINUE", onPress: () {
                print(screenWidth);
                print(product.productId);

                print("JAY SHREE RAM");
                dayWiseSelectionController.initializeAddToCartData(context);
                // Get.to(SlotSelectionPage(product: product)); // Assuming your navigation logic
              },
                  fontSize: screenWidth * 0.04,
                  iconSize: screenWidth * 0.03,
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 12)),
              // child: mainButton(
              //   "CONTINUE",
              //   onPress: () {
              //     print(screenWidth);
              //     print(product.productId);
              //     // Get.to(SlotSelectionPage(product: product)); // Assuming your navigation logic
              //   },
              // ),
            ),
            // const SizedBox(width: 25.0), // Add a small spacer
            // Price section with intrinsic width
            // IntrinsicWidth(
            //   child: RichText(
            //     text: TextSpan(
            //       children: [
            //         TextSpan(
            //           text: 'Price',
            //           style: TextStyle(
            //             fontSize: 16,
            //             color: text200,
            //           ),
            //         ),
            //         TextSpan(
            //           text: '\n\u{20B9}$product.price',
            //           style: TextStyle(
            //             fontSize: 25,
            //             fontWeight: FontWeight.bold,
            //             color: primary100,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            // Spacer to fill remaining space proportionall// Increase flexibility for spacer
            // Button with remaining space
          ],
        ),
      ),

      // Error message positioned above the bottom navigation bar
    );
  }

  Widget _showCalendar() {
    var lastDate = DateTime.now()
            .add(Duration(days: product.advanceBookingDuration!))
            .isBefore(product.activeToDate!)
        ? DateTime.now().add(Duration(days: product.advanceBookingDuration!))
        : product.activeToDate;

    var firstDate = product.activeFromDate!.isBefore(DateTime.now())
        ? DateTime.now()
        : product.activeFromDate;
    // Example: Use current date as a default

    return Obx(() => CalendarDatePicker2(
          config: CalendarDatePicker2Config(
            calendarType: CalendarDatePicker2Type.range,
            firstDate: firstDate,
            lastDate: lastDate, // Ensure lastDate doesn't exceed activeTillDate
            selectedRangeHighlightColor: primary100.withOpacity(0.13),
            selectedDayHighlightColor: primary100,
          ),
          // ignore: invalid_use_of_protected_member
          value: dayWiseSelectionController.selectedDates.value,
          onValueChanged: (selectedDates) {
            if (selectedDates.length == 2) {
              // Ensure selectedDates contains non-nullable DateTime objects
              final List<DateTime> nonNullableDates = selectedDates
                  .map((date) => date!)
                  .toList(); // Convert to List<DateTime>
              dayWiseSelectionController.updateSelectedDates(nonNullableDates);
            }
          },
        ));
  }

  Widget _buildDateSelection(
      RxList<DateTime?> dates, dynamic screenWidth, dynamic screenHeight) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  'Check-In Date',
                  style: TextStyle(
                    fontSize: (screenWidth * 0.03).clamp(8.0, 18.0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Icon(Icons.calendar_today,
                    size: screenWidth * 0.045), // Add icon if needed
                const SizedBox(height: 8.0),
                Text(
                  dates.first != null
                      ? DateFormat('dd-MM-yyyy').format(dates.first!)
                      : '--',
                  style: TextStyle(
                      fontSize: (screenWidth * 0.04).clamp(8.0, 20.0),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            width: 2.0, // Adjust thickness here
            height: 50.0, // Adjust height as needed
            color: Colors.grey,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  'Check-Out Date',
                  style: TextStyle(
                    fontSize: (screenWidth * 0.03).clamp(8.0, 18.0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Icon(
                  Icons.calendar_today,
                  size: screenWidth * 0.045,
                ), // Add icon if needed
                const SizedBox(height: 8.0),
                Text(
                  dates.last != null
                      ? DateFormat('dd-MM-yyyy').format(dates.last!)
                      : '--',
                  style: TextStyle(
                      fontSize: (screenWidth * 0.04).clamp(8.0, 20.0),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelection() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            // Left side - Quantity text
            children: [
              Text(
                'Quantity',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            // Right side - Buttons & Quantity
            children: [
              GetBuilder<DayWiseSelectionController>(
                init: DayWiseSelectionController(product: product),
                builder: (_controller) => Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (_controller.selectedQuantity.value > 1) {
                          _controller.decrementQuantity();
                        } else {
                          // Show error message within quantity box
                          _controller.selectedQuantity.value =
                              1; // Reset to minimum
                          // Optional: Show a brief visual cue (e.g., red border)
                        }
                      },
                      child: Container(
                        width: 30.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          color: primary100, // Use your app's color scheme
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.remove,
                            size: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Obx(() => Text(
                          _controller.selectedQuantity.value.toString(),
                          style: TextStyle(
                            fontSize: 20.0, // Set red color if quantity <= 1
                          ),
                        )),
                    const SizedBox(width: 8.0),
                    InkWell(
                      onTap: () => _controller.incrementQuantity(),
                      child: Container(
                        width: 30.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          color: primary100, // Use your app's color scheme
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            size: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
