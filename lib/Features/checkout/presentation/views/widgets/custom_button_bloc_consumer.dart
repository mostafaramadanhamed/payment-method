import 'dart:developer';

import 'package:checkout_payment_ui/Features/checkout/data/models/amount_model/amount_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/models/amount_model/details.dart';
import 'package:checkout_payment_ui/Features/checkout/data/models/items_list_model/item.dart';
import 'package:checkout_payment_ui/Features/checkout/data/models/items_list_model/items_list_model.dart';
import 'package:checkout_payment_ui/Features/checkout/presentation/views/thank_you_view.dart';
import 'package:checkout_payment_ui/core/utils/api_keys.dart';
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
         final transactions = setTransactions();
            AmountModel amountModel = transactions.amount;
            ItemsListModel itemsListModel = transactions.itemList;
         makePaypal(context, amountModel, itemsListModel);
          },
          text: 'Continue',
          isLoading: state is CheckoutLoading ? true : false,
        );
      },
    );
  }

  void makePaypal(BuildContext context, AmountModel amountModel, ItemsListModel itemsListModel) {
        Navigator.of(context).pushReplacement(
         MaterialPageRoute(
           builder: (context) => PaypalCheckoutView(
             sandboxMode: true,
             clientId: ApiKeys.clientId,
             secretKey: ApiKeys.secretKeyPaypal,
             transactions:  [
               {
                 "amount": amountModel.toJson(),
                 "description": "The payment transaction description.",
                 // "payment_options": {
                 //   "allowed_payment_method":
                 //       "INSTANT_FUNDING_SOURCE"
                 // },
                 "item_list": itemsListModel.toJson(),
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
          
  }

({AmountModel amount, ItemsListModel itemList}) setTransactions() {
             AmountModel amountModel = AmountModel(
              total: '100',
              currency: 'USD',
              details: Details(
                subtotal: '100',
                shipping: '0',
                shippingDiscount: 0,
              )
            );

            ItemsListModel itemsListModel = ItemsListModel(
              items: [
                Item(
                  name: 'Item 1',
                  quantity: 1,
                  price: '100',
                  currency: 'USD',
                )
              ],
            );
    return    (amount:amountModel, itemList: itemsListModel);
  }
}
