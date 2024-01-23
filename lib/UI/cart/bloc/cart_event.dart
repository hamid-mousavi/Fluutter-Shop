part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class DeleteFromCartBtn extends CartEvent {
  final int cartId;

  const DeleteFromCartBtn({required this.cartId});
}

class IncreaseItemsCartBtn extends CartEvent {
  final int cartItemId;
  final int count;

  const IncreaseItemsCartBtn(this.count, {required this.cartItemId});
}

class DecreaseItemsCartBtn extends CartEvent {
  final int cartItemId;
  final int count;

  const DecreaseItemsCartBtn({required this.cartItemId, required this.count});
}

class CartOnStarted extends CartEvent {
  final AuthInfo? authInfo;

  const CartOnStarted({required this.authInfo});
}

class AuthStateChangedEvent extends CartEvent {
  final AuthInfo? authInfo;

  const AuthStateChangedEvent({required this.authInfo});
}
