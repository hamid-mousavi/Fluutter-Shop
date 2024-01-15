import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:nike/data/Model/Entity/Auth.dart';
import 'package:nike/data/Source/Auth/IAuth_Datasource.dart';
import 'package:nike/data/common/http_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepository =
    AuthRepository(AuthRemoteDatasource(httpClient: httpClient));

abstract class IAuthRepository {
  Future<void> login(String userName, String password);
  Future<void> register(String userName, String password);
  Future<void> refreshTocken();
}

class AuthRepository implements IAuthRepository {
  static final ValueNotifier<AuthInfo?> authChangeNotifier =
      ValueNotifier(null);
  final IAuthDatasourse datasourse;
  AuthRepository(this.datasourse);

  @override
  Future<void> login(String userName, String password) async {
    final AuthInfo authInfo = await datasourse.login(userName, password);
    _persistAuthTokens(authInfo);
    debugPrint(authInfo.accessTocken);
  }

  @override
  Future<void> refreshTocken() async {
    final AuthInfo authInfo = await datasourse.refreshTocken(
        'def50200b7a7667731ec6598be21d2876c689b094e70b52c38fc410a9cb2e4445cc261f55704c10e8b9ae55ec5c039a3e0672bbeb236723d9395bec590de298ee4691bdd057384e08059bd48073b8fc80d587c94295aa4cacd597bc0ca76ce0a472a084e865c8aa2123da54f2df5c6b427d308bacb8ae8d3bcb70204f6d387d864debb1879e656c2ec36b21c37b4520f7e7c26d48efdba3a9b89f61f3eac95ed36f444746038e9c179b89e6a0b429f2f261361f53f21daa1ed89bfee273143eeb14807b92d5cfd6d6834fa6c198e9dba128a3d5bcbbf00d2eaade1e3cfcd6a805ee452e90881d0179b98a8c8d595fce30110231241684ebe016d590c2b55decde6ad3ea5f78772ed0ca3e104e6a67ba492ef0a2c44d4a6664cf59eda415cddf162a731fc646ab8a2d08ad76bbcc4872ba9d28a3ca5360db19431e6928047b46d2cdaacefada6959e735a969123d88464ffc8c34c28eb143b7925b9da0c161ac3');
    _persistAuthTokens(authInfo);
  }

  @override
  Future<void> register(String userName, String password) async {
    final AuthInfo authInfo = await datasourse.register(userName, password);
    _persistAuthTokens(authInfo);
    debugPrint(authInfo.accessTocken);
  }

  Future<void> _persistAuthTokens(AuthInfo authInfo) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("access_token", authInfo.accessTocken);
    sharedPreferences.setString("refresh_token", authInfo.accessTocken);
  }

  Future<void> loadToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString("access_token") ?? '';
    final refreshToken = sharedPreferences.getString("access_token") ?? '';
    authChangeNotifier.value =
        AuthInfo(accessTocken: accessToken, refreshTocken: refreshToken);
  }
}
