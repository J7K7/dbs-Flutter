import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/AppTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
// import 'package:get/get.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:ums_demo/AppCommon/CommonFunctions.dart';
// import 'package:ums_demo/Themes/UiUtils.dart';
// import 'package:ums_demo/pages/SplashScreen/Controller.dart';

class ViewAllProducts extends StatelessWidget {
  const ViewAllProducts({Key? key}) : super(key: key);

  // final _controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    // String name;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: const Icon(
          Icons.arrow_back_ios,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          vSpace(10),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Expanded(
                  child: Text('DBS', style: AppTextStyles.headingTextStyle),
                ),
                IconButton(
                    icon: const Icon(Icons.view_list_rounded),
                    onPressed: () {}),
                IconButton(icon: const Icon(Icons.grid_view), onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
