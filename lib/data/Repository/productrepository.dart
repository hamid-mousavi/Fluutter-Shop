import 'package:nike/data/Model/Entity/Product.dart';
import 'package:nike/data/Source/datasourcereposirory.dart';
import 'package:nike/data/common/http_client.dart';

final productRepository =
    ProductRepository(ProductRemoteDatasource(httpClient));

abstract class IProductRepository {
  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRepository implements IProductRepository {
  final IProductDataSource dataSource;
  ProductRepository(this.dataSource);
  @override
  Future<List<ProductEntity>> getAll(int sort) => dataSource.getAll(sort);
  @override
  Future<List<ProductEntity>> search(String searchTerm) =>
      dataSource.search(searchTerm);
}
