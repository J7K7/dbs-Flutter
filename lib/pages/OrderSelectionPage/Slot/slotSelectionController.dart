import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:dbs_frontend/Themes/AppTextStyle.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
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
  final ProductModel product;
  final HomePageController homePageController = Get.find();
  // RxList<SlotModel> availableSlots = RxList<SlotModel>([]);
  var availableSlots =
      List.generate(0, (index) => SlotModel(), growable: true).obs;
  late DateTime lastDate;
  late DateTime startDate;
  late Rx<DateTime> selectedDate = DateTime.now().obs;
  RxBool isSlotLoading = false.obs;
  RxBool isAddToCartRequestLoading = false.obs;
  // late AnimationController _animationController;

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

  Future<void> selectDate(DateTime date) async {
    selectedDate.value = date;
    print(selectedDate);
    // availableSlots[0].slotPrice = '${availableSlots[0].slotPrice}';
    // update();
    // Perform any actions when a date is selected
    print("Changing Date");
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

        if (data['slotsData'] != null) {
          availableSlots.clear();

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
      selectedSlot.value = null;
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

        // Delay navigation to CartPage for 2 seconds using Future.delayed
        await Future.delayed(const Duration(seconds: 1));
        isAddToCartRequestLoading(false);
        Get.find<HomeScreenController>().changeTabIndex(1);

        Get.to(HomeScreen(), transition: Transition.cupertino);
      },
      failed: (data) async {
        isAddToCartRequestLoading(false);
        // Here you need to call the animation box for showing error  messages
        print('API request failed: $data');
        // showErrorDialog("Me hu na error");
        // Check if the error message is "At a time, you can book products with the same Date."
        // If user Want to replace the product or not that quetion  will be asked here.
        // If yes then go to Cart Page and update the cart data otherwise do nothing.
        if (data["err"] ==
            "At a time, you can book products with the same Date.") {
          showErrorDialog(
              "At a Time Only products with the same date can be added. Proceeding will replace the existing product in your cart with the new selection",
              () {
            print("Proceeesss");
            Get.find<HomeScreenController>().changeTabIndex(1);
            Get.offAll(HomeScreen(), transition: Transition.cupertino);
          }, () {
            // showGetXBar(data["err"]);

            Get.back();
          });
        } else {
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
}
