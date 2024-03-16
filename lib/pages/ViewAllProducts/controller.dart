import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:dbs_frontend/appCommon/ApiService.dart';
import 'package:dbs_frontend/models/product_model.dart';
import 'package:dbs_frontend/pages/HomeScreen/screen.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListController extends GetxController {
  var listOfProducts =
      List.generate(0, (index) => ProductModel(), growable: true).obs;

  var isLoading = false.obs;

  var isActive = false.obs;
  var cnt = 0.obs;
  // var products = [].obs;
  // RxList<ProductModel> products = <ProductModel>[].obs;
  // var loginData = LoginModel().obs;

  @override
  void onInit() {
    super.onInit();
    print(cnt);
    // loginData(LoginModel.fromJson(SharedPrefs.getCustomObject(LOGINDATA)));
    // if (loginData.value.userType == 'user') {
    //   isActive(true);
    // }
    cnt += 1;
    callAPIGetProducts();
  }

  void callAPIGetProducts() {
    print("Api call");
    print(cnt);
    isLoading(true);
    ApiService.get(
      API_GETPRODUCTLIST,
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
        Get.to(HomeScreen());
      },
      error: (msg) {
        print(msg);
        print("error ");
        isLoading(false);
        showGetXBar(msg);
        Get.to(HomeScreen());
      },
    );
    // products.addAll(dummyProducts.map((data) => ProductModel.fromJson(data)));

    // isLoading(false);
  }

  // void addNewProduct(Map<String, dynamic> productData) {
  //   // Create a new ProductModel instance from productData and add it to the list
  //   products.add(ProductModel.fromJson(productData));
  // }
}
