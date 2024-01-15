import 'package:nike/data/Model/Entity/banner.dart';
import 'package:nike/data/Source/banner_datasource.dart';
import 'package:nike/data/common/http_client.dart';

final bannerRepository = BannerRepository(BannerRemoteDatasorce(httpClient));

abstract class IBanerRepository {
  Future<List<BannerEntity>> getAll();
}

class BannerRepository implements IBanerRepository {
  final IBannerDatasource datasource;

  BannerRepository(this.datasource);
  @override
  Future<List<BannerEntity>> getAll() => datasource.getAll();
}
