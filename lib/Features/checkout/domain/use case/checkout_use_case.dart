import 'package:dartz/dartz.dart';

import '../../../../core/service/error_handling.dart';
import '../../data/models/payment_intent_input_model.dart';
import '../../data/repos/checkout_repo.dart';

class CheckoutUseCase {
  final CheckoutRepo repository;

  CheckoutUseCase(this.repository);

  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    return await repository.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);
  }
}
