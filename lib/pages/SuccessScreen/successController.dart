import 'package:dbs_frontend/pages/Orders/ordersController.dart';
import 'package:get/get.dart';
import 'package:dbs_frontend/pages/BottomNavigationBar/screen.dart';

class SuccessAnimationController extends GetxController {
  // Method to navigate to the orders page
  RxString successMessage = 'Booking Confirmed!'.obs;

  void setSuccessMessage(String message) {
    successMessage.value = message;
  }

  Future<void> navigateToOrdersPage() async {
    final ordersController = Get.find<OrdersController>();
    ordersController.updateSelectedStatusId(3);
    await ordersController.fetchOrders();

    Get.find<HomeScreenController>().changeTabIndex(2);

    Get.off(HomeScreen(), transition: Transition.cupertino);
  }
}
