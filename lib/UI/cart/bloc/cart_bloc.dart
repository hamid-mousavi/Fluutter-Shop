import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/data/Model/Entity/Auth.dart';
import 'package:nike/data/Model/Entity/add_to_cart_response.dart';
import 'package:nike/data/Repository/cart/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository cartRepository;
  CartBloc(this.cartRepository) : super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      emit(CartLoading());
      if (event is CartOnStarted) {
        final AuthInfo? authInfo = event.authInfo;
        if (authInfo == null || authInfo.accessTocken.isEmpty) {
          emit(AuthRequierd());
        } else {
          try {
            final items = await cartRepository.cartItemList();
            emit(CartLoadSuccess(items: items));
          } catch (e) {
            emit(CartError(error: e.toString()));
          }
        }
      } else if (event is DeleteFromCartBtn) {
        try {
          await cartRepository.removeCartItem(event.cartId);
          final items = await cartRepository.cartItemList();
          emit(CartLoadSuccess(items: items));
        } catch (e) {
          emit(CartError(error: e.toString()));
        }
      } else if (event is AuthStateChangedEvent) {
        final AuthInfo? authInfo = event.authInfo;
        if (authInfo == null || authInfo.accessTocken.isEmpty) {
          emit(AuthRequierd());
        } else {
          try {
            final items = await cartRepository.cartItemList();
            emit(CartLoadSuccess(items: items));
          } catch (e) {
            emit(CartError(error: e.toString()));
          }
        }
      } else if (event is IncreaseItemsCartBtn) {
        try {
          await cartRepository.changeCount(event.cartItemId, event.count + 1);
          final items = await cartRepository.cartItemList();
          emit(CartLoadSuccess(items: items));
        } catch (e) {
          emit(CartError(error: e.toString()));
        }
      } else if (event is DecreaseItemsCartBtn) {
        try {
          if (event.count < 2) {
            await cartRepository.removeCartItem(event.cartItemId);
            final items = await cartRepository.cartItemList();
            emit(CartLoadSuccess(items: items));
          } else {
            await cartRepository.changeCount(event.cartItemId, event.count - 1);
            final items = await cartRepository.cartItemList();
            emit(CartLoadSuccess(items: items));
          }
        } catch (e) {
          emit(CartError(error: e.toString()));
        }
      }
    });
  }
}
