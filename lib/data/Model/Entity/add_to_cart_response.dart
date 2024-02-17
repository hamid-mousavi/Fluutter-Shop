import 'package:nike/data/Model/Entity/Product.dart';

class AddToCartResponse {
  final int id;
  final int productId;
  final int count;

  AddToCartResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        count = json['count'],
        productId = json['product_id'];
}

class CartItem {
  final int cartItemId;
  final ProductEntity productEntity;
  final int count;
  bool progressDeletingBtn = false;
  bool changeCountBtn = false;

  CartItem.fromJson(Map<String, dynamic> json)
      : cartItemId = json['cart_item_id'],
        productEntity = ProductEntity.fromJson(json['product']),
        count = json['count'];

  static List<CartItem> parseJsonArray(List<dynamic> jsonArray) {
    List<CartItem> cartItems = [];
    jsonArray.forEach((element) {
      cartItems.add(CartItem.fromJson(element));
    });
    return cartItems;
  }
}

class CartItemResponse {
  final List<CartItem> cartsItems;
  final int payablePrice;
  final int shippingCost;
  final int totalPrice;

  CartItemResponse.fromjson(Map<String, dynamic> json)
      : payablePrice = json['payable_price'],
        shippingCost = json['shipping_cost'],
        cartsItems = CartItem.parseJsonArray(json['cart_items']),
        totalPrice = json['total_price'];
}
