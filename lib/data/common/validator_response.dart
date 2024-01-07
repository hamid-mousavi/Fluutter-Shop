import 'package:dio/dio.dart';

mixin ValditorResponse {
  void validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw Exception('Eroor');
    }
  }
}
