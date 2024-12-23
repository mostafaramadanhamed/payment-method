
import 'tip.dart';

class AmountDetails {
  final Tip? tip;

  const AmountDetails({this.tip});

  factory AmountDetails.fromJson(Map<String, dynamic> json) => AmountDetails(
        tip: json['tip'] == null
            ? null
            : Tip.fromJson(json['tip'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'tip': tip?.toJson(),
      };
}
