import 'dart:io' show HttpResponse, HttpStatus;

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:meta/meta.dart';

import '../../utils/resources/data_state.dart';

abstract class BaseApiRepository {
  @protected
  Future<DataState<T>> getStateOf<T>({
    required Future<HttpResponse<T>> Function() request,
  }) async {
    try {
      final httpResponse = await request();
      if (httpResponse.response.statusCode == HttpStatus.ok || httpResponse.response.statusCode == HttpStatus.created) {
        if (httpResponse.data != null) {
          return DataSuccess(data: httpResponse.data);
        } else {
          print("error here"+"${httpResponse.response}");
          return DataFailure(
            exception: DioException(
              response: httpResponse.response,
              requestOptions: httpResponse.response.requestOptions,
              message: "Response data is null",
            ),
          );
        }
      } else {
        throw DioException(
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
        );
      }
    } on DioException catch (e) {
      return DataFailure(exception: e);
    } catch (e) {
      // Handle other types of exceptions if needed
      return DataFailure(exception: DioException(error: e.toString(), requestOptions: RequestOptions(path: "")));
    }
  }
}

