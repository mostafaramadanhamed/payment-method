import 'package:checkout_payment_ui/Features/checkout/data/models/payment_intent/card.dart';

import 'link.dart';

class PaymentMethodOptions {
  final CardClass? card;
  final Link? link;

  const PaymentMethodOptions({this.card, this.link});

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) {
    return PaymentMethodOptions(
      card: json['cardClaCardClass'] == null
          ? null
          : CardClass.fromJson(
              json['cardClaCardClass'] as Map<String, dynamic>),
      link: json['link'] == null
          ? null
          : Link.fromJson(json['link'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'cardClaCardClass': card?.toJson(),
        'link': link?.toJson(),
      };
}
