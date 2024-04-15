import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:dbs_frontend/appCommon/ApiService.dart';
import 'package:dbs_frontend/models/product_model.dart';
import 'package:dbs_frontend/pages/BottomNavigationBar/screen.dart';
import 'package:dbs_frontend/pages/HomeScreen/homePageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Public variable

// import 'package:timezone/timezone.dart' as tz;
class DayWiseSelectionController extends GetxController {
  late final HomePageController homePageController;
  late final RxList<DateTime> selectedDates;
  final RxInt selectedQuantity = 1.obs;
  Rx<bool> isAddToCartRequestLoading = false.obs;

  late final ProductModel product;
  DayWiseSelectionController({required this.product});

  @override
  void onInit() {
    super.onInit();
    homePageController = Get.find<HomePageController>();

    print("homePageController.checkInDate");
    print(homePageController.checkInDate);
    print(homePageController.checkOutDate);

    print("PRODUCT ACTIVE FROM DATE");
    print(product.activeFromDate);
    print(product.activeToDate);

    // Calculate default dates with condition
    final defaultStartDate = calculateDefaultStartDate();
    final defaultEndDate =
        calculateDefaultEndDate(); // Adjust duration as needed

    selectedDates = (homePageController.checkInDate.value != null &&
            homePageController.checkOutDate.value != null)
        ? [
            homePageController.checkInDate.value!,
            homePageController.checkOutDate.value!
          ].obs
        : [defaultStartDate, defaultEndDate].obs;
  }

// Helper function to calculate default start date
  DateTime calculateDefaultStartDate() {
    final now = DateTime.now().toLocal();
    print("me now");
    print(now);
    final activeFromDate = product.activeFromDate;
    // Ensure non-nullable activeFromDate and activeToDate (if needed)
    // (See previous discussions on handling null values)

    // Calculate default start date considering active dates
    return now.isBefore(
            activeFromDate!) // Use null-assertion operator if confident
        ? activeFromDate
        : now;
  }

  DateTime calculateDefaultEndDate() {
    // final nowPlus10Days = DateTime.now().add(const Duration(days: 1));
    // final now = DateTime.now();
    // final advanceBookingDuration = product.advanceBookingDuration;
    // final activeToDate = product.activeToDate;

    // final potentialEndDate;

    // if(activeToDate.isBefore(now.add(const Duration(days:advanceBookingDuration ?? 0))));

    // print("nowPlus10Days");
    // print(nowPlus10Days);

    // print("activeToDate");
    // print(advanceBookingDuration);
    // // Ensure non-nullable activeFromDate and activeToDate (if needed)
    // // (See previous discussions on handling null values)

    // // Calculate default start date considering active dates
    // return nowPlus10Days.isAfter(DateTime.now().add(
    //         Duration(days: advanceBookingDuration ?? 0))) // Use 0 as default
    //     ? DateTime.now().add(Duration(days: advanceBookingDuration ?? 0))
    //     : nowPlus10Days;
    print("Ham he");

    print(product.advanceBookingDuration);
    print(product.activeToDate);
    var stDate = calculateDefaultStartDate();
    // print(stDate.add(Duration(days: 9)));
    // print(stDate
    //     .add(Duration(days: product.advanceBookingDuration! - 1))
    //     .compareTo(product.activeToDate!));

    var potentialEndDate = stDate
                .add(Duration(days: product.advanceBookingDuration! - 1))
                .isBefore(product.activeToDate!) ==
            1
        ? stDate.add(Duration(days: product.advanceBookingDuration! - 1))
        : product.activeToDate!;
    print("me potential");
    print(potentialEndDate);
    print(DateTime.now().add(Duration(days: 1)));
    return stDate.add(Duration(days: 1)).isBefore(potentialEndDate)
        ? stDate.add(Duration(days: 1))
        : potentialEndDate;
  }

  // Function to update selected dates from the calendar
  void updateSelectedDates(List<DateTime> newDates) {
    print("newDates");
    print(newDates);
    selectedDates.assignAll(newDates);
  }

  void decrementQuantity() {
    if (selectedQuantity.value > 1) {
      selectedQuantity.value--;
    } else {
      // Show error message (red color)
      Get.snackbar(
        "Quantity Error",
        "Minimum quantity is 1.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void incrementQuantity() {
    print("Before incrementing");
    print(selectedQuantity.value);
    selectedQuantity
        .value++; // No need for explicit checks as quantity can be any integer

    print("After incrementing");
    print(selectedQuantity.value);
  }

  void initializeAddToCartData(context) {
    // var quantity = [];
    // quantity.add(selectedQuantity.value);

    // Convert the quantity to a list of strings
    var quantity = [selectedQuantity.value];
    Map<String, dynamic> addToCartData = {
      'bookingCategoryId': '2',
      'bookingFromDate': selectedDates.first,
      'bookingToDate': selectedDates.last,
      'productId': product.productId,
      'quantity': quantity, // Pass as an array
    };

    addToCart(addToCartData, context);
  }

  Future<void> addToCart(Map<String, dynamic> addToCartData, context) async {
    isAddToCartRequestLoading(true);
    ApiService.post(
      API_ADD_TO_CART,
      param: addToCartData,
      success: (data) async {
        print("SUCCESS BHAI SUCCESS");
        print(data);

        isAddToCartRequestLoading(false);
        var message = data['msg'] != null ? data['msg'].toString() : '';

        // NAVIGATE TO CART PAGE WHICH IS AT INDEX 1S
        message != '' ? showSuccessToastMessage(context, '$message') : null;

        // Delay navigation to CartPage for 2 seconds using Future.delayed
        await Future.delayed(const Duration(seconds: 1));
        Get.find<HomeScreenController>().changeTabIndex(1);
        Get.to(HomeScreen(), transition: Transition.cupertino);
      },
      failed: (data) async {
        print("FAILED BAKA FAILED");

        print(data);
        isAddToCartRequestLoading(false);
        var message = data['msg'] != null
            ? data['msg'].toString()
            : ''; // Handle missing 'msg' field
        var error = data['err'] != null ? data['err'].toString() : '';

        // showGetXBar('$error');
        // showGetXBar2('$error');
        // showSnackBar(context, '$error');
        // showSnackBar2(context, '$message\n$error');
        // showSnackBar2(context, '$error');
        // showErrorMessage(data);
        // showToast('$error');

        error == ''
            ? showErrorToastMessage(context, '$message')
            : showErrorToastMessage(context, '$error');
      },
      error: (msg) async {
        print("MY GOD ERRORRRRR");
        print("Error: $msg");
        isAddToCartRequestLoading(false);
        // showErrorMessage(msg);
      },
    ); // Initial call to fetch categories
  }

  // void showErrorMessage(dynamic message) {
  //   print("Show error message andar to aivu");
  //   print(message);
  //   print(message['msg']);

  //   var resMsg = message['msg'] != null
  //       ? message['msg']
  //       : ''; // Handle missing 'msg' field
  //   var error = message['err'] != null ? message['err'] : '';
  //   // Implement your error message display logic here
  //   // This could involve using a SnackBar, Toast, or updating a state variable
  //   // that triggers UI updates in your build method (explained later)

  //   errorMessage.value = error == '' ? resMsg : error;
  //   print("Error: $message");
  // }
}
