import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Widgets/custom_animated_bottom_bar.dart';
import 'package:dbs_frontend/pages/HomeScreen/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    var containerHeight = screenHeight * 0.9;

    // Instantiate and bind controllers
    final homeScreenController = Get.put(HomeScreenController());

    return GetBuilder<HomeScreenController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                HomePage(),
                CartPage(), // Corrected to CartPage
                OrdersPage(),
                ProfilePage(),
              ],
            ),
          ),
          bottomNavigationBar: CustomAnimatedBottomBar(
            containerHeight: screenHeight * 0.09,
            backgroundColor: bg100,
            selectedIndex: controller.tabIndex,
            showElevation: true,
            itemCornerRadius: 8,
            curve: Curves.decelerate,
            onItemSelected: controller.changeTabIndex,
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/home.svg',
                  height: containerHeight * 0.045,
                ),
                activeColor: primary100,
                // inactiveColor: _inactiveColor,
              ),
              BottomNavyBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/shopping-cart-(1).svg',
                  height: containerHeight * 0.045,
                ),
                activeColor: primary100,
                // inactiveColor: _inactiveColor,
              ),
              BottomNavyBarItem(
                icon: Image.asset(
                  'assets/icons/shopping-list.png',
                  height: containerHeight * 0.045,
                ),
                activeColor: primary100,
                // inactiveColor: _inactiveColor,
              ),
              BottomNavyBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/user.svg',
                  height: containerHeight * 0.045,
                ),
                activeColor: primary100,
                // inactiveColor: _inactiveColor,
              ),
            ],
          ),
        );
      },
    );
  }
}

class HomeScreenController extends GetxController {
  var tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }
}

class HomePageController extends GetxController {}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Cart Page'),
    ); // Empty container for now
  }
}

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Orders Page'),
    ); // Empty container for now
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Page'),
    ); // Empty container for now
  }
}
