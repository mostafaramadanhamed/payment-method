class PaymentIntentInputModel {
  final String customerId;
  final String amount;
  final String currency;

  PaymentIntentInputModel({
    required this.customerId,
    required this.amount,
    required this.currency,
  });

  Map<String, dynamic> toJson() => {
        'customer': customerId,
        'amount': amount,
        'currency': currency,
      };
}
