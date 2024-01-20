part of 'product_detail_bloc.dart';

sealed class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class AddToCartButtnClicked extends ProductDetailEvent {
  final int productId;

  AddToCartButtnClicked({required this.productId});
}
