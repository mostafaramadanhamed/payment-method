import 'package:checkout_payment_ui/Features/checkout/data/models/ephemeral_key_mode/ephemeral_key_mode.dart';
import 'package:checkout_payment_ui/Features/checkout/data/models/payment_intent/payment_intent.dart';
import 'package:checkout_payment_ui/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:checkout_payment_ui/core/service/api_service.dart';
import 'package:checkout_payment_ui/core/utils/api_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  final ApiService _apiService = ApiService();
  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    final response = await _apiService.post(
      url: 'https://api.stripe.com/v1/payment_intents',
      body: paymentIntentInputModel.toJson(),
      token: ApiKeys.secretKey,
      contentType: Headers.formUrlEncodedContentType,
    );
    return PaymentIntentModel.fromJson(response.data);
  }

  Future<EphemeralKeyMode> createEphemeralKey(
      {required String customerId}) async {
    final response = await _apiService.post(
      url: 'https://api.stripe.com/v1/ephemeral_keys',
      body: {
        'customer': customerId,
      },
      headers: {
        'Stripe-Version': '2024-12-18.acacia',
        'Authorization': 'Bearer ${ApiKeys.secretKey}',
      },
      token: ApiKeys.secretKey,
      contentType: Headers.formUrlEncodedContentType,
    );
    return EphemeralKeyMode.fromJson(response.data);
  }

  Future initPaymentSheet(
      {required String paymentIntentClientSecret,
      required String ephemeralKey}) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
        customerEphemeralKeySecret: ephemeralKey,
        customerId: 'cus_RUFHTbF3DXVXkG',
        merchantDisplayName: 'Mostafa',
      ),
    );
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    final paymentIntentModel =
        await createPaymentIntent(paymentIntentInputModel);
    final ephemeralKey =
        await createEphemeralKey(customerId: 'cus_RUFHTbF3DXVXkG');

    await initPaymentSheet(
        ephemeralKey: ephemeralKey.secret!,
        paymentIntentClientSecret: paymentIntentModel.clientSecret!);
    await displayPaymentSheet();
  }
}
