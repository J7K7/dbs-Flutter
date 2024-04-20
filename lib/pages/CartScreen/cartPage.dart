// import 'package:dbs_frontend/Themes/UiUtils.dart';
// import 'package:dbs_frontend/pages/CartScreen/cartController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CartPage extends StatelessWidget {
//   // final List<Map<String, dynamic>> items;
//   CartPage({Key? key}) : super(key: key);
//   final CartController cartController = Get.put(CartController());

//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     var screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cart'),
//         automaticallyImplyLeading: false,
//       ),
//       body: Obx(
//         () => ListView.builder(
//           itemCount: cartController.cartItems.length,
//           itemBuilder: (context, index) {
//             final item = cartController.cartItems[index];
//             return ListTile(
//               // contentPadding:
//               // const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//               leading: SizedBox(
//                 width: screenWidth * 0.20,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(2.0),
//                   child: getImageWidget(item['productImage']!),
//                 ),
//               ),
//               title: Text(item['productName']),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Start Time: ${item['slotFromDateTime']}'),
//                   Text('End Time: ${item['slotToDateTime']}'),
//                   Row(
//                     children: [
//                       Text('Price: \$${item['price']}'),
//                       const Spacer(),
//                       IconButton(
//                         icon: const Icon(Icons.remove),
//                         onPressed: () {
//                           if (item['quantity'] > 1) {
//                             item['quantity']--;
//                           }
//                         },
//                       ),
//                       Text('${item['quantity']}'),
//                       IconButton(
//                         icon: const Icon(Icons.add),
//                         onPressed: () => item['quantity']++,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:dbs_frontend/Themes/AppTextStyle.dart';
import 'package:dbs_frontend/Themes/Buttons.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:dbs_frontend/Utilities/SharedPreferences.dart';
import 'package:dbs_frontend/pages/CartScreen/cartController.dart';
// import 'package:dbs_frontend/api_services/your_api_service.dart'; // Replace with your service
// import 'package:dbs_frontend/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var size = screenWidth < screenHeight ? screenWidth : screenHeight;
    cartController.fetchCart();
    // print("Halni");
    // print(screenWidth * 0.25);
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('CART'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false, // Example color
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => cartController.isCartLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : cartController.cartItems.isEmpty
                      ?
                      // Center(
                      //     child: Image.asset(
                      //       'assets/images/cartnew.png', // Add your image path here
                      //       width:
                      //           screenWidth * 0.7, // Adjust the width as needed
                      //     ),
                      //   )
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/Animations/cart.json', // Replace with your animation asset
                              width: size * 0.7, // Adjust the width as needed
                              height: size * 0.7, // Adjust the height as needed
                              repeat:
                                  true, // Adjust animation properties as needed
                              reverse: false,
                              animate: true,
                            ),
                            Text(
                              'YOUR CART IS EMPTY', // Your success message
                              style: AppTextStyles.mediumHeadingTextStyle
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.04),
                            ),
                          ],
                        )
                      : ListView.builder(
                          itemCount: cartController.cartItems.length,
                          itemBuilder: (context, index) {
                            final item = cartController.cartItems[index];
                            return Card(
                              elevation: 4.0,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 4),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width:
                                          (screenWidth * 0.25).clamp(10, 170),
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: item.productImage != null
                                                ? getImageWidget(
                                                    item.productImage!)
                                                : errorImageWidget()),
                                      ),
                                    ),
                                    const SizedBox(width: 16.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Opacity(
                                            opacity: item.productAvailable == 0
                                                ? 0.5
                                                : 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 85,
                                                      child: Text(
                                                        item.productName!
                                                            .toUpperCase(),
                                                        style: AppTextStyles
                                                            .mediumHeadingTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    (screenWidth *
                                                                            0.035)
                                                                        .clamp(
                                                                            14,
                                                                            20)),
                                                      ),
                                                    ),
                                                    // const Spacer(),
                                                    Expanded(
                                                        flex: 10,
                                                        child: InkWell(
                                                          onTap: () {
                                                            // Call removeFromCart function here
                                                            cartController
                                                                .removeItemFromCart(
                                                                    item,
                                                                    context);
                                                          },
                                                          child: Icon(
                                                            Icons.close,
                                                            color: accent200,
                                                            size: (screenWidth *
                                                                    0.04)
                                                                .clamp(14, 28),
                                                          ),
                                                        )),
                                                    hSpace()
                                                  ],
                                                ),
                                                const SizedBox(height: 8.0),
                                                if (SharedPrefs.getString(
                                                        BUSINESS_CATEGORYID) ==
                                                    '1')
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .calendar_today_outlined,
                                                            size: (screenWidth *
                                                                    0.025)
                                                                .clamp(10, 18),
                                                            color: text100,
                                                          ),
                                                          const SizedBox(
                                                              width: 4.0),
                                                          Text(
                                                              formatDate(DateTime
                                                                  .parse(item
                                                                      .slotFromDateTime!)),
                                                              style: AppTextStyles
                                                                  .mediumBodyTextStyle
                                                                  .copyWith(
                                                                      fontSize: (screenWidth *
                                                                              0.025)
                                                                          .clamp(
                                                                              10,
                                                                              18))),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 4.0),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .access_time_outlined,
                                                            size: (screenWidth *
                                                                    0.025)
                                                                .clamp(10, 18),
                                                            color: text100,
                                                          ),
                                                          const SizedBox(
                                                              width: 4.0),
                                                          Text(
                                                              getTimeFromDateTime(item
                                                                  .slotFromDateTime!),
                                                              style: AppTextStyles
                                                                  .mediumBodyTextStyle
                                                                  .copyWith(
                                                                      fontSize: (screenWidth *
                                                                              0.025)
                                                                          .clamp(
                                                                              10,
                                                                              18))),
                                                          const SizedBox(
                                                              width: 4.0),
                                                          const Text(
                                                            '-',
                                                            style: AppTextStyles
                                                                .mediumBodyTextStyle,
                                                          ),
                                                          const SizedBox(
                                                              width: 4.0),
                                                          Text(
                                                            getTimeFromDateTime(
                                                                item.slotToDateTime!),
                                                            style: AppTextStyles
                                                                .mediumBodyTextStyle
                                                                .copyWith(
                                                                    fontSize: (screenWidth *
                                                                            0.025)
                                                                        .clamp(
                                                                            10,
                                                                            18)),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                else
                                                  SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: [
                                                        Column(
                                                          children: [
                                                            // const Column(
                                                            //   crossAxisAlignment:
                                                            //       CrossAxisAlignment.center,
                                                            //   children: [
                                                            //     Text("Check-In",
                                                            //         style: TextStyle(
                                                            //             color: text100,
                                                            //             letterSpacing: 1.5)),
                                                            //   ],
                                                            // ),
                                                            const SizedBox(
                                                                height: 4.0),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .calendar_today_outlined,
                                                                      size: (screenWidth *
                                                                              0.025)
                                                                          .clamp(
                                                                              10,
                                                                              18),
                                                                      color:
                                                                          text100,
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            4.0),
                                                                    Text(
                                                                        formatDate(DateTime.parse(item
                                                                            .checkInDate!)),
                                                                        style: AppTextStyles
                                                                            .mediumBodyTextStyle
                                                                            .copyWith(fontSize: (screenWidth * 0.025).clamp(10, 18))),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    height:
                                                                        4.0),
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .access_time_outlined,
                                                                      size: (screenWidth *
                                                                              0.025)
                                                                          .clamp(
                                                                              10,
                                                                              18),
                                                                      color:
                                                                          text100,
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            4.0),
                                                                    Text(
                                                                        getTimeFromDateTime(item
                                                                            .checkInDate!),
                                                                        style: AppTextStyles
                                                                            .mediumBodyTextStyle
                                                                            .copyWith(fontSize: (screenWidth * 0.025).clamp(10, 18))),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                (screenWidth *
                                                                        0.025)
                                                                    .clamp(
                                                                        4, 16)),
                                                        Icon(
                                                          Icons
                                                              .arrow_right_alt_sharp,
                                                          size: (screenWidth *
                                                                  0.06)
                                                              .clamp(1, 32),
                                                          color: text200,
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                (screenWidth *
                                                                        0.025)
                                                                    .clamp(
                                                                        4, 16)),
                                                        Column(
                                                          children: [
                                                            // Column(
                                                            //   crossAxisAlignment:
                                                            //       CrossAxisAlignment.center,
                                                            //   children: [
                                                            //     Text("Check-out",
                                                            //         style: TextStyle(
                                                            //             color: text100,
                                                            //             letterSpacing: 1.5)),
                                                            //   ],
                                                            // ),
                                                            vSpace(4),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .calendar_today_outlined,
                                                                      size: (screenWidth *
                                                                              0.025)
                                                                          .clamp(
                                                                              10,
                                                                              18),
                                                                      color:
                                                                          text100,
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            4.0),
                                                                    Text(
                                                                        formatDate(DateTime.parse(item
                                                                            .checkOutDate!)),
                                                                        style: AppTextStyles
                                                                            .mediumBodyTextStyle
                                                                            .copyWith(fontSize: (screenWidth * 0.025).clamp(10, 18))),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    height:
                                                                        4.0),
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .access_time_outlined,
                                                                      size: (screenWidth *
                                                                              0.025)
                                                                          .clamp(
                                                                              10,
                                                                              18),
                                                                      color:
                                                                          text100,
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            4.0),
                                                                    Text(
                                                                        getTimeFromDateTime(item
                                                                            .checkOutDate!),
                                                                        style: AppTextStyles
                                                                            .mediumBodyTextStyle
                                                                            .copyWith(fontSize: (screenWidth * 0.025).clamp(10, 18))),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                const SizedBox(height: 8.0),
                                                Row(
                                                  // mainAxisAlignment:
                                                  //     MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        '₹${item.price}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                (screenWidth *
                                                                        0.035)
                                                                    .clamp(
                                                                        10, 24),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    InkWell(
                                                      onTap: () {
                                                        if (item.quantity! >=
                                                            1) {
                                                          int newQuantity =
                                                              item.quantity! -
                                                                  1;
                                                          cartController
                                                              .updateQuantity(
                                                                  index,
                                                                  newQuantity,
                                                                  context); // _controller.decrementQuantity();
                                                        }
                                                      },
                                                      child: Container(
                                                        width:
                                                            (screenWidth * 0.04)
                                                                .clamp(10, 28),
                                                        height:
                                                            (screenWidth * 0.04)
                                                                .clamp(10, 28),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              primary100, // Use your app's color scheme
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.0),
                                                        ),
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.remove,
                                                            size: (screenWidth *
                                                                    0.035)
                                                                .clamp(6, 24),
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8.0),
                                                    Text(
                                                      item.quantity.toString(),
                                                      style: TextStyle(
                                                        fontSize: (screenWidth *
                                                                0.035)
                                                            .clamp(8, 24),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8.0),
                                                    InkWell(
                                                      onTap: () {
                                                        int newQuantity =
                                                            item.quantity! + 1;
                                                        cartController
                                                            .updateQuantity(
                                                                index,
                                                                newQuantity,
                                                                context);
                                                      },
                                                      child: Container(
                                                        width:
                                                            (screenWidth * 0.04)
                                                                .clamp(10, 28),
                                                        height:
                                                            (screenWidth * 0.04)
                                                                .clamp(10, 28),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              primary100, // Use your app's color scheme
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.0),
                                                        ),
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.add,
                                                            size: (screenWidth *
                                                                    0.035)
                                                                .clamp(6, 24),
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    hSpace(16)
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (item.productAvailable == 0)
                                            // vSpace(),
                                            const Opacity(
                                              opacity: 1,
                                              child: Text(
                                                "Product Unavailable Please Remove From Cart",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ),
          BottomAppBar(
            elevation: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Flexible(
                      // Wraps price text in 1/3rd space
                      flex: 1,
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Total Price',
                                style: TextStyle(
                                  fontSize: (screenWidth * 0.03).clamp(8, 18),
                                  color: text200,
                                ),
                              ),
                              TextSpan(
                                text: cartController.grandTotal.value == 0 ||
                                        cartController
                                                .unavailableProductCnt.value !=
                                            0 ||
                                        cartController.cartItems.isEmpty
                                    ? '\n--'
                                    : '\n \u{20B9} ${cartController.grandTotal.value.toString()}',
                                style: AppTextStyles.subheadingTextStyle
                                    .copyWith(
                                        fontSize:
                                            (screenWidth * 0.04).clamp(8, 24)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    // Wraps button in 2/3rd space
                    flex: 2,
                    child: Obx(
                      () => mainButton(
                        "Book Now",
                        isEnabled: cartController.grandTotal.value != 0 &&
                            cartController.unavailableProductCnt.value == 0 &&
                            !cartController.isConfirmingBooking.value &&
                            !cartController.cartItems.isEmpty,
                        // ignore: dead_code

                        onPress: () async {
                          // return showErrorDialog("Me Error Hu", () {
                          print("Proceeesss");
                          await cartController.confirmBooking(context);
                          //   Get.back();
                          // }, () {
                          //   Get.back();
                          // });
                          // if (slotSelectionController.selectedSlot.value ==
                          //     null) {
                          //   showGetXBar("Please select a slot first");
                          //   return;
                          // }
                          // await slotSelectionController.handleBooking(context);
                          // print(slotSelectionController.selectedSlot.value);
                          // print(product.productId);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Helper for formatting date
String formatDate(DateTime dateTime) {
  // Implement your date formatting logic here (e.g., using intl package)
  return DateFormat('yMMMMd').format(dateTime);
}

String getTimeFromDateTime(String dateTimeString) {
  // Parse the date-time string
  DateTime dateTime = DateTime.parse(dateTimeString);

  // Format the time in hh:mm format
  return DateFormat('HH:mm').format(dateTime);
}
