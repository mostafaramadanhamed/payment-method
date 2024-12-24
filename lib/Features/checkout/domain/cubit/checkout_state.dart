abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {
  final String message;

  CheckoutSuccess({required this.message});
}

class CheckoutFailure extends CheckoutState {
  final String message;

  CheckoutFailure({required this.message});
}