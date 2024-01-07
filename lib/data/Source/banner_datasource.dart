import 'package:dio/dio.dart';
import 'package:nike/data/Model/Entity/banner.dart';
import 'package:nike/data/common/validator_response.dart';
import 'package:nike/main.dart';

abstract class IBannerDatasource {
  Future<List<BannerEntity>> getAll();
}

class BannerDatasorce with ValditorResponse implements IBannerDatasource {
  final Dio httpClient;

  BannerDatasorce(this.httpClient);
  @override
  Future<List<BannerEntity>> getAll() async {
    final respnse = await httpClient.get('banner/slider');
    validateResponse(respnse);
    final List<BannerEntity> banners = [];
    (respnse.data as List).forEach((element) {
      banners.add(BannerEntity.fromJson(element));
    });
    return banners;
  }
}
