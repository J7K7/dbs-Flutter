// import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/AppTextStyle.dart';
import 'package:dbs_frontend/pages/ViewAllProducts/controller.dart';
import 'package:dbs_frontend/pages/ViewAllProducts/productCard.dart';
import 'package:flutter/material.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:get/get.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:ums_demo/AppCommon/CommonFunctions.dart';
// import 'package:ums_demo/Themes/UiUtils.dart';
// import 'package:ums_demo/pages/SplashScreen/Controller.dart';

class ViewAllProducts extends StatelessWidget {
  ViewAllProducts({Key? key}) : super(key: key);

  final _controller = Get.put(ProductListController());

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    // String name;
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    _controller.callAPIGetProducts();
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              print("Back Button Is pressed");
              Get.back();
            }),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Obx(
        () => _controller.isLoading.value
            ? spinKitWidgetWaveSpinner()
            : Column(
                children: [
                  vSpace(10),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text('All Products',
                              style: AppTextStyles.headingTextStyle),
                        ),
                        IconButton(
                            icon: const Icon(Icons.view_list_rounded),
                            onPressed: () {}),
                        IconButton(
                            icon: const Icon(Icons.grid_view),
                            onPressed: () {}),
                      ],
                    ),
                  ),
                  vSpace(15),
                  Expanded(
                    child: GetBuilder<ProductListController>(
                      builder: (controller) {
                        return ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          separatorBuilder: (c, i) => vSpace(),
                          itemCount: controller.listOfProducts.length,
                          itemBuilder: (context, index) {
                            var item = controller.listOfProducts[index];
                            // print(item.images![0]['imagePath']);
                            return ProductCard(
                              product: item,
                              onPress: () {},
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
