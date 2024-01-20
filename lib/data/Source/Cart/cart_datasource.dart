import 'package:dio/dio.dart';
import 'package:nike/data/Repository/cart/cart_repository.dart';

import '../../Model/Entity/add_to_cart_response.dart';

abstract class ICartDataSource {
  Future<AddToCartResponse> addItem(int productId);
  Future<CartItemResponse> cartItemList();
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
}
