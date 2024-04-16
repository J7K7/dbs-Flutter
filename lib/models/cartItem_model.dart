class CartItem {
  final int bookingId;
  final String productName;
  late final int quantity;
  final int productId;
  final int slotId; // Optional for slot-wise products
  String? slotFromDateTime;
  String? slotToDateTime; // For slot-wise
  final String checkInDate; // For day-wise
  final String checkOutDate;
  final double price;
  final double grandTotal;
  final String ProductImage;

  CartItem({
    required this.bookingId,
    required this.productName,
    required this.quantity,
    required this.productId,
    required this.slotId,
    required this.slotFromDateTime,
    required this.slotToDateTime,
    required this.checkInDate,
    required this.checkOutDate,
    required this.ProductImage,
    required this.grandTotal,
    required this.price,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      bookingId: json['bookingId'],
      productName: json['productName'],
      quantity: json['quantity'],
      productId: json['productId'],
      slotId: json['slotId'],
      slotFromDateTime: json['slotFromDateTime'],
      slotToDateTime: json['slotToDateTime'],
      checkInDate: json['checkInDate'],
      checkOutDate: json['checkOutDate'],
      ProductImage: json['ProductImage'],
      grandTotal: json['grandTotal'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'productName': productName,
      'quantity': quantity,
      'productId': productId,
      'slotId': slotId,
      'slotFromDateTime': slotFromDateTime,
      'slotToDateTime': slotToDateTime,
      'checkInDate': checkInDate,
      'checkOutDate': checkOutDate,
      'ProductImage': ProductImage,
      'grandTotal': grandTotal,
      'price': price,
    };
  }
}
