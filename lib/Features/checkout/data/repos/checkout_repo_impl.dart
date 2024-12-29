import 'package:dartz/dartz.dart';
import '../../../../core/service/error_handling.dart';
import '../../../../core/service/stripe_service.dart';
import '../models/payment_intent_input_model.dart';
import 'checkout_repo.dart';

class CheckoutRepoImpl implements CheckoutRepo {
  final StripeService _stripeService = StripeService();
  @override
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      await _stripeService.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
      return right(null);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
