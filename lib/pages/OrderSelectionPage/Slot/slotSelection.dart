import 'package:dbs_frontend/Themes/AppColors.dart';
import 'package:dbs_frontend/Themes/AppTextStyle.dart';
import 'package:dbs_frontend/Themes/Buttons.dart';
import 'package:dbs_frontend/Themes/UiUtils.dart';
import 'package:dbs_frontend/models/product_model.dart';
import 'package:dbs_frontend/models/slot_model.dart';
import 'package:dbs_frontend/pages/OrderSelectionPage/Slot/slotSelectionController.dart';
import 'package:dbs_frontend/pages/ProductDetails/screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:intl/intl.dart';

class SlotSelectionPage extends StatelessWidget {
  final ProductModel product;
  late SlotSelectionController slotSelectionController;
  SlotSelectionPage({super.key, required this.product}) {
    slotSelectionController =
        Get.put(SlotSelectionController(product: product));
  }
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    print("Inside the slot sleection:");
    print(product.productId);

    // slotSelectionController.fetchSlots()
    // List<SlotModel> dummySlots = [
    //   SlotModel(
    //     slotDate: DateTime.now().toString(),
    //     slotFromDateTime: '08:30:00',
    //     slotToDateTime: '09:00:00',
    //     slotPrice: '175',
    //     slotId: 2621,
    //   ),
    //   SlotModel(
    //     slotDate: DateTime.now().toString(),
    //     slotFromDateTime: '09:00:00',
    //     slotToDateTime: '09:30:00',
    //     slotPrice: '2020',
    //     slotId: 2622,
    //   ),
    //   SlotModel(
    //     slotDate: DateTime.now().toString(),
    //     slotFromDateTime: '09:00:00',
    //     slotToDateTime: '10:00:00',
    //     slotPrice: '2200',
    //     slotId: 2622,
    //   ),
    //   SlotModel(
    //     slotDate: DateTime.now().toString(),
    //     slotFromDateTime: '09:00:00',
    //     slotToDateTime: '10:45:00',
    //     slotPrice: '2000',
    //     slotId: 2622,
    //   ),
    //   SlotModel(
    //     slotDate: DateTime.now().toString(),
    //     slotFromDateTime: '12:00:00',
    //     slotToDateTime: '13:30:00',
    //     slotPrice: '500',
    //     slotId: 2622,
    //   ),
    //   // Add more dummy slots as needed
    // ];
    // slotSelectionController.availableSlots.assignAll(dummySlots);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Select Date',
          style: TextStyle(fontSize: screenHeight * 0.02, color: primary100),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // vSpace(),
              Obx(
                () => EasyInfiniteDateTimeLine(
                  selectionMode: const SelectionMode.autoCenter(),
                  firstDate: slotSelectionController.startDate,
                  lastDate: slotSelectionController.lastDate,
                  focusDate: slotSelectionController.selectedDate.value,
                  onDateChange: (date) async {
                    // Call the selectDate function asynchronously
                    await slotSelectionController.selectDate(date);
                  },
                  activeColor: primary100,
                  showTimelineHeader: true,
                  headerBuilder: (context, date) => Text(
                    '${DateFormat('EEEE, d MMMM').format(date)}',
                    style: AppTextStyles.mediumHeadingTextStyle
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // vSpace(),

              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'SELECT SLOT', // You can customize this text as needed
                  style: AppTextStyles
                      .subheadingTextStyle, // Assuming you have a text style
                ),
              ),

              // vSpace(),
              Expanded(
                child: Obx(
                  () => slotSelectionController.isSlotLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : slotSelectionController.availableSlots.isEmpty
                          ? Center(
                              child: Text(
                              'No slots available for this date',
                              style: TextStyle(
                                fontSize:
                                    screenHeight * 0.02 * (screenWidth / 575),
                              ),
                            ))
                          : SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Obx(
                                () => Wrap(
                                  spacing: 0,
                                  runSpacing: 8.0,
                                  children: List.generate(
                                    slotSelectionController
                                        .availableSlots.length,
                                    (index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: AnimatedContainer(
                                        // padding: EdgeInsets.all(2),
                                        duration: const Duration(
                                            milliseconds:
                                                200), // Smooth transitions
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 8),
                                        decoration: BoxDecoration(
                                          color: slotSelectionController
                                                  .isSelected(
                                                      slotSelectionController
                                                              .availableSlots[
                                                          index])
                                              ? primary100
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              15), // Rounded corners
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () => slotSelectionController
                                                .toggleSlotSelection(
                                                    slotSelectionController
                                                        .availableSlots[index]),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 8),
                                              child: screenWidth < 340
                                                  ? SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        // mainAxisSize: screenWidth <= 550
                                                        //     ? MainAxisSize.max
                                                        //     : MainAxisSize.min,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .calendar_today_outlined,
                                                                    color: slotSelectionController.isSelected(slotSelectionController.availableSlots[
                                                                            index])
                                                                        ? Colors
                                                                            .white
                                                                        : primary100,
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 4),
                                                                  Text(
                                                                    'Time: ',
                                                                    style: slotSelectionController.isSelected(slotSelectionController.availableSlots[
                                                                            index])
                                                                        ? AppTextStyles.snackBarTextStyle.copyWith(
                                                                            fontWeight: FontWeight
                                                                                .bold)
                                                                        : AppTextStyles
                                                                            .mediumHeadingTextStyle
                                                                            .copyWith(fontWeight: FontWeight.bold),
                                                                  ),
                                                                  Text(
                                                                    '${slotSelectionController.availableSlots[index].slotFromDateTime?.substring(11)} - ${slotSelectionController.availableSlots[index].slotToDateTime?.substring(11)}',
                                                                    style: slotSelectionController.isSelected(slotSelectionController.availableSlots[
                                                                            index])
                                                                        ? AppTextStyles
                                                                            .snackBarTextStyle
                                                                        : AppTextStyles
                                                                            .mediumHeadingTextStyle,
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .attach_money,
                                                                    color: slotSelectionController.isSelected(slotSelectionController.availableSlots[
                                                                            index])
                                                                        ? Colors
                                                                            .white
                                                                        : primary100,
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 4),
                                                                  Text(
                                                                    'Price: ',
                                                                    style: slotSelectionController.isSelected(slotSelectionController.availableSlots[
                                                                            index])
                                                                        ? AppTextStyles.snackBarTextStyle.copyWith(
                                                                            fontWeight: FontWeight
                                                                                .bold)
                                                                        : AppTextStyles
                                                                            .mediumHeadingTextStyle
                                                                            .copyWith(fontWeight: FontWeight.bold),
                                                                  ),
                                                                  Text(
                                                                    '\u{20B9}${slotSelectionController.availableSlots[index].slotPrice}',
                                                                    style: slotSelectionController.isSelected(slotSelectionController.availableSlots[
                                                                            index])
                                                                        ? AppTextStyles
                                                                            .snackBarTextStyle
                                                                        : AppTextStyles
                                                                            .mediumHeadingTextStyle,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),

                                                          Icon(
                                                            Icons.check_circle,
                                                            color: slotSelectionController
                                                                    .isSelected(
                                                                        slotSelectionController.availableSlots[
                                                                            index])
                                                                ? primary100
                                                                : Colors
                                                                    .transparent, // Make icon invisible when not selected
                                                          ), // Visual checkmark
                                                        ],
                                                      ),
                                                    )
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      mainAxisSize:
                                                          screenWidth <= 650
                                                              ? MainAxisSize.max
                                                              : MainAxisSize
                                                                  .min,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .calendar_today_outlined,
                                                                  color: slotSelectionController.isSelected(
                                                                          slotSelectionController.availableSlots[
                                                                              index])
                                                                      ? Colors
                                                                          .white
                                                                      : primary100,
                                                                ),
                                                                const SizedBox(
                                                                    width: 4),
                                                                Text(
                                                                  'Time: ',
                                                                  style: slotSelectionController.isSelected(
                                                                          slotSelectionController.availableSlots[
                                                                              index])
                                                                      ? AppTextStyles
                                                                          .snackBarTextStyle
                                                                          .copyWith(
                                                                              fontWeight: FontWeight
                                                                                  .bold)
                                                                      : AppTextStyles
                                                                          .mediumHeadingTextStyle
                                                                          .copyWith(
                                                                              fontWeight: FontWeight.bold),
                                                                ),
                                                                Text(
                                                                  '${slotSelectionController.availableSlots[index].slotFromDateTime?.substring(11)} - ${slotSelectionController.availableSlots[index].slotToDateTime?.substring(11)}',
                                                                  style: slotSelectionController.isSelected(
                                                                          slotSelectionController.availableSlots[
                                                                              index])
                                                                      ? AppTextStyles
                                                                          .snackBarTextStyle
                                                                      : AppTextStyles
                                                                          .mediumHeadingTextStyle,
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .attach_money,
                                                                  color: slotSelectionController.isSelected(
                                                                          slotSelectionController.availableSlots[
                                                                              index])
                                                                      ? Colors
                                                                          .white
                                                                      : primary100,
                                                                ),
                                                                const SizedBox(
                                                                    width: 4),
                                                                Text(
                                                                  'Price: ',
                                                                  style: slotSelectionController.isSelected(
                                                                          slotSelectionController.availableSlots[
                                                                              index])
                                                                      ? AppTextStyles
                                                                          .snackBarTextStyle
                                                                          .copyWith(
                                                                              fontWeight: FontWeight
                                                                                  .bold)
                                                                      : AppTextStyles
                                                                          .mediumHeadingTextStyle
                                                                          .copyWith(
                                                                              fontWeight: FontWeight.bold),
                                                                ),
                                                                Text(
                                                                  '\u{20B9}${slotSelectionController.availableSlots[index].slotPrice}',
                                                                  style: slotSelectionController.isSelected(
                                                                          slotSelectionController.availableSlots[
                                                                              index])
                                                                      ? AppTextStyles
                                                                          .snackBarTextStyle
                                                                      : AppTextStyles
                                                                          .mediumHeadingTextStyle,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),

                                                        Icon(
                                                          Icons.check_circle,
                                                          color: slotSelectionController
                                                                  .isSelected(
                                                                      slotSelectionController
                                                                              .availableSlots[
                                                                          index])
                                                              ? primary100
                                                              : Colors
                                                                  .transparent, // Make icon invisible when not selected
                                                        ), // Visual checkmark
                                                      ],
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                ),
              ),

              BottomAppBar(
                elevation: 0,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Flexible(
                          // Wraps price text in 1/3rd space
                          flex: 1,
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Total Price',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: text200,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n${slotSelectionController.selectedSlot.value?.slotPrice != null ? '\u{20B9} ${slotSelectionController.selectedSlot.value?.slotPrice}' : '--'}',
                                    style: AppTextStyles.subheadingTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        // Wraps button in 2/3rd space
                        flex: 2,
                        child: Obx(
                          () => mainButton(
                            "Book Now",
                            isEnabled: !slotSelectionController
                                    .isAddToCartRequestLoading.value &&
                                slotSelectionController.selectedSlot.value !=
                                    null,
                            // ignore: dead_code
                            onPress: () async {
                              // return showErrorDialog("Me Error Hu", () {
                              //   print("Proceeesss");
                              //   Get.back();
                              // }, () {
                              //   Get.back();
                              // });
                              if (slotSelectionController.selectedSlot.value ==
                                  null) {
                                showGetXBar("Please select a slot first");
                                return;
                              }
                              await slotSelectionController
                                  .handleBooking(context);
                              print(slotSelectionController.selectedSlot.value);
                              print(product.productId);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
