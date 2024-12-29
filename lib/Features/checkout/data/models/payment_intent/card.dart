class CardClass {
  final dynamic installments;
  final dynamic mandateOptions;
  final dynamic network;
  final String? requestThreeDSecure;

  const CardClass({
    this.installments,
    this.mandateOptions,
    this.network,
    this.requestThreeDSecure,
  });

  factory CardClass.fromJson(Map<String, dynamic> json) => CardClass(
        installments: json['installments'] as dynamic,
        mandateOptions: json['mandate_options'] as dynamic,
        network: json['network'] as dynamic,
        requestThreeDSecure: json['request_three_d_secure'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'installments': installments,
        'mandate_options': mandateOptions,
        'network': network,
        'request_three_d_secure': requestThreeDSecure,
      };
}
