import 'package:dartz/dartz.dart';

import '../../../../core/service/error_handling.dart';
import '../models/payment_intent_input_model.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel});
}
