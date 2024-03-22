class PaymentModel {
  double? amount;
  String? foodId;
  String? payType;
  String? paymentId;
  String? time;
  String? transactionId;
  String? userId;
  String? uOrderID;

  PaymentModel({
    required this.amount,
    required this.foodId,
    required this.payType,
    required this.paymentId,
    required this.time,
    required this.transactionId,
    required this.userId,
    required this.uOrderID,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      amount: json['amount'],
      foodId: json['foodId'],
      payType: json['payType'],
      paymentId: json['paymentId'],
      time: json['time'],
      transactionId: json['transactionId'],
      userId: json['userId'],
      uOrderID: json['uOrderID'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['foodId'] = foodId;
    data['payType'] = payType;
    data['paymentId'] = paymentId;
    data['time'] = time;
    data['transactionId'] = transactionId;
    data['userId'] = userId;
    data['uOrderID'] = uOrderID;
    return data;
  }
}
