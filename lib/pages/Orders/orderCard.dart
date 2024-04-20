import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/Buttons.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
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
    orders.sort((a, b) => DateTime.parse(b['bookingDate'])
        .compareTo(DateTime.parse(a['bookingDate'])));

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

              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (BuildContext context, int index) {
                  final bookingData = orders[index];
                  final bookingId = bookingData['bookingId'].toString();
                  final bookingDate = bookingData['bookingDate'];
                  final status = getStatusText(bookingData['status']);
                  final grandTotal = bookingData['grandTotal'];

                  return Card(
                    elevation: 6.0,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Column(
                        children: [
                          Container(
                            color: Color(0xFFd8d8d8),
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'ORDER ID #$bookingId',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: primary100,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Icon(
                                  getStatusInfo(bookingData['status']).icon,
                                  color: getStatusInfo(bookingData['status'])
                                      .color,
                                  size: 22.0,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order Date',
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      DateFormat('MMMM d, y')
                                          .format(DateTime.parse(bookingDate)),
                                      style: const TextStyle(fontSize: 14.0),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Status',
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Row(
                                      children: [
                                        getStatusCircle(bookingData['status']),
                                        hSpace(4),
                                        Text(
                                          status,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            // color: getStatusCircle(
                                            //     bookingData['status'])
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Grand Total',
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      '₹ $grandTotal',
                                      style: const TextStyle(
                                        fontSize: 16.0,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 8, 8, 8),
                                        child: TextButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                              context: context,
                                              elevation: 2,
                                              showDragHandle: true,
                                              builder: (BuildContext context) {
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
                                                              MainAxisSize.min,
                                                          children: [
                                                        ListTile(
                                                          title: Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
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
                                                          padding: EdgeInsets
                                                              .fromLTRB(
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
                                                                  onPress: () {
                                                                Get.back();
                                                              }),
                                                              SizedBox(
                                                                  width: 16),
                                                              mainButton('YES',
                                                                  onPress:
                                                                      () async {
                                                                await ordersController
                                                                    .cancelOrder(
                                                                        bookingId,
                                                                        context);
                                                                Get.back();
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
                                            style: TextStyle(color: primary100),
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
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 8, 8, 8),
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            'VIEW SUMMARY',
                                            style: TextStyle(color: primary100),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 8, 8),
                                          child: TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              'VIEW SUMMARY',
                                              style:
                                                  TextStyle(color: primary100),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }
        });
  }

  Widget getStatusCircle(int statusCode) {
    Color color;
    switch (statusCode) {
      case 2:
        color = Color(0xFFf29229); // Example color for "Pending" status
        break;
      case 3:
        color = Color(0xFF4e79b1); // Example color for "Confirmed" status
        break;
      case 4:
        color = Colors.green; // Example color for "Completed" status
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
      width: 12,
      height: 12,
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
