import 'package:cached_network_image/cached_network_image.dart';
import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:dbs_frontend/Themes/AppTextStyle.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:dbs_frontend/Utilities/SharedPreferences.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailsPage extends StatelessWidget {
  final int orderId;
  final Map<String, dynamic> orderData;

  const OrderDetailsPage({
    Key? key,
    required this.orderId,
    required this.orderData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("ORder Data : ");
    print(orderData);

    // final dummyBookingData = {
    //   "5906": {
    //     "bookingId": 5906,
    //     "bookingDate": "2024-03-02 00:00:00",
    //     "booking_fromDatetime": "2024-03-03 12:30:00",
    //     "booking_toDatetime": "2024-03-03 15:30:00",
    //     "status": 4,
    //     "grandTotal": 3000,
    //     "timestamp": "2024-03-02 10:42:45",
    //     "products": [dummyProduct1]
    //   },
    //   "5908": {
    //     "bookingId": 5908,
    //     "bookingDate": "2024-03-02 00:00:00",
    //     "booking_fromDatetime": "2024-03-03 09:00:00",
    //     "booking_toDatetime": "2024-03-03 17:00:00",
    //     "status": 5,
    //     "grandTotal": 2340,
    //     "timestamp": "2024-03-02 10:46:58",
    //     "products": [dummyProduct2]
    //   },
    // };

    // print("Dummy data : ");
    // print(dummyBookingData['5906']);
    // Use dummy data if no orderData is provided
    // final Map<String, dynamic> bookingData =
    // final Map<String, dynamic> bookingData = orderData;
    print("bookingData  products is : ");
    // print(orderData['bookingDate']);
    var screenWidth = MediaQuery.of(context).size.width;
    const double GST_RATE = 0.18; // Assuming GST rate is 18%
    print("Screen Width : ");
    print(screenWidth * 0.03);

// Calculate GST amount
    double gstAmount = orderData['grandTotal'] * GST_RATE;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ORDER DETAILS',
          style: TextStyle(fontSize: screenWidth * 0.030, letterSpacing: 1.5),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.035),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'ORDER ID',
                      style: TextStyle(
                          fontSize: (screenWidth * 0.035).clamp(10, 20)),
                    ),
                    hSpace(10),
                    Text(
                      '#${orderId.toString()}',
                      style: TextStyle(
                          fontSize: (screenWidth * 0.04).clamp(10, 24),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    // Text(
                    //   'Booking Date',
                    //   style: TextStyle(fontSize: 18.0),
                    // ),
                    Text(
                      '${DateFormat('dd MMMM yyyy').format(DateTime.parse(orderData['bookingDate']))}',
                      style: TextStyle(
                          fontSize: (screenWidth * 0.04).clamp(10, 24),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),

            // const Padding(
            //   padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            //   child: DottedLine(
            //     lineLength: double.infinity,
            //     lineThickness: 0.7,
            //     dashLength: 10.0,
            //     dashGapLength: 4.0,
            //     dashColor: Colors.grey,
            //   ),
            // ),

            const Divider(thickness: 1.0),
            vSpace(20),
            // Order Items
            Text(
              'ORDER ITEMS',
              style: TextStyle(
                  fontSize: (screenWidth * 0.04).clamp(10, 18),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5),
            ),
            const SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true, // Prevent list view from expanding
              physics:
                  const NeverScrollableScrollPhysics(), // Disable scrolling
              itemCount: orderData['products'].length,
              itemBuilder: (context, index) {
                final product = orderData['products'][index];
                print("Product before widget ");
                print(orderData['products'].length);
                print(product);
                return OrderItemWidget(
                  product: product,
                  orderId: orderId,
                  orderData: orderData,
                );
              },
            ),
            // User Details
            Text(
              'USER DETAILS',
              style: TextStyle(
                fontSize: (screenWidth * 0.04).clamp(10, 18),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),

            const Divider(thickness: 1.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                            letterSpacing: 1,
                            fontSize: (screenWidth * 0.03).clamp(10, 14)),
                      ),
                      Text(
                        '${orderData['user']['firstName']}${orderData['user']['lastName']}',
                        style: TextStyle(
                            letterSpacing: 1,
                            fontSize: (screenWidth * 0.03).clamp(10, 14)),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                            letterSpacing: 1,
                            fontSize: (screenWidth * 0.03).clamp(10, 14)),
                      ),
                      Text('${orderData['user']['email']}',
                          style: TextStyle(
                              letterSpacing: 1,
                              fontSize: (screenWidth * 0.03).clamp(10, 14))),
                    ],
                  ),
                  SizedBox(height: 6.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Phone',
                        style: TextStyle(
                            letterSpacing: 1,
                            fontSize: (screenWidth * 0.03).clamp(10, 14)),
                      ),
                      Text('+91 ${orderData['user']['phoneNumber']}',
                          style: TextStyle(
                              letterSpacing: 1,
                              fontSize: (screenWidth * 0.03).clamp(10, 14))),
                    ],
                  ),
                  SizedBox(height: 6.0),
                ],
              ),
            ),

            // Order Summary
            Text(
              'ORDER SUMMARY',
              style: TextStyle(
                fontSize: (screenWidth * 0.04).clamp(10, 18),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),

            const Divider(thickness: 1.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order Date',
                        style: TextStyle(
                            fontSize: (screenWidth * 0.03).clamp(10, 14)),
                      ),
                      Text(
                          DateFormat('dd MMMM yyyy')
                              .format(DateTime.parse(orderData['bookingDate'])),
                          style: TextStyle(
                              fontSize: (screenWidth * 0.03).clamp(10, 14))),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  SharedPrefs.getString(BUSINESS_CATEGORYID) == '1'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Booking Date',
                                style: TextStyle(
                                    fontSize:
                                        (screenWidth * 0.03).clamp(10, 14))),
                            Text(
                                DateFormat('dd MMMM yyyy').format(
                                    DateTime.parse(
                                        orderData['booking_fromDatetime'])),
                                style: TextStyle(
                                    fontSize:
                                        (screenWidth * 0.03).clamp(10, 14))),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Check-In Date',
                                    style: TextStyle(
                                        fontSize: (screenWidth * 0.03)
                                            .clamp(10, 14))),
                                Text(
                                    DateFormat('dd MMMM yyyy HH:mm').format(
                                        DateTime.parse(
                                            orderData['booking_fromDatetime'])),
                                    style: TextStyle(
                                        fontSize: (screenWidth * 0.03)
                                            .clamp(10, 14))),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Check-Out Date',
                                    style: TextStyle(
                                        fontSize: (screenWidth * 0.03)
                                            .clamp(10, 14))),
                                Text(
                                    DateFormat('dd MMMM yyyy HH:mm').format(
                                        DateTime.parse(
                                            orderData['booking_toDatetime'])),
                                    style: TextStyle(
                                        fontSize: (screenWidth * 0.03)
                                            .clamp(10, 14))),
                              ],
                            ),
                          ],
                        ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Status',
                          style: TextStyle(
                              fontSize: (screenWidth * 0.03).clamp(10, 14))),
                      Text(
                        getStatusText(orderData['status']).toUpperCase(),
                        style: TextStyle(
                            color: getStatusCircle(orderData['status']),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: (screenWidth * 0.03).clamp(10, 14)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ORDER TOTAL',
                          // style: TextStyle(
                          //   fontSize: 16,
                          //   fontWeight: FontWeight.bold,
                          // ),
                          style: TextStyle(
                              fontSize: (screenWidth * 0.03).clamp(10, 14))),
                      Text(
                        '₹ ${orderData['grandTotal'].toStringAsFixed(2)}',
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: (screenWidth * 0.03).clamp(10, 14)),
                      ),
                    ],
                  ),
                  // Calculate GST amount
                  vSpace(8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('GST (18%)',
                          style: TextStyle(
                              fontSize: (screenWidth * 0.03).clamp(10, 14))),
                      Text(
                        '₹ ${(orderData['grandTotal'] * GST_RATE).toStringAsFixed(2)}',
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: (screenWidth * 0.03).clamp(10, 14)),
                      ),
                    ],
                  ),
                  // Compute final total
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                    child: DottedLine(
                      lineLength: double.infinity,
                      lineThickness: 0.7,
                      dashLength: 10.0,
                      dashGapLength: 4.0,
                      dashColor: Colors.grey,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'GRAND TOTAL',
                        style: TextStyle(
                          fontSize: (screenWidth * 0.035).clamp(10, 18),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '₹ ${(orderData['grandTotal'] + (orderData['grandTotal'] * GST_RATE)).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: (screenWidth * 0.035).clamp(10, 18),
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

String getStatusText(int status) {
  switch (status) {
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
      return 'Unknown'; // You can handle other status values here
  }
}

Color getStatusCircle(int statusCode) {
  Color color;
  switch (statusCode) {
    case 2:
      color = Color(0xFFf29229); // Example color for "Pending" status
      break;
    case 3:
      color = Color.fromARGB(255, 19, 66, 207);
      // Example color for "Confirmed" status
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

  return color;
}

class OrderItemWidget extends StatelessWidget {
  final Map<String, dynamic> product;
  final Map<String, dynamic> orderData;
  final int orderId;

  const OrderItemWidget({
    Key? key,
    required this.product,
    required this.orderId,
    required this.orderData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    // Calculate total price of all slots
    int totalPrice = 0;
    for (var slot in product['slots']) {
      totalPrice += slot['price'] as int;
    }

    // Calculate grand total price
    num grandTotalPrice = totalPrice * product['quantity'];

    print("Product dates : ");
    print(product);
    print(orderData['booking_fromDatetime']);
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.grey[400]!),
      //   borderRadius: BorderRadius.circular(10),
      //   // color: Colors.white12,
      // ),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  // ClipRRect(
                  //   borderRadius:
                  //       BorderRadius.circular(10), // Adjust the radius as needed
                  //   child: Image.asset(
                  //     '/${product['productImagePath']}',
                  //     width: 100, // Adjust width as needed
                  //     height: 100, // Adjust height as needed
                  //     fit: BoxFit.cover, // Adjust image fit as needed
                  //   ),
                  // ),

                  Container(
                    width: (screenWidth * 0.25).clamp(30, 120),
                    height: (screenWidth * 0.25).clamp(30, 120),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        imageUrl: PRODUCT_IMAGE_PATH +
                            '${product['productImagePath']}',
                        errorWidget: (context, url, error) =>
                            errorIconWidget(size: 40),
                        placeholder: (context, url) => Center(
                          child: SizedBox(
                            width: 40, // Specify the desired width
                            height: 40, // Specify the desired height
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF1e2022)),
                            ),
                          ),
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Name
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product['productName'],
                              style: TextStyle(
                                  fontSize: (screenWidth * 0.04).clamp(10, 22),
                                  color: primary100,
                                  fontWeight: FontWeight.bold),
                            ),
                            // Price
                            Text(
                              '₹${grandTotalPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: (screenWidth * 0.04).clamp(10, 22),
                                  fontWeight: FontWeight.bold,
                                  color: primary100),
                            ),
                          ],
                        ),
                        // Quantity

                        Container(
                            child: SharedPrefs.getString(BUSINESS_CATEGORYID) ==
                                    '1'
                                ? null
                                : Column(
                                    children: [
                                      vSpace(10),
                                      Text(
                                        'Qty ${product['quantity']}',
                                        style: TextStyle(
                                            fontSize: (screenWidth * 0.035)
                                                .clamp(8, 20),
                                            color: primary100),
                                      ),
                                    ],
                                  )),
                        // Expansion Tile
                        screenWidth >= 650
                            ? Theme(
                                data: Theme.of(context).copyWith(
                                  dividerColor: Colors.transparent,
                                ),
                                child: ExpansionTile(
                                  tilePadding: EdgeInsets.zero,
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SharedPrefs.getString(
                                                  BUSINESS_CATEGORYID) ==
                                              '1'
                                          ? Text(
                                              DateFormat.yMMMMd().format(
                                                  DateTime.parse(orderData[
                                                      'booking_fromDatetime'])),

                                              overflow: TextOverflow
                                                  .ellipsis, // Ensures the text doesn't exceed one line
                                            )
                                          : Text(
                                              '${DateFormat.yMMMMd().format(DateTime.parse(orderData['booking_fromDatetime']))} - ${DateFormat.yMMMMd().format(DateTime.parse(orderData['booking_toDatetime']))}',

                                              overflow: TextOverflow
                                                  .ellipsis, // Ensures the text doesn't exceed one line
                                            ),
                                      const SizedBox(
                                          height:
                                              4.0), // Added SizedBox for spacing
                                    ],
                                  ),
                                  children: [
                                    // Slot Details
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: SharedPrefs.getString(
                                                        BUSINESS_CATEGORYID) ==
                                                    '1'
                                                ? const Text(
                                                    'Slots',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                : const Text(
                                                    'Date',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Center(
                                            child: Text(
                                              'Price',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              'Qty',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              'Total',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ...product['slots'].map<Widget>((slot) {
                                      final dayPrice =
                                          slot['price'] * product['quantity'];
                                      return ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Center(
                                                child: SharedPrefs.getString(
                                                            BUSINESS_CATEGORYID) ==
                                                        '1'
                                                    ? Text(
                                                        '${DateFormat('HH:mm').format(DateTime.parse(slot['slotFromDateTime']))} - ${DateFormat('HH:mm').format(DateTime.parse(slot['slotToDateTime']))}',
                                                      )
                                                    : Text(
                                                        '${DateFormat('EEE, dd MMM yyyy').format(DateTime.parse(slot['slotFromDateTime']))}',
                                                      ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                    '₹ ${slot['price'].toStringAsFixed(2)}'),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                    'x${product['quantity']}'),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                    '₹ ${dayPrice.toStringAsFixed(2)}'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 50),
                                      child: const Divider(),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 50),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Product Total   ₹${grandTotalPrice.toStringAsFixed(2)}',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : vSpace(0),
                      ],
                    ),
                  ),
                ],
              ),
              vSpace(8),
              Row(
                children: [
                  screenWidth < 650
                      ? Expanded(
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent,
                            ),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.zero,
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SharedPrefs.getString(BUSINESS_CATEGORYID) ==
                                          '1'
                                      ? Text(
                                          DateFormat.yMMMMd().format(
                                              DateTime.parse(orderData[
                                                  'booking_fromDatetime'])),
                                          style: TextStyle(
                                            fontSize: (screenWidth * 0.035)
                                                .clamp(10, 20),
                                          ),
                                          overflow: TextOverflow
                                              .ellipsis, // Ensures the text doesn't exceed one line
                                        )
                                      : Text(
                                          '${DateFormat.yMMMMd().format(DateTime.parse(orderData['booking_fromDatetime']))} - ${DateFormat.yMMMMd().format(DateTime.parse(orderData['booking_toDatetime']))}',
                                          style: TextStyle(
                                              fontSize: (screenWidth * 0.035)
                                                  .clamp(10, 20)),
                                          overflow: TextOverflow
                                              .ellipsis, // Ensures the text doesn't exceed one line
                                        ),
                                  const SizedBox(
                                      height:
                                          4.0), // Added SizedBox for spacing
                                ],
                              ),
                              children: [
                                // Slot Details
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: SharedPrefs.getString(
                                                    BUSINESS_CATEGORYID) ==
                                                '1'
                                            ? const Text(
                                                'Slots',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : const Text(
                                                'Date',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                      ),
                                    ),
                                    const Expanded(
                                      child: Center(
                                        child: Text(
                                          'Price',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Qty',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Total',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                ...product['slots'].map<Widget>((slot) {
                                  final dayPrice =
                                      slot['price'] * product['quantity'];
                                  return ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: SharedPrefs.getString(
                                                        BUSINESS_CATEGORYID) ==
                                                    '1'
                                                ? Text(
                                                    '${DateFormat('HH:mm').format(DateTime.parse(slot['slotFromDateTime']))} - ${DateFormat('HH:mm').format(DateTime.parse(slot['slotToDateTime']))}',
                                                    style: TextStyle(
                                                        fontSize:
                                                            screenWidth * 0.03),
                                                  )
                                                : Text(
                                                    '${DateFormat('EEE, dd MMM yyyy').format(DateTime.parse(slot['slotFromDateTime']))}',
                                                    style: TextStyle(
                                                        fontSize: screenWidth *
                                                            0.03)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                                '₹ ${slot['price'].toStringAsFixed(2)}',
                                                style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.03)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                                'x${product['quantity']}',
                                                style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.03)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                                '₹ ${dayPrice.toStringAsFixed(2)}',
                                                style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.03)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.0,
                                      horizontal: screenWidth * 0.03),
                                  child: const Divider(),
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.0,
                                      horizontal: screenWidth * 0.03),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Product Total   ₹${grandTotalPrice.toStringAsFixed(2)}',
                                        style: TextStyle(
                                            fontSize: screenWidth * 0.035,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : vSpace(0)
                ],
              )
            ],
          )),
    );
  }
}
