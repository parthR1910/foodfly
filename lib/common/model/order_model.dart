class OrderModel {
  final String id;
  final String foodId;
  final String status;
  final bool paidOrNot;
  final bool isDelivered;
  final int qty;
  final String userId;

  OrderModel({
    required this.id,
    required this.foodId,
    required this.status,
    required this.isDelivered,
    required this.paidOrNot,
    required this.qty,
    required this.userId,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['foodId'],
      foodId: json['foodId'],
      isDelivered: json['isDelivered'],
      status:json['isDelivered']==true?'Deliverd':'Pending',
      paidOrNot: json['paidOrNot'],
      qty: json['quantity'],
      userId: json['userId'],
    );
  }
}


// class OrderModel {
//   final int orderId;
//   final String paymentId;
//   final String userAddress;
//   final String orderStatus;
//   final String paymentAmount;
//   final int userId;
//   final String paymentType;
//   final DateTime orderDateTime;
//   final DateTime? returnDate;
//   final String cancelOrder;
//   final DateTime? deliverDate;
//   final String userLocation;
//   final String orderSource;
//   final String cancelReason;
//   final String deliveryPersonId;
//   final String deliveryPersonContact;
//   final String pincode;
//   final List<OrderItem> items;
//
//   OrderModel({
//     required this.orderId,
//     required this.paymentId,
//     required this.userAddress,
//     required this.orderStatus,
//     required this.paymentAmount,
//     required this.userId,
//     required this.paymentType,
//     required this.orderDateTime,
//     required this.returnDate,
//     required this.cancelOrder,
//     required this.deliverDate,
//     required this.userLocation,
//     required this.orderSource,
//     required this.cancelReason,
//     required this.deliveryPersonId,
//     required this.deliveryPersonContact,
//     required this.pincode,
//     required this.items,
//   });
//
//   factory OrderModel.fromJson(Map<String, dynamic> json) {
//     return OrderModel(
//       orderId: json['order_id'] ?? 0,
//       paymentId: json['payment_id'] ?? '',
//       userAddress: json['user_address'] ?? '',
//       orderStatus: json['order_status'] ?? '',
//       paymentAmount: json['payment_ammount'] ?? '',
//       userId: json['user_id'] ?? 0,
//       paymentType: json['payment_type'] ?? '',
//       orderDateTime:DateTime.parse(json['order_date_time']),
//       returnDate: json['return_date']==null?null:DateTime.parse(json['return_date']),
//       cancelOrder: json['cancel_order'] ?? '',
//       deliverDate: json['delever_date']==null?null:DateTime.parse(json['delever_date']),
//       userLocation: json['user_location'] ?? '',
//       orderSource: json['order_source'] ?? '',
//       cancelReason: json['cancel_reason'] ?? '',
//       deliveryPersonId: json['delivery_person_id'] ?? '',
//       deliveryPersonContact: json['delivery_person_contact'] ?? '',
//       pincode: json['pincode'] ?? '',
//       items: List<OrderItem>.from(json['items'].map((item) => OrderItem.fromJson(item))),
//     );
//   }
// }
//
// class OrderItem {
//   final bool isFromOffer;
//   final String storeLocation;
//   final int productId;
//   final String productThumbImages;
//   final int brandId;
//   final String productAmount;
//   final String quantity;
//
//   OrderItem({
//     required this.isFromOffer,
//     required this.storeLocation,
//     required this.productId,
//     required this.productThumbImages,
//     required this.brandId,
//     required this.productAmount,
//     required this.quantity,
//   });
//
//   factory OrderItem.fromJson(Map<String, dynamic> json) {
//     return OrderItem(
//       isFromOffer: json['isFromOffer'] ?? false,
//       storeLocation: json['store_location'] ?? '',
//       productId: json['product_id'] ?? 0,
//       productThumbImages: json['product_thumb_images'] ?? '',
//       brandId: json['brand_id'] ?? 0,
//       productAmount: json['product_amount'] ?? '',
//       quantity: json['quantity'] ?? '',
//     );
//   }
// }
