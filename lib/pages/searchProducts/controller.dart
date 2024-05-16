import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:dbs_frontend/appCommon/ApiService.dart';
import 'package:dbs_frontend/models/product_model.dart';
import 'package:dbs_frontend/pages/BottomNavigationBar/screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListController extends GetxController {
  var listOfProducts =
      List.generate(0, (index) => ProductModel(), growable: true).obs;

  final List<Map<String, dynamic>> dummyProducts = [
    {
      "productId": 0,
      "productName": "Superrr Delux",
      "productDescription":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed aliquet eros ac lorem malesuada, sed scelerisque ipsum rutrum. Nulla facilisi. Nullam varius maximus lectus, a feugiat turpis commodo eu.",
      "advanceBookingDuration": 15,
      "active_fromDate": "2024-02-27T18:30:00.000Z",
      "active_toDate": "2024-03-19T18:30:00.000Z",
      "images": [],
      "features": [
        {
          "featureName": "Mast Full speed 5g+ Wifi",
          "iconData": Icons.wifi,
          "featureDescription":
              "Enjoy high-speed internet with 1GB/s during your booking."
        },
        {
          "featureName": "Swimming Pool",
          "iconData": Icons.pool,
          "featureDescription": "Relax by the poolside and take a swim."
        },
        {
          "featureName": "Gym Access",
          "iconData": Icons.fitness_center,
          "featureDescription": "Access to our state-of-the-art gym facilities."
        },
        {
          "featureName": "Complimentary Breakfast",
          "iconData": Icons.free_breakfast,
          "featureDescription":
              "Enjoy a delicious complimentary breakfast every morning."
        },
        {
          "featureName": "Room Service",
          // No icon provided for Room Service
          "featureDescription":
              "Convenient room service available for your needs."
        }
      ],
      "slots": []
    },
    {
      "productId": 1,
      "productName": "Super Delux",
      "productDescription":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed aliquet eros ac lorem malesuada, sed scelerisque ipsum rutrum. Nulla facilisi. Nullam varius maximus lectus, a feugiat turpis commodo eu.",
      "advanceBookingDuration": 5,
      "active_fromDate": "2024-02-27T18:30:00.000Z",
      "active_toDate": "2024-05-19T18:30:00.000Z",
      "images": [],
      "features": [
        {
          "featureId": 1,
          "featureName": "updated Feature",
          "featureDescription": "updated new description"
        },
        {
          "featureId": 2,
          "featureName": "Mast Full speed 5g+ Wifi",
          "featureDescription":
              "Enjoy high-speed internet with 1GB/s during your booking."
        },
        {
          "featureId": 7,
          "featureName": "Latest Ac19",
          "featureDescription": "We have the world's best AC, which is 0.1 ton."
        },
        {
          "featureId": 9,
          "featureName": "Ac21",
          "featureDescription": "We have the world's best AC, which is 0.1 ton."
        },
        {
          "featureId": 10,
          "featureName": "Mast Full speed 5g+ Wifi",
          "featureDescription":
              "Enjoy high-speed internet with 1000GB/s during your booking."
        }
      ],
      "slots": []
    },
    {
      "productId": 2,
      "productName": "Delux Room",
      "productDescription":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed aliquet eros ac lorem malesuada, sed scelerisque ipsum rutrum. Nulla facilisi. Nullam varius maximus lectus, a feugiat turpis commodo eu.",
      "advanceBookingDuration": 12,
      "active_fromDate": "2024-02-27",
      "active_toDate": "2024-06-24",
      "images": [],
      "features": [
        {
          "featureId": 3,
          "featureName": "Latest Ac19",
          "featureDescription": "We have the world's best AC, which is 0.1 ton."
        },
        {
          "featureId": 4,
          "featureName": "Mast Full speed 5g+ Wifi",
          "featureDescription":
              "Enjoy high-speed internet with 1GB/s during your booking."
        }
      ],
      "slots": []
    },
    {
      "productId": 3,
      "productName": "Standard Room",
      "productDescription":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed aliquet eros ac lorem malesuada, sed scelerisque ipsum rutrum. Nulla facilisi. Nullam varius maximus lectus, a feugiat turpis commodo eu.",
      "advanceBookingDuration": 1,
      "active_fromDate": "2024-02-28",
      "active_toDate": "2024-05-25",
      "images": [
        {"imageId": 1, "imagePath": "productImages-1709283914240-130614072.png"}
      ],
      "features": [
        {
          "featureId": 5,
          "featureName": "Complimentary Breakfast",
          "featureDescription": "Enjoy a delicious breakfast every morning."
        },
        {
          "featureId": 6,
          "featureName": "Free WiFi",
          "featureDescription": "Stay connected with high-speed WiFi."
        }
      ],
      "slots": []
    },
    {
      "productId": 4,
      "productName": "Suite Room",
      "productDescription":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed aliquet eros ac lorem malesuada, sed scelerisque ipsum rutrum. Nulla facilisi. Nullam varius maximus lectus, a feugiat turpis commodo eu.",
      "advanceBookingDuration": 10,
      "active_fromDate": "2024-03-10",
      "active_toDate": "2024-06-10",
      "images": [],
      "features": [
        {
          "featureId": 7,
          "featureName": "Room Service",
          "featureDescription": "Enjoy convenient room service."
        },
        {
          "featureId": 8,
          "featureName": "Swimming Pool Access",
          "featureDescription": "Relax by the poolside and take a swim."
        }
      ],
      "slots": []
    },
    {
      "productId": 5,
      "productName": "Economy Room ",
      "productDescription":
          "Affordable and comfortable rooms for budget travelers.",
      "advanceBookingDuration": 3,
      "active_fromDate": "2024-05-10",
      "active_toDate": "2024-06-30",
      "images": [
        {"imageId": 2, "imagePath": "productImages-1709284815726-587222272.png"}
      ],
      "features": [
        {
          "featureName": "Basic Amenities",
          "iconData": Icons.check,
          "featureDescription":
              "Includes essential amenities for a comfortable stay."
        },
        {
          "featureName": "City View",
          "iconData": Icons.location_city,
          "featureDescription": "Enjoy stunning views of the city skyline."
        },
        {
          "featureName": "24/7 Reception",
          "iconData": Icons.access_time,
          "featureDescription":
              "Reception desk available round-the-clock for assistance."
        },
        {
          "featureName": "Private Bathroom",
          "iconData": Icons.bathtub,
          "featureDescription": "Each room comes with a private bathroom."
        }
      ],
      "slots": []
    },
  ];
  var isLoading = false.obs;

  // var isActive = false.obs;
  // var cnt = 0.obs;
  // var products = [].obs;
  // RxList<ProductModel> products = <ProductModel>[].obs;
  // var loginData = LoginModel().obs;

  // @override
  void onInit() {
    super.onInit();
    // print(cnt);
    // loginData(LoginModel.fromJson(SharedPrefs.getCustomObject(LOGINDATA)));
    // if (loginData.value.userType == 'user') {
    //   isActive(true);
    // }
    // cnt += 1;
    callAPISearchProducts();
  }

  void callAPISearchProducts({
    String? q,
    String? slotDate,
    String? checkInDate,
    String? checkOutDate,
  }) {
    print("Api call");
    Map<String, dynamic> queryParams = {
      if (q != null && q.isNotEmpty) 'q': q,
      if (slotDate != null && slotDate.isNotEmpty) 'slotDate': slotDate,
      if (checkInDate != null && checkInDate.isNotEmpty)
        'checkInDate': checkInDate,
      if (checkOutDate != null && checkOutDate.isNotEmpty)
        'checkOutDate': checkOutDate,
    };
    // print(cnt);
    isLoading(true);
    ApiService.get(
      API_SEARCHPRODUCTS,
      success: (data) async {
        print(data);
        if (data['productsData'] != null) {
          listOfProducts.clear();

          data['productsData'].forEach((v) {
            listOfProducts.add(ProductModel.fromJson(v));
          });
        }
        isLoading(false);
      },
      failed: (data) async {
        isLoading(false);
        print('API request failed: $data');
        showGetXBar(data["msg"]);
        // Get.to(HomeScreen());
      },
      params: queryParams,
      error: (msg) {
        print(msg);
        print("error ");
        isLoading(false);
        showGetXBar(msg);
        // Get.to(HomeScreen());
      },
    );
    // listOfProducts
    //     .addAll(dummyProducts.map((data) => ProductModel.fromJson(data)));
    // isLoading(false);
    // return ;
  }

  Future<void> fetchproductsOfSelectedCategory(int? productCategoryId) async {
    isLoading(true);
    Map<String, dynamic> queryParams = {
      if (productCategoryId != null && productCategoryId > 0)
        'productCategoryId': productCategoryId,
    };
    ApiService.get(
      API_GET_ALL_PRODUCTS,
      success: (data) async {
        print(data);
        if (data['productsData'] != null) {
          listOfProducts.clear();

          data['productsData'].forEach((v) {
            listOfProducts.add(ProductModel.fromJson(v));
          });
        }
        isLoading(false);
      },
      failed: (data) async {
        print("FAILED BAKA FAILED CATEGORY VADU");
        print(data);
        isLoading(false);
        print('API request failed: $data');
        showGetXBar(data["msg"]);
        Get.to(HomeScreen());
      },
      error: (msg) async {
        print("Error: $msg");
        isLoading(false);
        print('API request failed: $msg');
        showGetXBar(msg);
        Get.to(HomeScreen());
      },
      params: queryParams,
    );
  }
  // void addNewProduct(Map<String, dynamic> productData) {
  //   // Create a new ProductModel instance from productData and add it to the list
  //   products.add(ProductModel.fromJson(productData));
  // }
}
