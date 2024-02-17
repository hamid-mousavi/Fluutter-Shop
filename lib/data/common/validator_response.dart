import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

mixin ValditorResponse {
  static String messageValidateResponse = 'sssss';
  void validateResponse(Response response) {
    if (response.statusCode != 200) {
      messageValidateResponse = response.data['message'];
      throw Exception(messageValidateResponse);
    }
  }
}
