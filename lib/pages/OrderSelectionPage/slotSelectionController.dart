import 'package:dbs_frontend/models/product_model.dart';
import 'package:dbs_frontend/models/slot_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SlotSelectionController extends GetxController {
  final ProductModel product;

  Rx<DateTime> selectedDate = DateTime.now().obs;
  // RxList<SlotModel> availableSlots = RxList<SlotModel>([]);
  RxList<SlotModel> availableSlots = RxList<SlotModel>([]);
  late DateTime lastDate;
  late DateTime startDate;

  SlotSelectionController({required this.product}) {
    // Calculate the last date based on advance booking duration
    // lastDate =
    //     DateTime.now().add(Duration(days: product.advanceBookingDuration! - 1));
    startDate = DateTime.now().isBefore(product.activeFromDate!)
        ? product.activeFromDate!
        : DateTime.now();
    lastDate = startDate
            .add(Duration(days: product.advanceBookingDuration! - 1))
            .isBefore(product.activeToDate!)
        ? startDate.add(Duration(days: product.advanceBookingDuration! - 1))
        : product.activeToDate!;
    print(lastDate);
    print(startDate);
    print(product.activeFromDate);
    print(product.activeToDate);
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
    print(selectedDate);
    availableSlots[0].slotPrice = '${availableSlots[0].slotPrice}';
    // update();
    // Perform any actions when a date is selected
    // fetchSlots(date);
  }

  final selectedSlot = Rx<SlotModel?>(null); // Track selected slot

  void toggleSlotSelection(SlotModel slot) {
    if (selectedSlot.value == slot) {
      selectedSlot.value = null; // Unselect if already selected
    } else {
      selectedSlot.value = slot; // Select the slot
    }
  }

  bool isSelected(SlotModel slot) => selectedSlot.value == slot;
}
