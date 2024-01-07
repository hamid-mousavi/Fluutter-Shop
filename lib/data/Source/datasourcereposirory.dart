import 'package:dio/dio.dart';
import 'package:nike/data/Model/Entity/Product.dart';
import 'package:nike/data/common/validator_response.dart';

abstract class IProductDataSource {
  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRemoteDatasource
    with ValditorResponse
    implements IProductDataSource {
  final Dio httpClient;

  ProductRemoteDatasource(this.httpClient);

  @override
  Future<List<ProductEntity>> getAll(int sort) async {
    List<ProductEntity> products = [];

    final response = await httpClient.get('product/list?sort=${sort}');
    validateResponse(response);
    (response.data as List).forEach((element) {
      products.add(ProductEntity.fromJson(element));
    });
    return products;
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) async {
    List<ProductEntity> products = [];
    final httpClient = Dio();

    final response = await httpClient.get('product/search?q=${searchTerm}');
    validateResponse(response);
    (response.data as List).forEach((element) {
      products.add(ProductEntity.fromJson(element));
    });
    return products;
  }
}
