import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:dbs_frontend/Utilities/SharedPreferences.dart';
import 'package:dbs_frontend/models/product_model.dart';
import 'package:dbs_frontend/pages/searchProducts/controller.dart';
import 'package:dbs_frontend/pages/searchProducts/screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dbs_frontend/Themes/AppColors.dart';

class HomePageController extends GetxController {
  // Define textEditingController
  final TextEditingController textEditingController = TextEditingController();
  final ProductListController productListController =
      Get.put(ProductListController());

  /// Which holds the selected date
  /// Defaults to null date.
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  // Rx<DateTime> checkInDate = DateTime.now().obs;
  Rx<DateTime?> checkInDate = Rx<DateTime?>(null);

  // Rx<DateTime> checkOutDate = DateTime.now().obs;
  Rx<DateTime?> checkOutDate = Rx<DateTime?>(null);

  bool isDateRange = false;

  // Select Date or Date Range based on category
  Future<void> selectDate(BuildContext context) async {
    print("category Id");
    print(SharedPrefs.getString(CATEGORYID));
    print("Before Selected Dates : ");
    print(selectedDate);

    if (SharedPrefs.isContains(CATEGORYID)) {
      isDateRange = SharedPrefs.getString(CATEGORYID) == '1' ? false : true;
    }

    if (!isDateRange) {
      // Select single date for Category 1
      final DateTime? picked = await showDatePicker(
        context: context,
        // initialDate: selectedDate.value,
        firstDate: DateTime(2000), // Change to a specific date
        lastDate: DateTime(2025),
        cancelText: 'Cancel',
        confirmText: 'Done',
        builder: (BuildContext context, Widget? child) {
          // Provide builder function
          return Theme(
            // Wrap the child with a Theme widget
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light().copyWith(
                primary: primary100, // Change the theme color as needed
              ),
            ),
            child: child!,
          );
        },
      );

      print("picked");
      print(picked);
      if (picked != null && picked != selectedDate) {
        // Update selectedDate using reactive state management
        selectedDate.value = picked;
        // Update the TextEditingController with the selected date
        // This will update the hintText of the TextField
        textEditingController.text = selectedDate.value != null
            ? DateFormat('yyyy-MM-dd').format(selectedDate.value!)
            : '';

        // update(); // Notify listeners of the change
      }
    } else {
      // Select Range of Date for Category 2
      final DateTimeRange? picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime.now(), // Change to a specific date
        lastDate: DateTime(2025),
        // initialDateRange: DateTimeRange(
        //   start: checkInDate.value,
        //   end: checkOutDate.value,
        // ),
        cancelText: 'Cancel',
        confirmText: 'Done',
        builder: (BuildContext context, Widget? child) {
          // Provide builder function
          return Theme(
            // Wrap the child with a Theme widget
            data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light().copyWith(
                  primary: Colors.black, // Change the theme color as needed
                ),
                datePickerTheme: DatePickerThemeData(
                  rangeSelectionBackgroundColor: primary100.withOpacity(
                      0.13), // Change the color for the range between selected dates
                )),
            child: child!,
          );
        },
      );
      if (picked != null) {
        // Update selectedDate using reactive state management
        checkInDate.value = picked.start;
        checkOutDate.value = picked.end;
        // Update the TextEditingController with the selected date
        // This will update the hintText of the TextField
        String? checkInText = checkInDate.value != null
            ? DateFormat('yyyy-MM-dd').format(checkInDate.value!)
            : null;
        String? checkOutText = checkOutDate.value != null
            ? DateFormat('yyyy-MM-dd').format(checkOutDate.value!)
            : null;

        textEditingController.text =
            (checkInText != null && checkOutText != null
                ? '$checkInText - $checkOutText'
                : null)!;

        // update(); // Notify listeners of the change
      }
    }

    print("After Selected Dates : ");
    print(selectedDate);
  }

  RxString searchQuery = ''.obs;
  Rx<DateTime?> fromDate = Rx<DateTime?>(null);

  void setSearchQuery(String query) {
    print(query);
    searchQuery.value = query;
  }

  void setFromDate(DateTime? date) {
    fromDate.value = date;
  }

  void viewAll() {
    productListController.callAPISearchProducts();
    Get.to(ProductListScreen());
  }

  void handleSearch() {
    // Get the instances of the necessary controllers

    // Call the API with the search parameters
    productListController.callAPISearchProducts(
      q: searchQuery.value,
      slotDate: selectedDate.value != null
          ? DateFormat('yyyy-MM-dd').format(selectedDate.value!)
          : null,
      checkInDate: checkInDate.value != null
          ? DateFormat('yyyy-MM-dd').format(checkInDate.value!)
          : null,
      checkOutDate: checkOutDate.value != null
          ? DateFormat('yyyy-MM-dd').format(checkOutDate.value!)
          : null,
    );
    Get.to(ProductListScreen());
  }
}
