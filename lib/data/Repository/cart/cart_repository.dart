import 'dart:io';

import 'package:nike/data/Source/Cart/cart_datasource.dart';
import 'package:nike/data/common/http_client.dart';

import '../../Model/Entity/add_to_cart_response.dart';

final cartRepository =
    CartRepository(dataSource: CartRemoteDataSource(httpClient: httpClient));

abstract class ICartRepository {
  Future<AddToCartResponse> addItem(int productId);
  Future<CartItemResponse> cartItemList();
  Future<void> changeCount(int cartItemId, int count);
  Future<void> removeCartItem(int cartItemId);
}

class CartRepository implements ICartRepository {
  final ICartDataSource dataSource;

  CartRepository({required this.dataSource});
  @override
  Future<AddToCartResponse> addItem(int productId) async {
    final cartItem = await dataSource.addItem(productId);
    return cartItem;
  }

  @override
  Future<CartItemResponse> cartItemList() async {
    final data = dataSource.cartItemList();
    return data;
  }

  @override
  Future<void> changeCount(int cartItemId, int count) async {
    final data = await dataSource.changeCount(cartItemId, count);
    return data;
  }

  @override
  Future<void> removeCartItem(int cartItemId) async {
    await dataSource.removeCartItem(cartItemId);
  }
}
