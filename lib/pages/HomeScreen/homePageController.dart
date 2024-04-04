// import 'dart:ffi';

import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:dbs_frontend/Utilities/SharedPreferences.dart';
import 'package:dbs_frontend/appCommon/ApiService.dart';
import 'package:dbs_frontend/models/category_model.dart';
import 'package:dbs_frontend/models/product_model.dart';
import 'package:dbs_frontend/pages/LandingPage/screen.dart';
import 'package:dbs_frontend/pages/SplashScreen/Controller.dart';
// import 'package:dbs_frontend/pages/SplashScreen/Screen.dart';
import 'package:dbs_frontend/pages/searchProducts/controller.dart';
import 'package:dbs_frontend/pages/searchProducts/screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dbs_frontend/Themes/AppColors.dart';

SplashController splashController = Get.find<SplashController>();

class HomePageController extends GetxController {
  // final splashController = Get.put(SplashController());

  var popularProducts =
      List.generate(0, (index) => ProductModel(), growable: true).obs;
  // Define textEditingController
  final TextEditingController textEditingController = TextEditingController();
  final ProductListController productListController =
      Get.put(ProductListController());
  Rx<bool> getLoadingState() {
    return splashController.isHomePageLoading;
  }

  /// Which holds the selected date
  /// Defaults to null date.
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  // Rx<DateTime> checkInDate = DateTime.now().obs;
  Rx<DateTime?> checkInDate = Rx<DateTime?>(null);

  // Rx<DateTime> checkOutDate = DateTime.now().obs;
  Rx<DateTime?> checkOutDate = Rx<DateTime?>(null);

  // RxList<String> categories = <String>[].obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;

// Correct initialization of Rx variable
  Rx<int?> productCategoryId = Rx<int?>(-1);

  // Parse the response data and store it in a list of ProductModel objects
  List<ProductModel> productsByCategory = <ProductModel>[].obs;

  bool isDateRange = false;

  var isLoading = false.obs;
  Rx<bool> isCategoryDataLoading = false.obs;
  Rx<bool> isPopularDataLoading = false.obs;
  Rx<bool> isCategoryLoading = false.obs;
  RxString searchQuery = ''.obs;
  Rx<DateTime?> fromDate = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();
    // getAllProductsByCategories(-1);
  }

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
        firstDate: DateTime.now(),
        lastDate: DateTime.now()
            .add(Duration(days: 365)), // Add one year to the current date

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
              // Customize the date picker background color
              datePickerTheme: const DatePickerThemeData(
                backgroundColor: Colors.white,
                shape: BeveledRectangleBorder(
                    borderRadius:
                        BorderRadius.zero), // Disable editing of the date
              ),
            ),
            child: child!,
          );
        },
        keyboardType: TextInputType.datetime,
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
          firstDate: DateTime.now(),
          lastDate: DateTime.now()
              .add(Duration(days: 365)), // Add one year to the current date

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
          keyboardType: TextInputType.datetime);
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

// Function to clear selected dates
  void clearSelectedDates() {
    if (!isDateRange) {
      // Clear selected single date
      selectedDate.value = null;
    } else {
      // Clear selected date range
      checkInDate.value = null;
      checkOutDate.value = null;
    }

    // Clear the text in the TextEditingController
    textEditingController.clear();
  }

  void setSearchQuery(String query) {
    print(query);
    searchQuery.value = query;
  }

  void setFromDate(DateTime? date) {
    fromDate.value = date;
  }

  void viewAllByCategory([int? productCategoryId]) {
    productListController.fetchproductsOfSelectedCategory(productCategoryId);
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

  Future<void> getAllCategories() async {
    int attempt = 0; // Initialize attempt counter

    Future<void> fetchCategories() async {
      isCategoryLoading(true);
      ApiService.get(
        API_GETALLCATEGORIES,
        success: (data) async {
          print("SUCCESS BHAI SUCCESS");
          print(data);
          categories.clear();
          for (var category in data['categories']) {
            print("Inside LOOPAM LOOP");
            print(category);
            // Create a CategoryModel instance and add it to the categories list
            categories.add(CategoryModel(
              productCategoryId: category["productCategoryId"],
              categoryName: category["categoryName"],
            ));
          }
          categories.refresh();

          isCategoryLoading(false);
          print("Value fo isLoading in fetchCategories API Call ");
          print(isLoading);
        },
        failed: (data) async {
          print("FAILED BAKA FAILED");
          isCategoryLoading(false);
          // print("Attempt number : ");
          // print(attempt);
          // if (attempt < 2) {
          //   attempt++;
          //   isLoading(true);
          //   await fetchCategories(); // Retry fetching categories
          // } else {
          //   print("RESTART KAIRU APPLICATION");
          //   // Restart the application after maximum tries
          //   splashController.restartApplication();
          // }
        },
        error: (msg) async {
          print("MY GOD ERRORRRRR");
          print("Error: $msg");
          isCategoryLoading(false);
          // if (attempt < 2) {
          //   attempt++;
          //   await fetchCategories(); // Retry fetching categories
          // } else {
          //   // Restart the application after maximum tries
          //   splashController.restartApplication();
          // }
        },
      );
    }

    await fetchCategories();

    print("naya naya");
    print(categories); // Initial call to fetch categories
  }

  Future<void> getAllLatestProductsByCategories(int? productCategoryId) async {
    int attempt = 0; // Initialize attempt counter

    Future<void> fetchproductsOfSelectedCategory(int? productCategoryId) async {
      isCategoryDataLoading(true);
      Map<String, dynamic> queryParams = {
        if (productCategoryId != null && productCategoryId > 0)
          'productCategoryId': productCategoryId,
      };
      ApiService.get(
        API_GET_LATEST_PRODUCTS,
        success: (data) async {
          // productsByCategory.clear();

          print("SUCCESS BHAI SUCCESS CATEGORY VADU");
          // print(data);

          // Parse the response data and store it in a list of ProductModel objects
          List<ProductModel> fetchedProducts = parseProducts(data);

          // Update productsByCategory list
          productsByCategory.clear();
          productsByCategory.addAll(fetchedProducts);

          isCategoryDataLoading(false);
        },
        failed: (data) async {
          print("FAILED BAKA FAILED CATEGORY VADU");
          print(data);
          isCategoryDataLoading(false);
          if (attempt < 2) {
            attempt++;
            isCategoryDataLoading(true);
            await fetchproductsOfSelectedCategory(productCategoryId);
          } else {
            print("RESTART KAIRU APPLICATION");
            // Restart the application after maximum tries
            splashController.restartApplication();
          }
        },
        error: (msg) async {
          print("Error: $msg");
          isCategoryDataLoading(false);
          if (attempt < 2) {
            attempt++;
            await fetchproductsOfSelectedCategory(productCategoryId);
          } else {
            // Restart the application after maximum tries
            splashController.restartApplication();
          }
        },
        params: queryParams,
      );
    }

    await fetchproductsOfSelectedCategory(productCategoryId!);
  }

  Future<void> fetchPopularProducts() async {
    print("Api call");

    // print(cnt);
    isPopularDataLoading(true);
    ApiService.get(
      API_POPULARPRODUCTS,
      success: (data) async {
        print(data);
        if (data['productsData'] != null) {
          popularProducts.clear();

          data['productsData'].forEach((v) {
            popularProducts.add(ProductModel.fromJson(v));
          });
        }
        popularProducts.refresh();

        isPopularDataLoading(false);
      },
      failed: (data) async {
        isPopularDataLoading(false);
        print('API request failed: $data');
        showGetXBar(data["msg"]);
        Get.to(LandingScreen());
      },
      error: (msg) {
        print(msg);
        print("error ");
        isPopularDataLoading(false);
        showGetXBar(msg);
        Get.to(LandingScreen());
      },
    );

    // isLoading(false);
  }

  List<ProductModel> parseProducts(dynamic data) {
    List<ProductModel> products = [];

    // Parse the response data and create ProductModel objects
    if (data['Status'] == true && data['productsData'] != null) {
      // print("Avi gyu andar");
      for (var productData in data['productsData']) {
        print("Product no data che aa --- inside parseProducts");
        print(productData);
        products.add(ProductModel.fromJson(productData));
      }
    }

    print("Products variable ma add thyu k nahi e jovanu");
    print(products);

    return products;
  }
}
