import 'package:dio/dio.dart';

import '../../../../utils/constants/strings.dart';

Dio createDioInstance() {
  final dio = Dio();

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      options.headers['Authorization'] = 'Bearer $defaultApiKey';
      return handler.next(options);
    },
  ));

  return dio;
}