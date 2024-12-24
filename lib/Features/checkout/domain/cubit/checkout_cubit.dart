import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/payment_intent_input_model.dart';
import '../use case/checkout_use_case.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutUseCase checkoutUseCase;
  CheckoutCubit(this.checkoutUseCase) : super(CheckoutLoading());

  Future<void> makePayment({required PaymentIntentInputModel paymentIntentInputModel}) async {
    emit(CheckoutLoading());
    final result = await checkoutUseCase.makePayment(paymentIntentInputModel: paymentIntentInputModel);
    result.fold(
      (failure) => emit(CheckoutFailure(message: failure.message)),
      (_) => emit(CheckoutSuccess(message: 'Payment Successful')),
    );
  }

  @override
  void onChange(Change<CheckoutState> change) {
    debugPrint(change.toString());
    super.onChange(change);
  }
}