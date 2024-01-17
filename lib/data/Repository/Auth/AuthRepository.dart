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
  Future<void> signOut();
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
    final AuthInfo authInfo =
        await datasourse.refreshTocken(authChangeNotifier.value!.refreshTocken);
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
    loadToken();
  }

  Future<void> loadToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString("access_token") ?? '';
    final refreshToken = sharedPreferences.getString("access_token") ?? '';
    authChangeNotifier.value =
        AuthInfo(accessTocken: accessToken, refreshTocken: refreshToken);
  }

  @override
  Future<void> signOut() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.clear();
    authChangeNotifier.value = null;
  }
}
