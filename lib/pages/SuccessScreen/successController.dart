import 'package:get/get.dart';
import 'package:dbs_frontend/pages/BottomNavigationBar/screen.dart';

class SuccessAnimationController extends GetxController {
  // Method to navigate to the orders page
  RxString successMessage = 'Booking Confirmed!'.obs;

  void setSuccessMessage(String message) {
    successMessage.value = message;
  }

  void navigateToOrdersPage() {
    Get.find<HomeScreenController>().changeTabIndex(2);

    Get.off(HomeScreen(),
        transition: Transition
            .cupertino); // Replace OrdersPage with your actual orders page
  }
}
