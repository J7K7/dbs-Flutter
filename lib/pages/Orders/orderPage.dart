import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/pages/Orders/orderCard.dart';
import 'package:dbs_frontend/pages/Orders/ordersController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class OrdersPage extends StatelessWidget {
  // final int initialIndex; // Define initialIndex property
  OrdersPage({Key? key}) : super(key: key);
  final ordersController = Get.put(OrdersController());
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Obx(() => DefaultTabController(
          length: 5,
          initialIndex: ordersController.selectedStatusId.value == 3
              ? 1
              : ordersController.selectedStatusId.value == 4
                  ? 2
                  : ordersController.selectedStatusId.value == 5
                      ? 3
                      : ordersController.selectedStatusId.value == 6
                          ? 4
                          : 0,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'BOOKINGS',
                style: TextStyle(
                    fontSize: screenWidth * 0.035, letterSpacing: 1.5),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Column(
              // Use Column for vertical layout
              children: [
                // Add spacing after the app bar
                TabBar(
                  // physics: NeverScrollableScrollPhysics(),
                  // Removed from AppBar and placed here
                  tabs: const [
                    Tab(text: 'ALL'),
                    Tab(text: 'CONFIRMED'),
                    Tab(text: 'COMPLETED'),
                    Tab(text: 'CANCELLED'),
                    Tab(text: 'REJECTED'),
                    // Tab(text: 'ALL'),
                  ],
                  onTap: (index) async {
                    // Update the selected status ID based on the index of the tapped tab
                    switch (index) {
                      case 0:
                        ordersController.updateSelectedStatusId(0); // For ALL
                        break;
                      case 1:
                        ordersController
                            .updateSelectedStatusId(3); // For UPCOMING
                        break;
                      case 2:
                        ordersController
                            .updateSelectedStatusId(4); // For COMPLETED
                        break;
                      case 3:
                        ordersController
                            .updateSelectedStatusId(5); // For CANCELLED
                        break;
                      case 4:
                        ordersController
                            .updateSelectedStatusId(6); // For REJECTED
                        break;
                    }

                    await ordersController.fetchOrders();
                  },
                  // indicator: MaterialIndicator(
                  //   color: primary100,
                  //   // distanceFromCenter: 16,
                  //   // radius: 3,
                  //   paintingStyle: PaintingStyle.fill,
                  //   strokeWidth: 20,
                  // ),
                  // dragStartBehavior: DragStartBehavior.down,
                  isScrollable: true,
                  indicatorColor: primary100,
                  labelStyle:
                      TextStyle(letterSpacing: 2, fontWeight: FontWeight.w800),
                  labelColor: primary100,
                ),

                Visibility(
                  visible: !ordersController.isOrdersDataLoading.value,
                  replacement: const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFF1e2022)),
                      ),
                    ),
                  ),
                  child: Expanded(
                    // Use Expanded widget to fill remaining space
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          AllOrdersList(),
                          UpcomingOrdersList(),
                          CompletedOrdersList(),
                          CancelledOrdersList(),
                          RejectedOrdersList(),
                          // AllOrdersList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

// Implementations for UpcomingOrdersList, CancelledOrdersList, and CompletedOrdersList remain the same

class AllOrdersList extends StatelessWidget {
  // final int statusId; // Accept statusId as a parameter
  // AllOrdersList({Key? key, required this.statusId}) : super(key: key);
  AllOrdersList({Key? key}) : super(key: key);
  // Retrieve OrdersController
  final OrdersController ordersController = Get.find();

  @override
  Widget build(BuildContext context) {
    // Update selectedStatusId when this list is selected
    // ordersController.updateSelectedStatusId(statusId);
    return Obx(() {
      // Check if data is loading
      if (ordersController.isOrdersDataLoading.value) {
        // If loading, display CircularProgressIndicator
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1e2022)),
          ),
        );
      } else {
        // If not loading, display OrderCard
        return OrderCard(orders: ordersController.orders);
      }
    });
  }
}

class UpcomingOrdersList extends StatelessWidget {
  // final int statusId; // Accept statusId as a parameter
  UpcomingOrdersList({Key? key}) : super(key: key);
  // Retrieve OrdersController
  final OrdersController ordersController = Get.find();

  @override
  Widget build(BuildContext context) {
    // Update selectedStatusId when this list is selected
    // ordersController.updateSelectedStatusId();
    return Obx(() {
      // Check if data is loading
      if (ordersController.isOrdersDataLoading.value) {
        // If loading, display CircularProgressIndicator
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1e2022)),
          ),
        );
      } else {
        // If not loading, display OrderCard
        return OrderCard(orders: ordersController.orders);
      }
    });
  }
}

class CancelledOrdersList extends StatelessWidget {
  // final int statusId; // Accept statusId as a parameter
  CancelledOrdersList({Key? key}) : super(key: key);
  // Retrieve OrdersController
  final OrdersController ordersController = Get.find();

  @override
  Widget build(BuildContext context) {
    // Update selectedStatusId when this list is selected
    // ordersController.updateSelectedStatusId();
    return Obx(() {
      // Check if data is loading
      if (ordersController.isOrdersDataLoading.value) {
        // If loading, display CircularProgressIndicator
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1e2022)),
          ),
        );
      } else {
        // If not loading, display OrderCard
        return OrderCard(orders: ordersController.orders);
      }
    });
  }
}

class CompletedOrdersList extends StatelessWidget {
  // final int statusId; // Accept statusId as a parameter
  CompletedOrdersList({Key? key}) : super(key: key);
  // Retrieve OrdersController
  final OrdersController ordersController = Get.find();

  @override
  Widget build(BuildContext context) {
    // Update selectedStatusId when this list is selected
    // ordersController.updateSelectedStatusId();
    return Obx(() {
      // Check if data is loading
      if (ordersController.isOrdersDataLoading.value) {
        // If loading, display CircularProgressIndicator
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1e2022)),
          ),
        );
      } else {
        // If not loading, display OrderCard
        return OrderCard(orders: ordersController.orders);
      }
    });
  }
}

class RejectedOrdersList extends StatelessWidget {
  // final int statusId; // Accept statusId as a parameter
  RejectedOrdersList({Key? key}) : super(key: key);
  // Retrieve OrdersController
  final OrdersController ordersController = Get.find();

  @override
  Widget build(BuildContext context) {
    // Update selectedStatusId when this list is selected
    // ordersController.updateSelectedStatusId();
    return Obx(() {
      // Check if data is loading
      if (ordersController.isOrdersDataLoading.value) {
        // If loading, display CircularProgressIndicator
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1e2022)),
          ),
        );
      } else {
        // If not loading, display OrderCard
        return OrderCard(orders: ordersController.orders);
      }
    });
  }
}
