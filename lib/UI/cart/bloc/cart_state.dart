part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

class CartLoadSuccess extends CartState {
  final CartItemResponse items;

  const CartLoadSuccess({required this.items});
}

class CartError extends CartState {
  final String error;

  const CartError({required this.error});
}

class CartLoading extends CartState {}

class AuthRequierd extends CartState {}
