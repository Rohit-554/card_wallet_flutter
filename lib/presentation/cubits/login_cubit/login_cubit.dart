
import 'dart:developer';

import 'package:card_wallet/presentation/cubits/base/base_cubit.dart';
import 'package:dio/dio.dart';

import '../../../domain/repository/login_user.dart';
import '../../../utils/resources/data_state.dart';
import 'login_cubit_state.dart';

class LoginCubit extends BaseCubit<LoginCubitState, String> {
  final LoginUserRepository _apiRepository;
  LoginCubit(this._apiRepository) : super(const LoginLoading(), " ");

  void loginUser({required String email, required String password}) async {
    if (isBusy) return;




    try {
      final response = await _apiRepository.loginUser(
        email: email,
        password: password,
      );
      log("loginresponse $response");
      if(response is DataSuccess) {
        emit(const LoginSuccess());
      }else if(response is DataFailure){
        log("xfailure $response");

        if (response.exception is DioException) {
          if (response.exception?.response?.statusCode == 400) {
            emit(LoginException(" Email or password is incorrect."));
          }else if(response.exception?.response?.statusCode == 200){
            emit(LoginSuccess());
          }

        } else {
          emit(LoginException(response.exception!.message.toString()));
        }
      }
    } catch (e) {
      print("datafailed");
      print(e);
      emit(LoginException("thisisexception $e"));
    }

  }
}