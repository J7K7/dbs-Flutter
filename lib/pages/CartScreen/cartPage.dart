import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  // final List<Map<String, dynamic>> items;

  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var items = [
      {
        "bookingId": 17354,
        "productId": 26,
        "productName": "Great India Cricket Ground Katargam1",
        "quantity": 1,
        "slotId": 2564,
        "slotFromDateTime": "2024-04-15T04:30:00.000Z",
        "slotToDateTime": "2024-04-15T06:30:00.000Z",
        "price": 500,
        "grandTotal": 1200
      },
      {
        "bookingId": 17354,
        "productId": 26,
        "productName": "Great India Cricket Ground Katargam1",
        "quantity": 1,
        "slotId": 2566,
        "slotFromDateTime": "2024-04-15T08:30:00.000Z",
        "slotToDateTime": "2024-04-15T10:30:00.000Z",
        "price": 700,
        "grandTotal": 1200
      }
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            leading: Image.network(
              "productImages-1709101989151-738093623.jpg", // Provide the URL of the product image
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text("item['productName']"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Slot Date & Time: ${item['slotFromDateTime']} - ${item['slotToDateTime']}',
                ),
                Text('Price per Slot: \$${item['price']}'),
                Text('Total Price: \$${item['grandTotal']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
