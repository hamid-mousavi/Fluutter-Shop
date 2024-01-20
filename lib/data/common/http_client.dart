import 'package:dio/dio.dart';
import 'package:nike/data/Repository/Auth/AuthRepository.dart';

final httpClient =
    Dio(BaseOptions(baseUrl: 'http://expertdevelopers.ir/api/v1/'))
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          final authInfo = AuthRepository.authChangeNotifier.value;
          if (authInfo != null && authInfo.accessTocken.isNotEmpty) {
            options.headers['Authorization'] =
                'Bearer ${authInfo.accessTocken}';
          }
          handler.next(options);
        },
      ));
