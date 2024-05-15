import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:dbs_frontend/Themes/AppTextStyle.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:dbs_frontend/Utilities/SharedPreferences.dart';
import 'package:dbs_frontend/appCommon/ApiService.dart';
import 'package:dbs_frontend/models/product_model.dart';
import 'package:dbs_frontend/models/slot_model.dart';
import 'package:dbs_frontend/pages/BottomNavigationBar/screen.dart';
import 'package:dbs_frontend/pages/CartScreen/cartPage.dart';
import 'package:dbs_frontend/pages/HomeScreen/homePageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SlotSelectionController extends GetxController {
  ProductModel product;
  final HomePageController homePageController = Get.find();
  // RxList<SlotModel> availableSlots = RxList<SlotModel>([]);
  var availableSlots =
      List.generate(0, (index) => SlotModel(), growable: true).obs;
  late DateTime lastDate;
  late DateTime startDate;
  late Rx<DateTime> selectedDate = DateTime.now().obs;
  RxBool isSlotLoading = false.obs;
  RxBool isAddToCartRequestLoading = false.obs;
  int isCartClearingSuccess = -1.obs;
  // late AnimationController _animationController;
  final businessCategoryId =
      int.tryParse(SharedPrefs.getString(BUSINESS_CATEGORYID));
  SlotSelectionController({required this.product}) {
    // Calculate the last date based on advance booking duration
    // lastDate =
    //     DateTime.now().add(Duration(days: product.advanceBookingDuration! - 1));
  }
  @override
  Future<void> onInit() async {
    // _animationController = AnimationController(
    //   vsync: this,
    //   duration: Duration(milliseconds: 300),
    // );
    super.onInit();
    startDate = DateTime.now().isBefore(product.activeFromDate!)
        ? product.activeFromDate!
        : DateTime.now();
    lastDate = startDate
            .add(Duration(days: product.advanceBookingDuration! - 1))
            .isBefore(product.activeToDate!)
        ? startDate.add(Duration(days: product.advanceBookingDuration! - 1))
        : product.activeToDate!;
    selectedDate.value = homePageController.selectedDate.value ?? startDate;

    print(homePageController.selectedDate.value);
    print(selectedDate.value);
    print(product.activeFromDate);
    print("Controller Bhai:");
    print(product.productId);

    await fetchSlots(
        slotDate: DateFormat('yyyy-MM-dd').format(selectedDate.value),
        productId: product.productId.toString()!);
    print(availableSlots);
  }

  Future<void> selectProduct(ProductModel newProduct) async {
    product = newProduct; // Update the product
    availableSlots.clear(); // Clear slots for the previous product
    selectedSlot.value = null; // Reset selected slot
    startDate = DateTime.now().isBefore(product.activeFromDate!)
        ? product.activeFromDate!
        : DateTime.now();
    lastDate = startDate
            .add(Duration(days: product.advanceBookingDuration! - 1))
            .isBefore(product.activeToDate!)
        ? startDate.add(Duration(days: product.advanceBookingDuration! - 1))
        : product.activeToDate!;
    selectedDate.value = homePageController.selectedDate.value ?? startDate;

    await fetchSlots(
        slotDate: DateFormat('yyyy-MM-dd').format(selectedDate.value),
        productId: product.productId.toString()!);
  }

  void clearData() {
    selectedSlot.value = null; // Clear selected slot
    availableSlots.clear(); // Clear available slots
    // Clear other relevant data if needed
  }

  Future<void> selectDate(DateTime date) async {
    selectedDate.value = date;
    print(selectedDate);
    // availableSlots[0].slotPrice = '${availableSlots[0].slotPrice}';
    // update();
    // Perform any actions when a date is selected
    print("Changing Date");
    print("Product iD INSIDE THE SELECT dATE:");
    print(product.productId.toString()!);
    await fetchSlots(
        slotDate: DateFormat('yyyy-MM-dd').format(date),
        productId: product.productId.toString()!);
    // print(availableSlots);
    selectedSlot.value = null;

    // above line
  }

  final selectedSlot = Rx<SlotModel?>(null); // Track selected slot

  void toggleSlotSelection(SlotModel slot) {
    if (selectedSlot.value == slot) {
      selectedSlot.value = null; // Unselect if already selected
    } else {
      selectedSlot.value = slot; // Select the slot
    }
  }

  bool isSelected(SlotModel slot) => selectedSlot.value == slot;

  Future<void> fetchSlots(
      {required String slotDate, required String productId}) async {
    print("Api call");
    Map<String, dynamic> queryParams = {
      'slotDate': slotDate,
      'productId': productId,
    };
    // print(cnt);
    isSlotLoading(true);
    ApiService.get(
      API_GET_SLOTS_BY_DATE,
      success: (data) async {
        print(data);

        availableSlots.clear();
        if (data['slotsData'] != null) {
          data['slotsData'].forEach((v) {
            // DateTime currentTime = DateTime.now();
            String slotDateTimeStr = v['slotFromDateTime'];
            DateTime slotDateTime = DateTime.parse(slotDateTimeStr);
            // print(v['slotFromDateTime']);
            // print(currentTime);
            if (slotDateTime.isAfter(DateTime.now())) {
              availableSlots.add(SlotModel.fromJson(v));
            }
          });
          // print("Data=");
          // print(data);
        }
        selectedSlot.value = null;
        isSlotLoading(false);
      },
      failed: (data) async {
        isSlotLoading(false);
        print('API request failed: $data');
        showGetXBar(data["msg"]);

        // Get.to(HomeScreen());
      },
      params: queryParams,
      error: (msg) {
        print(msg);
        print("error ");
        isSlotLoading(false);
        showGetXBar(msg);
        // Get.to(HomeScreen());
      },
    );
  }

  Future<void> handleBooking(context) async {
    int? selectedSlotId = selectedSlot.value?.slotId;
    print(selectedSlotId);
    if (selectedSlotId == null) {
      showGetXBar("Please select a valid Slot");
      return;
    } else {
      List<String> quantity = ['1'];
      List<int> slotIds = [selectedSlotId];
      Map<String, dynamic> addToCartData = {
        'bookingCategoryId': '1',
        'bookingFromDate': selectedDate,
        'slotIds': slotIds,
        'productId': product.productId,
        'quantity': quantity, // Pass as an array
      };
      print("not after");
      print(addToCartData);

      await addToCartReq(addToCartData, context);
      print("after");
    }
  }

  // void showErrorDialog(String errorMessage) {
  //   Get.defaultDialog(
  //     title: "Attention",
  //     content: Column(
  //       children: [
  //         Text(
  //           errorMessage,
  //           style: AppTextStyles.mediumBodyTextStyle,
  //           textAlign: TextAlign.center,
  //         ),
  //       ],
  //     ),
  //     confirm: ElevatedButton(
  //       onPressed: () {
  //         print("Proceeesss");
  //         Get.back();
  //       },
  //       child: Text("Proceed", style: AppTextStyles.buttonTextStyle),
  //       style: ElevatedButton.styleFrom(
  //           backgroundColor: primary100,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(4.0),
  //           )),
  //     ),
  //     cancel: ElevatedButton(
  //         onPressed: () {
  //           Get.back();
  //         },
  //         child: Text("Cancel", style: AppTextStyles.mediumBodyTextStyle),
  //         style: ElevatedButton.styleFrom(
  //             // backgroundColor: primary100,
  //             shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(4.0),
  //         ))),
  //     barrierDismissible: false,
  //   );
  // }

  Future<void> addToCartReq(Map<String, dynamic> addToCartData, context) async {
    isAddToCartRequestLoading(true);
    ApiService.post(
      API_ADD_TO_CART,
      param: addToCartData,
      success: (data) async {
        print("SUCCESS");
        print(data);

        var message = data['msg'] != null ? data['msg'].toString() : '';

        // NAVIGATE TO CART PAGE WHICH IS AT INDEX 1S
        message != '' ? showSuccessToastMessage(context, '$message') : null;
        clearData();

        // Delay navigation to CartPage for 2 seconds using Future.delayed
        // await Future.delayed(const Duration(seconds: 1));
        isAddToCartRequestLoading(false);

        Get.find<HomeScreenController>().changeTabIndex(1);
        Get.off(HomeScreen(), transition: Transition.cupertino);
      },
      failed: (data) async {
        // Here you need to call the animation box for showing error  messages
        print('API request failed: $data["err"]');
        // showErrorDialog("Me hu na error");
        // Check if the error message is "At a time, you can book products with the same Date."
        // If user Want to replace the product or not that quetion  will be asked here.
        // If yes then go to Cart Page and update the cart data otherwise do nothing.
        if (data["err"] ==
            "At a time, you can book products with the same Date.") {
          showErrorDialog(
              "At a Time Only products with the same date can be added. Proceeding will replace the existing product in your cart with the new selection",
              () {
            print("Proceeesss Starts");
            // First we clear the cart and than add the new product to cart
            // var ans = await clearCart(context);
            // print("Cart Bhai Khatam");
            // print(ans);
            // await addToCartReq(addToCartData, context);
            clearAndAddProduct(addToCartData, context);
            // isAddToCartRequestLoading(false);
            Get.back();
            return;
            // isAddToCartRequestLoading(false);
            // print("Inside if and after:");
            // print(isAddToCartRequestLoading);
            // navigation to CartPage
            // NAVIGATE TO CART PAGE WHICH IS AT INDEX 2

            // Get.find<HomeScreenController>().changeTabIndex(1);
            // Get.off(HomeScreen(), transition: Transition.cupertino);
          }, () {
            // showGetXBar(data["err"]);
            isAddToCartRequestLoading(false);
            Get.back();
            return;
          });
        } else {
          isAddToCartRequestLoading(false);
          var message = data['msg'] != null
              ? data['msg'].toString()
              : ''; // Handle missing 'msg' field
          var error = data['err'] != null ? data['err'].toString() : '';

          error == ''
              ? showErrorToastMessage(context, '$message')
              : showErrorToastMessage(context, '$error');
        }

        // showGetXBar(data["err"]);
      },
      error: (msg) async {
        print("Error: $msg");
        isAddToCartRequestLoading(false);
        isSlotLoading(false);
        showGetXBar(msg);
      },
    );
  }

  Future<void> clearCart(context) async {
    print("Clearing Cart");
    isCartClearingSuccess = -1;
    ApiService.post(
      API_CLEAR_CART, // Assuming API_CLEAR_CART is your endpoint for clearing the cart
      param: {'bookingCategoryId': businessCategoryId},
      success: (data) async {
        // isAddToCartRequestLoading(false);
        isCartClearingSuccess = 1;
        print("Cart Cleared");

        // return true;
      },
      failed: (data) async {
        // isAddToCartRequestLoading(false);
        isCartClearingSuccess = 0;
        print('API request failed while clearing cart: $data');
        var message = data['msg'] != null
            ? data['msg'].toString()
            : ''; // Handle missing 'msg' field
        var error = data['err'] != null ? data['err'].toString() : '';

        error == ''
            ? showErrorToastMessage(context, '$message')
            : showErrorToastMessage(context, '$error');
        // return false;
      },
      error: (msg) async {
        // isCartClearing(false);
        isCartClearingSuccess = -2;
        print("Error while clearing cart: $msg");
        // isAddToCartRequestLoading(false);
        showGetXBar(msg);

        // return false;
      },
    );
  }

  Future<void> clearAndAddProduct(
      Map<String, dynamic> addToCartData, context) async {
    // First clear the cart
    isAddToCartRequestLoading(true);
    // bool clearCartSuccess = false;
    print("clearAndAddProduct1");
    await clearCart(context);
    await Future.delayed(const Duration(
        milliseconds:
            500)); // This Delay is required for giving some delay beetween clear cart and add to cart.
    print(isCartClearingSuccess);

    print("clearAndAddProduct2");
    // If Clear Cart is success Than try to add same product into the cart.
    if (isCartClearingSuccess == 1) {
      await addToCartReq(addToCartData, context);
    }
    print("clearAndAddProduct3");
    isAddToCartRequestLoading(false);
    //   print(clearCartSuccess);
    //   print(isCartClearing);
    //   Future.delayed(1000 as Duration);
    //   if (clearCartSuccess) {
    //     // Clearing cart successful, now add the new product
    //     print("Adding the product in cart");
    //     print(addToCartData);
    //     print(isAddToCartRequestLoading);
    //   } else {
    //     // Handle failure to clear cart
    //     isAddToCartRequestLoading(false);
    //     print("Inside else");
    //     print(clearCartSuccess);
    //     print(isCartClearing);
    //     showErrorToastMessage(context, 'Failed to clear cart');
    //   }
  }
}
