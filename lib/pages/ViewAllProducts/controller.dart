import 'package:dbs_frontend/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListController extends GetxController {
  // var listOfUsers =
  //     List.generate(0, (index) => UserModel(), growable: true).obs;
  final List<Map<String, dynamic>> dummyProducts = [
    {
      "productId": 0,
      "productName": "Superrr Delux",
      "productDescription":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed aliquet eros ac lorem malesuada, sed scelerisque ipsum rutrum. Nulla facilisi. Nullam varius maximus lectus, a feugiat turpis commodo eu.",
      "advanceBookingDuration": 5,
      "active_fromDate": "2024-02-27T18:30:00.000Z",
      "active_toDate": "2024-03-19T18:30:00.000Z",
      "images": [
        {"imageId": 1, "imagePath": "assets/images/room.jpg"},
        {"imageId": 2, "imagePath": "productImages-2.jpg"},
        {"imageId": 3, "imagePath": "productImages-3.jpg"},
        {"imageId": 14, "imagePath": "productImages-14.jpg"}
      ],
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
      "active_toDate": "2024-03-19T18:30:00.000Z",
      "images": [
        {"imageId": 1, "imagePath": "assets/images/room.jpg"},
        {"imageId": 2, "imagePath": "productImages-2.jpg"},
        {"imageId": 3, "imagePath": "productImages-3.jpg"},
        {"imageId": 14, "imagePath": "productImages-14.jpg"}
      ],
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
      "advanceBookingDuration": 5,
      "active_fromDate": "2024-02-27T18:30:00.000Z",
      "active_toDate": "2024-03-24T18:30:00.000Z",
      "images": [
        {"imageId": 5, "imagePath": "assets/images/room1.jpg"},
        {"imageId": 6, "imagePath": "productImages-6.jpg"},
        {"imageId": 7, "imagePath": "productImages-7.jpg"},
        {"imageId": 8, "imagePath": "productImages-8.jpg"},
        {"imageId": 9, "imagePath": "productImages-9.jpg"}
      ],
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
      "advanceBookingDuration": 7,
      "active_fromDate": "2024-02-28T18:30:00.000Z",
      "active_toDate": "2024-03-25T18:30:00.000Z",
      "images": [
        {"imageId": 10, "imagePath": "assets/images/room2.jpg"},
        {"imageId": 11, "imagePath": "productImages-11.jpg"},
        {"imageId": 12, "imagePath": "productImages-12.jpg"}
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
      "active_fromDate": "2024-03-01T18:30:00.000Z",
      "active_toDate": "2024-03-30T18:30:00.000Z",
      "images": [
        {"imageId": 13, "imagePath": "assets/images/roo.jpg"},
        {"imageId": 14, "imagePath": "productImages-14.jpg"},
        {"imageId": 15, "imagePath": "productImages-15.jpg"}
      ],
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
      "productName": "Economy Room for Khalasi",
      "productDescription":
          "Affordable and comfortable rooms for budget travelers.",
      "advanceBookingDuration": 3,
      "active_fromDate": "2024-03-10T18:30:00.000Z",
      "active_toDate": "2024-03-31T18:30:00.000Z",
      "images": [],
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
  var isActive = false.obs;
  // var products = [].obs;
  RxList<ProductModel> products = <ProductModel>[].obs;
  // var loginData = LoginModel().obs;

  @override
  void onInit() {
    super.onInit();
    // loginData(LoginModel.fromJson(SharedPrefs.getCustomObject(LOGINDATA)));
    // if (loginData.value.userType == 'user') {
    //   isActive(true);
    // }
    callAPIGetProducts();
  }

  void callAPIGetProducts() {
    isLoading(true);
    // ApiService.get(
    //   API_UserList,
    //   success: (data) async {
    //     if (data['users'] != null) {
    //       data['users'].forEach((v) {
    //         listOfUsers!.add(UserModel.fromJson(v));
    //       });
    //     }

    //     isLoading(false);
    //   },
    //   failed: (data) {
    //     isLoading(false);
    //     showGetXBar(APP_NAME, data["msg"]);
    //   },
    //   error: (msg) {
    //     isLoading(false);
    //     showGetXBar(APP_NAME, msg["msg"]);
    //   },
    // );
    products.addAll(dummyProducts.map((data) => ProductModel.fromJson(data)));

    isLoading(false);
  }

  // void addNewProduct(Map<String, dynamic> productData) {
  //   // Create a new ProductModel instance from productData and add it to the list
  //   products.add(ProductModel.fromJson(productData));
  // }
}
