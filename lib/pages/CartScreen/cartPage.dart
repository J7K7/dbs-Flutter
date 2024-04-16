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

class CartPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    // print("Halni");
    // print(screenWidth * 0.25);
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('CART'),
        elevation: 0,
        backgroundColor: Colors.transparent, // Example color
      ),
      body: Obx(
        () => cartController.cartItems.isEmpty
            ? const Center(
                child: Text(
                  'Your cart is empty.',
                  style: TextStyle(color: text200, fontSize: 16.0),
                ),
              )
            : ListView.builder(
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartController.cartItems[index];
                  return Card(
                    elevation: 2.0,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: (screenWidth * 0.25).clamp(10, 170),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: getImageWidget(
                                      "productImages-1709103738403-304830184.jpg")),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 85,
                                      child: Text(
                                        item.productName!.toUpperCase(),
                                        style: AppTextStyles
                                            .mediumHeadingTextStyle
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: (screenWidth * 0.035)
                                                    .clamp(14, 20)),
                                      ),
                                    ),
                                    // const Spacer(),
                                    Expanded(
                                      flex: 10,
                                      child: Icon(
                                        Icons.close,
                                        color: accent200,
                                        size:
                                            (screenWidth * 0.04).clamp(14, 28),
                                      ),
                                    ),
                                    hSpace()
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                if (SharedPrefs.getString(
                                        BUSINESS_CATEGORYID) ==
                                    '1')
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today_outlined,
                                            size: (screenWidth * 0.025)
                                                .clamp(10, 18),
                                            color: text100,
                                          ),
                                          const SizedBox(width: 4.0),
                                          Text(
                                              formatDate(DateTime.parse(
                                                  item.slotFromDateTime!)),
                                              style: AppTextStyles
                                                  .mediumBodyTextStyle
                                                  .copyWith(
                                                      fontSize:
                                                          (screenWidth * 0.025)
                                                              .clamp(10, 18))),
                                        ],
                                      ),
                                      const SizedBox(height: 4.0),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time_outlined,
                                            size: (screenWidth * 0.025)
                                                .clamp(10, 18),
                                            color: text100,
                                          ),
                                          const SizedBox(width: 4.0),
                                          Text(
                                              getTimeFromDateTime(
                                                  item.slotFromDateTime!),
                                              style: AppTextStyles
                                                  .mediumBodyTextStyle
                                                  .copyWith(
                                                      fontSize:
                                                          (screenWidth * 0.025)
                                                              .clamp(10, 18))),
                                          const SizedBox(width: 4.0),
                                          const Text(
                                            '-',
                                            style: AppTextStyles
                                                .mediumBodyTextStyle,
                                          ),
                                          const SizedBox(width: 4.0),
                                          Text(
                                            getTimeFromDateTime(
                                                item.slotToDateTime!),
                                            style: AppTextStyles
                                                .mediumBodyTextStyle
                                                .copyWith(
                                                    fontSize:
                                                        (screenWidth * 0.025)
                                                            .clamp(10, 18)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                else
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
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
                                            const SizedBox(height: 4.0),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .calendar_today_outlined,
                                                      size:
                                                          (screenWidth * 0.025)
                                                              .clamp(10, 18),
                                                      color: text100,
                                                    ),
                                                    const SizedBox(width: 4.0),
                                                    Text(
                                                        formatDate(
                                                            DateTime.parse(item
                                                                .checkInDate!)),
                                                        style: AppTextStyles
                                                            .mediumBodyTextStyle
                                                            .copyWith(
                                                                fontSize:
                                                                    (screenWidth *
                                                                            0.025)
                                                                        .clamp(
                                                                            10,
                                                                            18))),
                                                  ],
                                                ),
                                                const SizedBox(height: 4.0),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .access_time_outlined,
                                                      size:
                                                          (screenWidth * 0.025)
                                                              .clamp(10, 18),
                                                      color: text100,
                                                    ),
                                                    const SizedBox(width: 4.0),
                                                    Text(
                                                        getTimeFromDateTime(
                                                            item.checkInDate!),
                                                        style: AppTextStyles
                                                            .mediumBodyTextStyle
                                                            .copyWith(
                                                                fontSize:
                                                                    (screenWidth *
                                                                            0.025)
                                                                        .clamp(
                                                                            10,
                                                                            18))),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            width: (screenWidth * 0.025)
                                                .clamp(4, 16)),
                                        Icon(
                                          Icons.arrow_right_alt_sharp,
                                          size:
                                              (screenWidth * 0.06).clamp(1, 32),
                                          color: text200,
                                        ),
                                        SizedBox(
                                            width: (screenWidth * 0.025)
                                                .clamp(4, 16)),
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
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .calendar_today_outlined,
                                                      size:
                                                          (screenWidth * 0.025)
                                                              .clamp(10, 18),
                                                      color: text100,
                                                    ),
                                                    const SizedBox(width: 4.0),
                                                    Text(
                                                        formatDate(
                                                            DateTime.parse(item
                                                                .checkOutDate!)),
                                                        style: AppTextStyles
                                                            .mediumBodyTextStyle
                                                            .copyWith(
                                                                fontSize:
                                                                    (screenWidth *
                                                                            0.025)
                                                                        .clamp(
                                                                            10,
                                                                            18))),
                                                  ],
                                                ),
                                                const SizedBox(height: 4.0),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .access_time_outlined,
                                                      size:
                                                          (screenWidth * 0.025)
                                                              .clamp(10, 18),
                                                      color: text100,
                                                    ),
                                                    const SizedBox(width: 4.0),
                                                    Text(
                                                        getTimeFromDateTime(
                                                            item.checkOutDate!),
                                                        style: AppTextStyles
                                                            .mediumBodyTextStyle
                                                            .copyWith(
                                                                fontSize:
                                                                    (screenWidth *
                                                                            0.025)
                                                                        .clamp(
                                                                            10,
                                                                            18))),
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
                                            fontSize: (screenWidth * 0.035)
                                                .clamp(10, 24),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        if (item.quantity > 1) {
                                          // _controller.decrementQuantity();
                                        } else {
                                          // Show error message within quantity box
                                          // item.quantity = 1; // Reset to minimum
                                          // Optional: Show a brief visual cue (e.g., red border)
                                        }
                                      },
                                      child: Container(
                                        width:
                                            (screenWidth * 0.04).clamp(10, 28),
                                        height:
                                            (screenWidth * 0.04).clamp(10, 28),
                                        decoration: BoxDecoration(
                                          color:
                                              primary100, // Use your app's color scheme
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.remove,
                                            size: (screenWidth * 0.035)
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
                                        fontSize: (screenWidth * 0.035).clamp(8,
                                            24), // Set red color if quantity <= 1
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    InkWell(
                                      // onTap: () =>
                                      // _controller.incrementQuantity(),
                                      child: Container(
                                        width:
                                            (screenWidth * 0.04).clamp(10, 28),
                                        height:
                                            (screenWidth * 0.04).clamp(10, 28),
                                        decoration: BoxDecoration(
                                          color:
                                              primary100, // Use your app's color scheme
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.add,
                                            size: (screenWidth * 0.035)
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
                        ],
                      ),
                    ),
                  );
                },
              ),
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
