import 'dart:developer';

import 'package:checkout_payment_ui/Features/checkout/presentation/views/thank_you_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

import '../../../../../core/widgets/custom_button.dart';
import '../../../data/models/payment_intent_input_model.dart';
import '../../../domain/cubit/checkout_cubit.dart';
import '../../../domain/cubit/checkout_state.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        if (state is CheckoutSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const ThankYouView(),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 2),
            ),
          );
        } else if (state is CheckoutFailure) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      builder: (context, state) {
        return CustomButton(
          onTap: () {
            // BlocProvider.of<CheckoutCubit>(context).makePayment(
            //   paymentIntentInputModel: PaymentIntentInputModel(
            //     amount: '100',
            //     currency: 'USD',
            //     customerId: 'cus_RUFHTbF3DXVXkG',
            //   ),
            // );

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => PaypalCheckoutView(
                  sandboxMode: true,
                  clientId: 'Ae1VJzE1pZdJt0n4o5Y8aJ5g6Vf0zJN5lZ2lZJN5aJN5',
                  secretKey: 'Ee1VJzE1pZdJt0n4o5Y8aJ5g6Vf0zJN5lZ2lZJN5aJN5',
                  transactions: const [
                    {
                      "amount": {
                        "total": "100",
                        "currency": "USD",
                        "details": {
                          "subtotal": "100",
                          "shipping": "0",
                          "shipping_discount": 0
                        }
                      },
                      "description": "The payment transaction description.",
                      // "payment_options": {
                      //   "allowed_payment_method":
                      //       "INSTANT_FUNDING_SOURCE"
                      // },
                      "item_list": {
                        "items": [
                          {
                            "name": "Apple",
                            "quantity": 4,
                            "price": "10",
                            "currency": "USD"
                          },
                          {
                            "name": "Pineapple",
                            "quantity": 5,
                            "price": "12",
                            "currency": "USD"
                          }
                        ]
                      }
                    }
                  ],
                  note: 'This is a test payment',
                  onSuccess: (Map result) {
                    log('onSuccess: $result');
                    Navigator.pop(context);
                  },
                  onError: (String error) {
                    log('onError: $error');
                    Navigator.pop(context);
                  },
                  onCancel: (String reason) {
                    log('onCancel: $reason');
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
          text: 'Continue',
          isLoading: state is CheckoutLoading ? true : false,
        );
      },
    );
  }
}
