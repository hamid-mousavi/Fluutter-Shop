part of 'product_detail_bloc.dart';

sealed class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object> get props => [];
}

final class ProductDetailInitial extends ProductDetailState {}

final class AddtoCartSuccess extends ProductDetailState {}

final class AddToCartError extends ProductDetailState {
  final String error;

  const AddToCartError({required this.error});
}

final class AddToCartLoading extends ProductDetailState {}
