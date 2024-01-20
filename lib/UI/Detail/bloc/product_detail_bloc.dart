import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/data/Repository/cart/cart_repository.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ICartRepository repository;
  ProductDetailBloc(this.repository) : super(ProductDetailInitial()) {
    on<ProductDetailEvent>((event, emit) async {
      if (event is AddToCartButtnClicked) {
        try {
          await repository.addItem(event.productId);
          emit(AddtoCartSuccess());
        } catch (e) {
          emit(AddToCartError(error: e.toString()));
        }
      }
    });
  }
}
