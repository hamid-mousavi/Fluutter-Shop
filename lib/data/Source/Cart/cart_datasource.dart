import 'package:dio/dio.dart';

import '../../Model/Entity/add_to_cart_response.dart';

abstract class ICartDataSource {
  Future<AddToCartResponse> addItem(int productId);
  Future<CartItemResponse> cartItemList();
  Future<void> changeCount(int cartItemId, int count);
  Future<void> removeCartItem(int cartItemId);
}

class CartRemoteDataSource implements ICartDataSource {
  final Dio httpClient;

  CartRemoteDataSource({required this.httpClient});
  @override
  Future<AddToCartResponse> addItem(int productId) async {
    final response =
        await httpClient.post('cart/add', data: {'product_id': productId});
    return AddToCartResponse.fromJson(response.data);
  }

  @override
  Future<CartItemResponse> cartItemList() async {
    final response = await httpClient.get('cart/list');
    return CartItemResponse.fromjson(response.data);
  }

  @override
  Future<void> changeCount(int cartItemId, int count) async {
    final response = await httpClient.post('cart/changeCount',
        data: {'cart_item_id': cartItemId, 'count': count});
    return response.data;
  }

  @override
  Future<void> removeCartItem(int cartItemId) async {
    final response = await httpClient.post('cart/remove', data: {
      'cart_item_id': cartItemId,
    });
    return response.data;
  }
}
