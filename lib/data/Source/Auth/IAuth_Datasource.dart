import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nike/data/Model/Entity/Auth.dart';
import 'package:nike/data/common/validator_response.dart';

const clientsecret = 'kyj1c9sVcksqGU4scMX7nLDalkjp2WoqQEf8PKAC';

abstract class IAuthDatasourse {
  IAuthDatasourse(Dio httpClient);

  Future<AuthInfo> login(String userName, String password);
  Future<AuthInfo> register(String userName, String password);
  Future<AuthInfo> refreshTocken(String tocken);
}

class AuthRemoteDatasource with ValditorResponse implements IAuthDatasourse {
  final Dio httpClient;

  AuthRemoteDatasource({required this.httpClient});
  @override
  Future<AuthInfo> login(String userName, String password) async {
    final response = await httpClient.post('auth/token', data: {
      'grant_type': 'password',
      'client_id': 2,
      'client_secret': clientsecret,
      'username': userName,
      'password': password
    });
    validateResponse(response);
    debugPrint(response.data['refresh_token']);
    return AuthInfo(
        accessTocken: response.data['access_token'],
        refreshTocken: response.data['refresh_token']);
  }

  @override
  Future<AuthInfo> refreshTocken(String tocken) async {
    final response = await httpClient.post('auth/token', data: {
      'grant_type': 'refresh_token',
      'refresh_token': tocken,
      'client_id': 2,
      'client_secret': clientsecret,
    });
    validateResponse(response);
    return AuthInfo(
        accessTocken: response.data['access_token'],
        refreshTocken: response.data['refresh_token']);
  }

  @override
  Future<AuthInfo> register(String userName, String password) async {
    final response = await httpClient
        .post('user/register', data: {'email': userName, 'password': password});
    validateResponse(response);
    return login(userName, password);
  }
}
