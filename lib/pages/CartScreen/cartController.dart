import 'package:dbs_frontend/Themes/AppStrings.dart';
import 'package:dbs_frontend/Utilities/SharedPreferences.dart';
import 'package:dbs_frontend/models/cartItem_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final cartItems = RxList<CartItem>([]);
  final businessCategoryId =
      int.tryParse(SharedPrefs.getString(BUSINESS_CATEGORYID)!) ??
          1; // Default 1

  @override
  void onInit() {
    super.onInit();
    addDummyData(); // Add dummy data on initialization
  }

  void addDummyData() {
    cartItems.add(
      CartItem(
        bookingId: 17355,
        productName: "Movie Ticket (Slot-Wise)",
        quantity: 2,
        productId: 7,
        slotId: 123, // Replace with actual slot ID if applicable
        slotFromDateTime: "2024-04-16 14:00:00",
        slotToDateTime: "2024-04-16 16:00:00",
        checkInDate: "2024-04-29 10:00:00", // Not applicable for slot-wise
        checkOutDate: "2024-04-30 08:00:00", // Not applicable for slot-wise
        ProductImage: "productImages-1709103738403-304830184.jpg",
        grandTotal: 500, // Adjust based on your pricing
        price: 250, // Adjust based on your pricing
      ),
    );
    cartItems.add(
      CartItem(
        bookingId: 17356,
        productName: "Hotel Room (Day-Wise)",
        quantity: 1,
        productId: 8,
        slotId: 522, // Not applicable for day-wise
        slotFromDateTime: "2024-04-16 18:00:00", // Not applicable for day-wise
        slotToDateTime: "2024-04-16 19:00:00", // Not applicable for day-wise
        checkInDate: "2024-04-20 10:00:00",
        checkOutDate: "2024-04-22 09:00:00",
        ProductImage: "productImages-1709103738403-304830184.jpg",
        grandTotal: 2000, // Adjust based on your pricing
        price: 2000, // Adjust based on your pricing
      ),
    );
    cartItems.add(
      CartItem(
        bookingId: 17356,
        productName: "Hotel Room (Day-Wise)",
        quantity: 1,
        productId: 8,
        slotId: 522, // Not applicable for day-wise
        slotFromDateTime: "2024-04-16 18:00:00", // Not applicable for day-wise
        slotToDateTime: "2024-04-16 19:00:00", // Not applicable for day-wise
        checkInDate: "2024-04-20 10:00:00",
        checkOutDate: "2024-04-22 09:00:00",
        ProductImage: "productImages-1709103738403-304830184.jpg",
        grandTotal: 2000, // Adjust based on your pricing
        price: 2000, // Adjust based on your pricing
      ),
    );
    cartItems.add(
      CartItem(
        bookingId: 17356,
        productName: "Hotel Room (Day-Wise)",
        quantity: 1,
        productId: 8,
        slotId: 522, // Not applicable for day-wise
        slotFromDateTime: "2024-04-16 18:00:00", // Not applicable for day-wise
        slotToDateTime: "2024-04-16 19:00:00", // Not applicable for day-wise
        checkInDate: "2024-04-20 10:00:00",
        checkOutDate: "2024-04-22 09:00:00",
        ProductImage: "productImages-1709103738403-304830184.jpg",
        grandTotal: 2000, // Adjust based on your pricing
        price: 2000, // Adjust based on your pricing
      ),
    );
    cartItems.add(
      CartItem(
        bookingId: 17356,
        productName: "Hotel Room (Day-Wise)",
        quantity: 1,
        productId: 8,
        slotId: 522, // Not applicable for day-wise
        slotFromDateTime: "2024-04-16 18:00:00", // Not applicable for day-wise
        slotToDateTime: "2024-04-16 19:00:00", // Not applicable for day-wise
        checkInDate: "2024-04-20 10:00:00",
        checkOutDate: "2024-04-22 09:00:00",
        ProductImage: "productImages-1709103738403-304830184.jpg",
        grandTotal: 2000, // Adjust based on your pricing
        price: 2000, // Adjust based on your pricing
      ),
    );
    cartItems.add(
      CartItem(
        bookingId: 17356,
        productName: "Hotel Room (Day-Wise)",
        quantity: 1,
        productId: 8,
        slotId: 522, // Not applicable for day-wise
        slotFromDateTime: "2024-04-16 18:00:00", // Not applicable for day-wise
        slotToDateTime: "2024-04-16 19:00:00", // Not applicable for day-wise
        checkInDate: "2024-04-20 10:00:00",
        checkOutDate: "2024-04-22 09:00:00",
        ProductImage: "productImages-1709103738403-304830184.jpg",
        grandTotal: 2000, // Adjust based on your pricing
        price: 2000, // Adjust based on your pricing
      ),
    );
    cartItems.add(
      CartItem(
        bookingId: 17356,
        productName: "Hotel Room (Day-Wise)",
        quantity: 1,
        productId: 8,
        slotId: 522, // Not applicable for day-wise
        slotFromDateTime: "2024-04-16 18:00:00", // Not applicable for day-wise
        slotToDateTime: "2024-04-16 19:00:00", // Not applicable for day-wise
        checkInDate: "2024-04-20 10:00:00",
        checkOutDate: "2024-04-22 09:00:00",
        ProductImage: "productImages-1709103738403-304830184.jpg",
        grandTotal: 2000, // Adjust based on your pricing
        price: 2000, // Adjust based on your pricing
      ),
    );
    cartItems.add(
      CartItem(
        bookingId: 17356,
        productName: "Hotel Room (Day-Wise)",
        quantity: 1,
        productId: 8,
        slotId: 522, // Not applicable for day-wise
        slotFromDateTime: "2024-04-16 18:00:00", // Not applicable for day-wise
        slotToDateTime: "2024-04-16 19:00:00", // Not applicable for day-wise
        checkInDate: "2024-04-20 10:00:00",
        checkOutDate: "2024-04-22 09:00:00",
        ProductImage: "productImages-1709103738403-304830184.jpg",
        grandTotal: 2000, // Adjust based on your pricing
        price: 2000, // Adjust based on your pricing
      ),
    );
    cartItems.add(
      CartItem(
        bookingId: 17356,
        productName: "Hotel Room (Day-Wise)",
        quantity: 1,
        productId: 8,
        slotId: 522, // Not applicable for day-wise
        slotFromDateTime: "2024-04-16 18:00:00", // Not applicable for day-wise
        slotToDateTime: "2024-04-16 19:00:00", // Not applicable for day-wise
        checkInDate: "2024-04-20 10:00:00",
        checkOutDate: "2024-04-22 09:00:00",
        ProductImage: "productImages-1709103738403-304830184.jpg",
        grandTotal: 2000, // Adjust based on your pricing
        price: 2000, // Adjust based on your pricing
      ),
    );
    cartItems.add(
      CartItem(
        bookingId: 17356,
        productName: "Hotel Room (Day-Wise)",
        quantity: 1,
        productId: 8,
        slotId: 522, // Not applicable for day-wise
        slotFromDateTime: "2024-04-16 18:00:00", // Not applicable for day-wise
        slotToDateTime: "2024-04-16 19:00:00", // Not applicable for day-wise
        checkInDate: "2024-04-20 10:00:00",
        checkOutDate: "2024-04-22 09:00:00",
        ProductImage: "productImages-1709103738403-304830184.jpg",
        grandTotal: 2000, // Adjust based on your pricing
        price: 2000, // Adjust based on your pricing
      ),
    );
    cartItems.add(
      CartItem(
        bookingId: 17356,
        productName: "Hotel Room (Day-Wise)",
        quantity: 1,
        productId: 8,
        slotId: 522, // Not applicable for day-wise
        slotFromDateTime: "2024-04-16 18:00:00", // Not applicable for day-wise
        slotToDateTime: "2024-04-16 19:00:00", // Not applicable for day-wise
        checkInDate: "2024-04-20 10:00:00",
        checkOutDate: "2024-04-22 09:00:00",
        ProductImage: "productImages-1709103738403-304830184.jpg",
        grandTotal: 2000, // Adjust based on your pricing
        price: 2000, // Adjust based on your pricing
      ),
    );
    cartItems.add(
      CartItem(
        bookingId: 17356,
        productName: "Hotel Room (Day-Wise)",
        quantity: 1,
        productId: 8,
        slotId: 522, // Not applicable for day-wise
        slotFromDateTime: "2024-04-16 18:00:00", // Not applicable for day-wise
        slotToDateTime: "2024-04-16 19:00:00", // Not applicable for day-wise
        checkInDate: "2024-04-20 10:00:00",
        checkOutDate: "2024-04-22 09:00:00",
        ProductImage: "productImages-1709103738403-304830184.jpg",
        grandTotal: 2000, // Adjust based on your pricing
        price: 2000, // Adjust based on your pricing
      ),
    );
    cartItems.add(
      CartItem(
        bookingId: 17356,
        productName: "Hotel Room (Day-Wise)",
        quantity: 1,
        productId: 8,
        slotId: 522, // Not applicable for day-wise
        slotFromDateTime: "2024-04-16 18:00:00", // Not applicable for day-wise
        slotToDateTime: "2024-04-16 19:00:00", // Not applicable for day-wise
        checkInDate: "2024-04-20 10:00:00",
        checkOutDate: "2024-04-22 09:00:00",
        ProductImage: "productImages-1709103738403-304830184.jpg",
        grandTotal: 2000, // Adjust based on your pricing
        price: 2000, // Adjust based on your pricing
      ),
    );
    cartItems.add(
      CartItem(
        bookingId: 17356,
        productName: "Hotel Room (Day-Wise)",
        quantity: 1,
        productId: 8,
        slotId: 522, // Not applicable for day-wise
        slotFromDateTime: "2024-04-16 18:00:00", // Not applicable for day-wise
        slotToDateTime: "2024-04-16 19:00:00", // Not applicable for day-wise
        checkInDate: "2024-04-20 10:00:00",
        checkOutDate: "2024-04-22 09:00:00",
        ProductImage: "productImages-1709103738403-304830184.jpg",
        grandTotal: 2000, // Adjust based on your pricing
        price: 2000, // Adjust based on your pricing
      ),
    );
    cartItems.add(
      CartItem(
        bookingId: 17356,
        productName: "Hotel Room (Day-Wise)",
        quantity: 1,
        productId: 8,
        slotId: 522, // Not applicable for day-wise
        slotFromDateTime: "2024-04-16 18:00:00", // Not applicable for day-wise
        slotToDateTime: "2024-04-16 19:00:00", // Not applicable for day-wise
        checkInDate: "2024-04-20 10:00:00",
        checkOutDate: "2024-04-22 09:00:00",
        ProductImage: "productImages-1709103738403-304830184.jpg",
        grandTotal: 2000, // Adjust based on your pricing
        price: 2000, // Adjust based on your pricing
      ),
    );
    cartItems.add(
      CartItem(
        bookingId: 17356,
        productName: "Hotel Room (Day-Wise)",
        quantity: 1,
        productId: 8,
        slotId: 522, // Not applicable for day-wise
        slotFromDateTime: "2024-04-16 18:00:00", // Not applicable for day-wise
        slotToDateTime: "2024-04-16 19:00:00", // Not applicable for day-wise
        checkInDate: "2024-04-20 10:00:00",
        checkOutDate: "2024-04-22 09:00:00",
        ProductImage: "productImages-1709103738403-304830184.jpg",
        grandTotal: 2000, // Adjust based on your pricing
        price: 2000, // Adjust based on your pricing
      ),
    );
    cartItems.add(
      CartItem(
        bookingId: 17356,
        productName: "Hotel Room (Day-Wise)",
        quantity: 1,
        productId: 8,
        slotId: 522, // Not applicable for day-wise
        slotFromDateTime: "2024-04-16 18:00:00", // Not applicable for day-wise
        slotToDateTime: "2024-04-16 19:00:00", // Not applicable for day-wise
        checkInDate: "2024-04-20 10:00:00",
        checkOutDate: "2024-04-22 09:00:00",
        ProductImage: "productImages-1709103738403-304830184.jpg",
        grandTotal: 2000, // Adjust based on your pricing
        price: 2000, // Adjust based on your pricing
      ),
    );
    update(); // Inform GetX about changes (important for UI updates)
  }

  // Future<void> updateQuantity(int index, int newQuantity) async {
  //   if (newQuantity <= 0) return; // Handle invalid quantities
  //   final item = cartItems[index];
  //   cartItems[index] = item.copyWith(quantity: RxInt(newQuantity)); // Update locally
  //   update(); // Inform GetX about changes

  //   // Implement your API call here (replace with your actual service)
  //   final response = await YourApiService.updateCartItemQuantity(item.bookingId, newQuantity);
  //   if (response.statusCode == 200) {
  //     // Success
  //   } else {
  //     cartItems[index] = item.copyWith(quantity: item.quantity); // Revert to old value
  //     update(); // Inform GetX about changes
  //     Get.snackbar(
  //       "Error",
  //       "Failed to update quantity. ${response.reasonPhrase}",
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   }
  // }

  void removeItemFromCart(CartItem item) {
    cartItems.remove(item);
    update(); // Inform GetX about changes
  }
}
