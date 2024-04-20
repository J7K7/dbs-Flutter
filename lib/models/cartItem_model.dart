class CartItem {
  final int? bookingId;
  final String? productName;
  late final int? quantity;
  final int? productId;
  final int? slotId; // Optional for slot-wise products
  String? slotFromDateTime;
  String? slotToDateTime; // For slot-wise
  final String? checkInDate; // For day-wise
  final String? checkOutDate;
  final double? price;
  final double? grandTotal;
  final String? productImage;
  int productAvailable;

  CartItem({
    this.bookingId,
    this.productName,
    this.quantity,
    this.productId,
    this.slotId,
    this.slotFromDateTime,
    this.slotToDateTime,
    this.checkInDate,
    this.checkOutDate,
    this.productImage,
    this.grandTotal,
    this.price,
    this.productAvailable = 1,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    var grandTotalValue = json['grandTotal'];
    var grandTotal;

    if (grandTotalValue is int) {
      grandTotal = grandTotalValue.toDouble();
    } else if (grandTotalValue is double) {
      grandTotal = grandTotalValue;
    } else {
      // Handle other cases, such as null or unexpected data types
      grandTotal = 0.0; // Default value or appropriate handling
    }
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
      productImage: json['productImage'],
      grandTotal: json['grandTotal']!.toDouble(),
      price: json['price']!.toDouble(),
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
      'ProductImage': productImage,
      'grandTotal': grandTotal,
      'price': price,
    };
  }

  CartItem updateQuantity(int newQuantity) {
    return CartItem(
      bookingId: this.bookingId,
      productId: this.productId,
      quantity: newQuantity,
      productName: this.productName,
      productImage: this.productImage,
      slotFromDateTime: this.slotFromDateTime,
      slotToDateTime: this.slotToDateTime,
      checkInDate: this.checkInDate,
      checkOutDate: this.checkOutDate,
      slotId: this.slotId,
      grandTotal: this.grandTotal,
      price: this.price,
      productAvailable: this.productAvailable,
    );
  }

  CartItem updateProductAvailability(int newAvailability) {
    return CartItem(
      bookingId: this.bookingId,
      productId: this.productId,
      quantity: this.quantity,
      productName: this.productName,
      productImage: this.productImage,
      slotFromDateTime: this.slotFromDateTime,
      slotToDateTime: this.slotToDateTime,
      checkInDate: this.checkInDate,
      checkOutDate: this.checkOutDate,
      slotId: this.slotId,
      grandTotal: this.grandTotal,
      price: this.price,
      productAvailable: newAvailability,
    );
  }
}
