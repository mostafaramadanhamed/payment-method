import 'package:checkout_payment_ui/Features/checkout/presentation/views/thank_you_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
         BlocProvider.of<CheckoutCubit>(context).makePayment(paymentIntentInputModel: 
          PaymentIntentInputModel(
            amount: '100',
            currency: 'USD', customerId: 'cus_RUFHTbF3DXVXkG',
         ),
          );
          },
          
          text: 'Continue',
          isLoading: state is CheckoutLoading? true : false,);
      },
    );
  }
}
