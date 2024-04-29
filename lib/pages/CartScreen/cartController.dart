import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:dbs_frontend/Utilities/SharedPreferences.dart';
import 'package:dbs_frontend/appCommon/ApiService.dart';
import 'package:dbs_frontend/models/cartItem_model.dart';
import 'package:dbs_frontend/pages/BottomNavigationBar/screen.dart';
import 'package:dbs_frontend/pages/SuccessScreen/SuccessAnimation.dart';
import 'package:dbs_frontend/pages/SuccessScreen/successController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = List.generate(0, (index) => CartItem(), growable: true).obs;
  RxBool isCartLoading = false.obs;
  RxBool isCartUpdating = false.obs;
  RxBool isConfirmingBooking = false.obs;
  RxInt unavailableProductCnt = 0.obs;
  final SuccessAnimationController bookingSuccessController =
      Get.put(SuccessAnimationController());
  final businessCategoryId =
      int.tryParse(SharedPrefs.getString(BUSINESS_CATEGORYID)!) ??
          1; // Default 1
  RxDouble grandTotal = 0.0.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchCart();
    print(cartItems);
    print("Error Count:");
    print(unavailableProductCnt);
    // addDummyData(); // Add dummy data on initialization
  }

  Future<void> updateQuantity(int index, int newQuantity, context) async {
    // if (newQuantity <= 0) return; // Handle invalid quantities
    final item = cartItems[index];
    int oldQuantity = item.quantity!;
    cartItems[index] = item.updateQuantity(newQuantity); // Update locally
    update(); // Inform GetX about changes
    // print("cnt:");
    // print(errorCnt == 0);

    List<String> quantity = ['${newQuantity}'];
    Map<String, dynamic> addToCartData = {
      'bookingCategoryId': businessCategoryId,
      'bookingFromDate':
          businessCategoryId == 1 ? item.slotFromDateTime : item.checkInDate,
      'bookingToDate': businessCategoryId == 1
          ? item.slotToDateTime
          : DateTime.parse(item.checkOutDate!).subtract(Duration(days: 1)),
      'productId': item.productId,
      'quantity': quantity, // Pass as an array
    };
    if (businessCategoryId == 1) {
      List<int> slotIds = [item.slotId!];
      addToCartData['slotIds'] = slotIds;
    }
    print("not after");
    print(addToCartData);
    await updateCartReq(addToCartData, oldQuantity, index, context);
    print("after");
    print("Error Count:");
    print(unavailableProductCnt);
  }

  Future<void> removeItemFromCart(CartItem item, context) async {
    // cartItems.remove(item);
    Map<String, dynamic> removeFromCartData = {
      'bookingCategoryId': businessCategoryId,
      'productId': item.productId,
    };

    if (businessCategoryId == 1) {
      removeFromCartData['slotId'] = item.slotId;
    }
    await removeFromCartReq(removeFromCartData, context);
    if (item.productAvailable == 0) unavailableProductCnt -= 1;
    update(); // Inform GetX about changes
  }

  Future<void> confirmBooking(context) async {
    // cartItems.remove(item);
    await confirmBookingReq(context);
    update(); // Inform GetX about changes
  }

  Future<void> fetchCart() async {
    print("Api call");
    Map<String, dynamic> queryParams = {
      'businessCategoryId': businessCategoryId,
    };
    // print(cnt);
    unavailableProductCnt.value = 0;
    isCartLoading(true);
    ApiService.get(
      API_GET_CART,
      success: (data) async {
        print(data);
        cartItems.clear();
        if (data['items']!.length != 0) {
          if (businessCategoryId == 1) {
            data['items'].forEach((v) {
              grandTotal.value = v['grandTotal'].toDouble();
              if (!isBookingFromDateValid(v['slotFromDateTime'])) {
                unavailableProductCnt += 1;
                cartItems.add(
                  CartItem.fromJson(v).updateProductAvailability(0),
                );
              } else {
                cartItems.add(CartItem.fromJson(v));
              }
            });
            print("Data=");
          } else if (businessCategoryId == 2) {
            print("cart 2 ");
            if (data['items'][0]['products'] != null) {
              grandTotal.value = data['items'][0]['grandTotal'].toDouble();
              print(data['items'][0]['products']);
              data['items'][0]['products']?.forEach((json) {
                Map<String, dynamic> modifiedJson = {
                  ...json,
                  'grandTotal': grandTotal.value,
                  'checkInDate': data['items'][0]['checkInDate'],
                  'checkOutDate': data['items'][0]['checkOutDate'],
                };
                if (!isBookingFromDateValid(modifiedJson['checkInDate'])) {
                  unavailableProductCnt += 1;
                  print(modifiedJson);
                  cartItems.add(CartItem.fromJson(modifiedJson)
                      .updateProductAvailability(0));
                } else {
                  print(modifiedJson);
                  cartItems.add(CartItem.fromJson(modifiedJson));
                }
              });
              print("Items Idhar he");
              print(cartItems);
            }
          }
        }
        isCartLoading(false);
      },
      failed: (data) async {
        isCartLoading(false);
        print('API request failed: $data');
        showGetXBar(data["msg"]);
        // Get.to(HomeScreen());
      },
      error: (msg) {
        print(msg);
        print("error ");
        isCartLoading(false);
        showGetXBar(msg);
        // Get.to(HomeScreen());
      },
      params: queryParams,
    );
  }

  Future<void> updateCartReq(Map<String, dynamic> addToCartData,
      int oldQuantity, int index, context) async {
    var screenHeight = MediaQuery.of(context).size.height;
    isCartUpdating(true);
    ApiService.post(
      API_ADD_TO_CART,
      param: addToCartData,
      success: (data) async {
        print("SUCCESS");
        print(data);

        var message = data['msg'] != null ? data['msg'].toString() : '';

        // NAVIGATE TO CART PAGE WHICH IS AT INDEX 1S
        message != ''
            ? showSuccessToastMessage(context, '$message',
                bottomPadding: screenHeight * 0.1)
            : null;

        // Delay navigation to CartPage for 2 seconds using Future.delayed
        await fetchCart();
        isCartUpdating(false);
      },
      failed: (data) async {
        cartItems[index] = cartItems[index].updateQuantity(oldQuantity);
        cartItems.refresh();
        // Here you need to call the animation box for showing error  messages
        isCartUpdating(false);
        print('API request failed: $data');

        var message = data['msg'] != null
            ? data['msg'].toString()
            : ''; // Handle missing 'msg' field
        var error = data['err'] != null ? data['err'].toString() : '';

        error == ''
            ? showErrorToastMessage(context, '$message',
                bottomPadding: screenHeight * 0.1)
            : showErrorToastMessage(context, '$error',
                bottomPadding: screenHeight * 0.1);

        // showGetXBar(data["err"]);
      },
      error: (msg) async {
        print("Error: $msg");
        isCartUpdating(false);
        cartItems[index] = cartItems[index].updateQuantity(oldQuantity);
        cartItems.refresh();
        // isSlotLoading(false);
        showErrorToastMessage(context, '$msg',
            bottomPadding: screenHeight * 0.1);
      },
    );
  }

  bool isBookingFromDateValid(String bookingFromDate) {
    DateTime currentDateTime = DateTime.now();
    DateTime bookingFromDateTime = DateTime.parse(bookingFromDate);
    // bool ans =
    return bookingFromDateTime.isAfter(currentDateTime);
  }

  Future<void> removeFromCartReq(
      Map<String, dynamic> removeFromCartData, context) async {
    var screenHeight = MediaQuery.of(context).size.height;
    isCartUpdating(true);
    ApiService.post(
      API_REMOVE_FROM_CART,
      param: removeFromCartData,
      success: (data) async {
        print("SUCCESS");
        print(data);

        var message = data['msg'] != null ? data['msg'].toString() : '';

        // NAVIGATE TO CART PAGE WHICH IS AT INDEX 1S
        message != ''
            ? showSuccessToastMessage(context, '$message',
                bottomPadding: screenHeight * 0.1)
            : null;

        // Delay navigation to CartPage for 2 seconds using Future.delayed
        await fetchCart();
        isCartUpdating(false);
      },
      failed: (data) async {
        // Here you need to call the animation box for showing error  messages
        isCartUpdating(false);
        print('API request failed: $data');

        var message = data['msg'] != null
            ? data['msg'].toString()
            : ''; // Handle missing 'msg' field
        var error = data['err'] != null ? data['err'].toString() : '';

        error == ''
            ? showErrorToastMessage(context, '$message',
                bottomPadding: screenHeight * 0.1)
            : showErrorToastMessage(context, '$error',
                bottomPadding: screenHeight * 0.1);

        // showGetXBar(data["err"]);
      },
      error: (msg) async {
        print("Error: $msg");
        isCartUpdating(false);

        // isSlotLoading(false);
        showErrorToastMessage(context, '$msg',
            bottomPadding: screenHeight * 0.1);
      },
    );
  }

  Future<void> confirmBookingReq(context) async {
    isConfirmingBooking(true);
    ApiService.post(
      API_CONFIRM_BOOKING,
      success: (data) async {
        print("Booking Req:");
        print(data);

        var message =
            data['msg'] != null ? data['msg'].toString() : 'Booking Confirmed!';

        // NAVIGATE TO CART PAGE WHICH IS AT INDEX 1S
        // message != '' ? showSuccessToastMessage(context, '$message') : null;

        // Delay navigation to CartPage for 2 seconds using Future.delayed
        // Get.find<HomeScreenController>().changeTabIndex(2);

        // Get.to(HomeScreen(), transition: Transition.cupertino);
        bookingSuccessController.setSuccessMessage(message);
        Get.off(SuccessAnimationPage());
        isConfirmingBooking(false);
      },
      failed: (data) async {
        // Here you need to call the animation box for showing error  messages
        isConfirmingBooking(false);
        print('API request failed: $data');

        var message = data['msg'] != null
            ? data['msg'].toString()
            : ''; // Handle missing 'msg' field
        var error = data['err'] != null ? data['err'].toString() : '';

        error == ''
            ? showErrorToastMessage(context, '$message')
            : showErrorToastMessage(context, '$error');

        // showGetXBar(data["err"]);
      },
      error: (msg) async {
        print("Error: $msg");
        isConfirmingBooking(false);

        // isSlotLoading(false);
        showErrorToastMessage(context, '$msg');
      },
    );
  }
}
