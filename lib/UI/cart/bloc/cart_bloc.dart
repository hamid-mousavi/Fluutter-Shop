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
      if (event is CartOnStarted) {
        final AuthInfo? authInfo = event.authInfo;
        if (authInfo == null || authInfo.accessTocken.isEmpty) {
          emit(AuthRequierd());
        } else {
          await loasCart(emit, event);
        }
      } else if (event is DeleteFromCartBtn) {
        await deleteCart(emit, event);
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
          final successState = (state as CartLoadSuccess);
          final item = successState.items.cartsItems
              .firstWhere((element) => element.cartItemId == event.cartItemId);
          item.changeCountBtn = true;
          emit(CartLoadSuccess(items: successState.items));
          await cartRepository.changeCount(event.cartItemId, event.count + 1);
          final items = await cartRepository.cartItemList();
          emit(CartLoadSuccess(items: items));
        } catch (e) {
          emit(CartError(error: e.toString()));
        }
      } else if (event is DecreaseItemsCartBtn) {
        try {
          final successState = (state as CartLoadSuccess);
          final item = successState.items.cartsItems
              .firstWhere((element) => element.cartItemId == event.cartItemId);
          item.changeCountBtn = true;
          emit(CartLoadSuccess(items: successState.items));
          await cartRepository.changeCount(event.cartItemId, event.count - 1);
          final items = await cartRepository.cartItemList();
          emit(CartLoadSuccess(items: items));
        } catch (e) {
          emit(CartError(error: e.toString()));
        }
      }
    });
  }

  Future<void> loasCart(Emitter<CartState> emit, CartOnStarted event) async {
    try {
      emit(CartLoading());
      final items = await cartRepository.cartItemList();
      emit(CartLoadSuccess(items: items));
    } catch (e) {
      emit(CartError(error: e.toString()));
    }
  }

  deleteCart(Emitter<CartState> emit, DeleteFromCartBtn event) async {
    try {
      final succesState = (state as CartLoadSuccess);
      final item = succesState.items.cartsItems
          .firstWhere((element) => element.cartItemId == event.cartId);
      if (state is CartLoadSuccess) {
        item.progressDeletingBtn = true;
        emit(CartLoadSuccess(items: succesState.items));
      }

      await cartRepository.removeCartItem(event.cartId);
      if (state is CartLoadSuccess) {
        succesState.items.cartsItems.remove(item);
        emit(CartLoadSuccess(items: succesState.items));
      }
    } catch (e) {
      emit(CartError(error: e.toString()));
    }
  }
}
