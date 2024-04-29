import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:dbs_frontend/Themes/Buttons.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:dbs_frontend/Utilities/SharedPreferences.dart';
import 'package:dbs_frontend/pages/Orders/orderSummary.dart';
import 'package:dbs_frontend/pages/Orders/ordersController.dart';
import 'package:dbs_frontend/pages/Orders/statusIcons.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  final List<Map<String, dynamic>> orders;

  OrderCard({Key? key, required this.orders}) : super(key: key);
  final OrdersController ordersController = Get.find();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    // Sort orders by booking date in descending order
    orders.sort((a, b) => DateTime.parse(b['timestamp'])
        .compareTo(DateTime.parse(a['timestamp'])));

    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenWidth * 0.4,
              height: screenWidth * 0.4,
              child: Image.asset(
                'assets/images/no_orders_.png',
                fit:
                    BoxFit.cover, // Adjust fit as needed (cover, contain, etc.)
              ),
            ),
            // Add some spacing
            vSpace(20),
            Text(
              "NO ORDERS",
              style: TextStyle(
                  fontSize: (screenWidth * 0.05).clamp(10, 24),
                  fontWeight: FontWeight.bold),
            ),
            Text("Seems like you haven't placed any order yet !",
                style: TextStyle(
                  fontSize: (screenWidth * 0.03).clamp(10, 20),
                )),
          ],
        ),
      );
    } else {
      return FutureBuilder(
          future: Future.value(orders),
          builder: (BuildContext context,
              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1e2022)),
                ),
              );
            } else {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                final orders = snapshot.data!;
                // Sort orders by booking date in descending order
                orders.sort((a, b) => DateTime.parse(b['bookingDate'])
                    .compareTo(DateTime.parse(a['bookingDate'])));

                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth > 650 ? (screenWidth * 0.03) : 0,
                  ),
                  child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (BuildContext context, int index) {
                      final bookingData = orders[index];
                      final bookingId = bookingData['bookingId'].toString();
                      final bookingDate = bookingData['bookingDate'];
                      final booking_fromDatetime =
                          bookingData['booking_fromDatetime'];
                      final booking_toDatetime =
                          bookingData['booking_toDatetime'];
                      final status = getStatusText(bookingData['status']);
                      final grandTotal = bookingData['grandTotal'];

                      return GestureDetector(
                        onTap: () => {
                          Get.to(OrderDetailsPage(
                              orderId: int.parse(bookingId),
                              orderData: bookingData))
                        },
                        child: Card(
                          elevation: 6.0,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Column(
                              children: [
                                Container(
                                  color: Color.fromARGB(255, 219, 217, 217),
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'ORDER ID #$bookingId',
                                        style: TextStyle(
                                          fontSize: (screenWidth * 0.03)
                                              .clamp(10, 16),
                                          color: primary100,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      Icon(
                                        getStatusInfo(bookingData['status'])
                                            .icon,
                                        color:
                                            getStatusInfo(bookingData['status'])
                                                .color,
                                        size:
                                            (screenWidth * 0.04).clamp(16, 22),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Booking Date',
                                            style: TextStyle(
                                              fontSize: (screenWidth * 0.025)
                                                  .clamp(8, 14),
                                              color: Colors.grey,
                                            ),
                                          ),

                                          // Text(
                                          //   DateFormat('MMMM d, y')
                                          //       .format(DateTime.parse(bookingDate)),
                                          //   style: const TextStyle(fontSize: 14.0),
                                          // ),

                                          // Displaying booking From date for SLOT
                                          // Displaying CHECK IN & CHECK OUT DATES for DAY

                                          SharedPrefs.getString(
                                                      BUSINESS_CATEGORYID) ==
                                                  '1'
                                              ? Column(
                                                  children: [
                                                    const SizedBox(height: 4.0),
                                                    Text(
                                                      DateFormat('MMMM d, y')
                                                          .format(DateTime.parse(
                                                              booking_fromDatetime)),
                                                      style: TextStyle(
                                                          fontSize:
                                                              (screenWidth *
                                                                      0.027)
                                                                  .clamp(
                                                                      8, 16)),
                                                    )
                                                  ],
                                                )
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${DateFormat('MMMM d, y').format(DateTime.parse(booking_fromDatetime))} to ',
                                                      style: TextStyle(
                                                          fontSize:
                                                              (screenWidth *
                                                                      0.027)
                                                                  .clamp(
                                                                      8, 16)),
                                                    ),
                                                    Text(
                                                      DateFormat('MMMM d, y')
                                                          .format(DateTime.parse(
                                                              booking_toDatetime)),
                                                      style: TextStyle(
                                                          fontSize:
                                                              (screenWidth *
                                                                      0.027)
                                                                  .clamp(
                                                                      8, 16)),
                                                    ),
                                                  ],
                                                )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Status',
                                            style: TextStyle(
                                              fontSize: (screenWidth * 0.025)
                                                  .clamp(8, 14),
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(height: 4.0),
                                          Row(
                                            children: [
                                              getStatusCircle(
                                                  bookingData['status'],
                                                  screenWidth),
                                              hSpace(4),
                                              Text(
                                                status,
                                                style: TextStyle(
                                                  fontSize:
                                                      (screenWidth * 0.027)
                                                          .clamp(8, 16),
                                                  // color: getStatusCircle(
                                                  //     bookingData['status'])
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Grand Total',
                                            style: TextStyle(
                                              fontSize: (screenWidth * 0.025)
                                                  .clamp(8, 14),
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(height: 4.0),
                                          Text(
                                            '₹ $grandTotal',
                                            style: TextStyle(
                                              fontSize: (screenWidth * 0.027)
                                                  .clamp(8, 14),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: DottedLine(
                                    lineLength: double.infinity,
                                    lineThickness: 0.7,
                                    dashLength: 10.0,
                                    dashGapLength: 4.0,
                                    dashColor: Colors.grey,
                                  ),
                                ),
                                bookingData['status'] == 3
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 8, 8, 8),
                                              child: TextButton(
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    elevation: 2,
                                                    showDragHandle: true,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AnimatedContainer(
                                                        duration: Duration(
                                                            milliseconds:
                                                                40000), // Adjust the duration as needed
                                                        curve: Curves
                                                            .easeInOut, // Adjust the curve as needed
                                                        child: Container(
                                                            // height: screenHeight * 0.25,
                                                            child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                              ListTile(
                                                                title: Padding(
                                                                  padding: EdgeInsets.fromLTRB(
                                                                      screenWidth *
                                                                          0.01,
                                                                      screenHeight *
                                                                          0.01,
                                                                      screenWidth *
                                                                          0.01,
                                                                      screenHeight *
                                                                          0.01),
                                                                  child: Text(
                                                                    'Are you sure you want to cancel the order?',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.fromLTRB(
                                                                    0,
                                                                    screenHeight *
                                                                        0.01,
                                                                    0,
                                                                    screenHeight *
                                                                        0.05),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    mainOutLinedButton(
                                                                        'No',
                                                                        onPress:
                                                                            () {
                                                                      Get.back();
                                                                    }),
                                                                    SizedBox(
                                                                        width:
                                                                            16),
                                                                    mainButton(
                                                                        'YES',
                                                                        onPress:
                                                                            () async {
                                                                      Get.back();
                                                                      await ordersController.cancelOrder(
                                                                          bookingId,
                                                                          context);
                                                                    }),
                                                                  ],
                                                                ),
                                                              )
                                                            ])),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Text(
                                                  'CANCEL ORDER',
                                                  style: TextStyle(
                                                      color: primary100,
                                                      fontSize:
                                                          (screenWidth * 0.04)
                                                              .clamp(10, 14)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 2.0,
                                            height: 20.0,
                                            color: Colors.grey,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 8, 8, 8),
                                              child: TextButton(
                                                onPressed: () {
                                                  print(
                                                      "VIEW SUMMARY CLICKED ----- ");
                                                  Get.to(OrderDetailsPage(
                                                      orderId:
                                                          int.parse(bookingId),
                                                      orderData: bookingData));
                                                },
                                                child: Text(
                                                  'VIEW SUMMARY',
                                                  style: TextStyle(
                                                      color: primary100,
                                                      fontSize:
                                                          (screenWidth * 0.04)
                                                              .clamp(10, 14)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 8, 8, 8),
                                                child: TextButton(
                                                  onPressed: () {
                                                    print(
                                                        "VIEW SUMMARY CLICKED ----- ");
                                                    print(
                                                        "Type of orderData: ${bookingData.runtimeType}");
                                                    print(
                                                        "Type of orderData: ${int.parse(bookingId)}.runtimeType}");
                                                    print(bookingData);
                                                    Get.to(OrderDetailsPage(
                                                        orderId: int.parse(
                                                            bookingId),
                                                        orderData:
                                                            bookingData));
                                                  },
                                                  child: Text(
                                                    'VIEW SUMMARY',
                                                    style: TextStyle(
                                                        color: primary100,
                                                        fontSize:
                                                            (screenWidth * 0.04)
                                                                .clamp(10, 14)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }
          });
    }
  }

  Widget getStatusCircle(int statusCode, double screenWidth) {
    Color color;
    switch (statusCode) {
      case 2:
        color = Color(0xFFf29229); // Example color for "Pending" status
        break;
      case 3:
        color = Color.fromARGB(
            255, 19, 66, 207); // Royal blue color for "Confirmed" status
        break;

      case 4:
        color = Color.fromARGB(
            255, 47, 204, 52); // Example color for "Completed" status
        break;
      case 5:
        color = Colors.red; // Example color for "Cancelled" status
        break;
      case 6:
        color = Color(0xFF8B0000); // Example color for "Rejected" status
        break;
      default:
        color = Colors.grey; // Default color for unknown status
        break;
    }

    return Container(
      width: (screenWidth * 0.03).clamp(10, 12),
      height: (screenWidth * 0.03).clamp(10, 12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );

    // return color;
  }

  String getStatusText(int statusCode) {
    switch (statusCode) {
      case 2:
        return 'Pending';
      case 3:
        return 'Confirmed';
      case 4:
        return 'Completed';
      case 5:
        return 'Cancelled';
      case 6:
        return 'Rejected';
      default:
        return 'Unknown';
    }
  }
}
