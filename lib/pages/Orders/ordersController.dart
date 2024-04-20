import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:dbs_frontend/appCommon/ApiService.dart';
import 'package:dbs_frontend/pages/BottomNavigationBar/screen.dart';
import 'package:dbs_frontend/pages/Orders/orderPage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class OrdersController extends GetxController {
  // Other existing properties and methods

  // Define a RxList to hold the orders
  RxList<Map<String, dynamic>> orders = <Map<String, dynamic>>[].obs;
  var isOrdersDataLoading = false.obs;
  var isCancelOrderReqLoading = false.obs;
  // Define a RxInt variable to hold the selected statusId
  var selectedStatusId = 0.obs;

  // Function to update the selectedStatusId
  void updateSelectedStatusId(int statusId) {
    selectedStatusId.value = statusId;
    // await fetchOrders(); // Fetch orders whenever the selected status ID changes
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchOrders(); // Fetch orders when the controller is initialized
  }

  Future<void> fetchOrders() async {
    print("selectedStatusId : ");
    print(selectedStatusId);
    isOrdersDataLoading(true);
    Map<String, dynamic> queryParams = {
      if (selectedStatusId >= 0 && selectedStatusId <= 6)
        'statusId': selectedStatusId,
    };
    ApiService.get(API_GET_ALL_ORDERS, success: (data) async {
      print(data);
      if (data is Map<String, dynamic> && data.containsKey('bookings')) {
        final bookings = data['bookings'];
        if (bookings is Map<String, dynamic>) {
          orders.value = bookings.values.toList().cast<Map<String, dynamic>>();
        } else {
          print("Unexpected format for bookings data");
        }
      } else {
        print("Unexpected data format received from the API");
      }
      isOrdersDataLoading(false);
    }, failed: (data) async {
      print("FAILED BAKA FAILED");
      print(data);
      isOrdersDataLoading(false);
    }, error: (msg) async {
      print("Error: $msg");
      isOrdersDataLoading(false);
    }, params: queryParams);
  }

  Future<void> cancelOrder(bookingId, context) async {
    isCancelOrderReqLoading(true);

    Map<String, dynamic> cancelOrderData = {
      'bookingId': bookingId, // Pass as an array
    };

    ApiService.post(API_CANCEL_ORDER_BY_USER, param: cancelOrderData,
        success: (data) async {
      print("SUCCESS BHAI SUCCESSS");
      print(data);
      var message = data['msg'] != null ? data['msg'].toString() : '';

      // NAVIGATE TO CART PAGE WHICH IS AT INDEX 1S
      message != '' ? showSuccessToastMessage(context, '$message') : null;

      // Delay navigation to CartPage for 1 seconds using Future.delayed
      await Future.delayed(const Duration(seconds: 1));
      // updateSelectedStatusId(5);
      // await fetchOrders();
      // Get.to(OrdersPage());
      // Update selectedStatusId to 5 (Canceled Orders) immediately

      final ordersController = Get.find<OrdersController>();
      // final ordersController = Get.put<OrdersController()>;
      // ordersController.updateSelectedStatusId(5);
      // Navigate to the OrdersPage and pass the route name of the canceled tab
      Get.find<HomeScreenController>().changeTabIndex(2);
      // Get.to(HomeScreen(), transition: Transition.cupertino);

      Get.to(HomeScreen(), transition: Transition.cupertino)?.then((_) async {
        // Wait for the navigation to complete
        await Future.delayed(
            const Duration(milliseconds: 250)); // Adjust delay if needed
        ordersController.updateSelectedStatusId(5);
        await ordersController.fetchOrders();
      });

      isCancelOrderReqLoading(false);
    }, failed: (data) async {
      print("FAILED BAKA FAILED");
      print(data);
      var message = data['msg'] != null
          ? data['msg'].toString()
          : ''; // Handle missing 'msg' field
      var error = data['err'] != null ? data['err'].toString() : '';

      error == ''
          ? showErrorToastMessage(context, '$message')
          : showErrorToastMessage(context, '$error');
      isCancelOrderReqLoading(false);
    }, error: (msg) async {
      print("Error: $msg");
      showErrorToastMessage(context, msg);
      isCancelOrderReqLoading(false);
    });
  }
}
