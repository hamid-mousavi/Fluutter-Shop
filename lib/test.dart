import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nike/data/Model/Entity/Product.dart';

main() {
  getAll(1).then((value) {
    debugPrint(value.toString());
  });
}

Future<List<ProductEntity>> getAll(int sort) async {
  List<ProductEntity> products = [];
  final httpClient = Dio();

  final response = await httpClient
      .get('http://expertdevelopers.ir/api/v1/product/list?sort=${sort}');
  validateResponse(response);
  (response.data as List).forEach((element) {
    products.add(ProductEntity.fromJson(element));
  });
  return products;
}

void validateResponse(Response response) {
  if (response.statusCode != 200) {
    throw Exception('Eroor');
  }
}
