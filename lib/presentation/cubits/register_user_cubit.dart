

import 'dart:developer';

import 'package:card_wallet/presentation/cubits/base/base_cubit.dart';
import 'package:card_wallet/presentation/cubits/register_cubit_state.dart';
import 'package:dio/dio.dart';

import '../../domain/repository/register_repository.dart';
import '../../utils/resources/data_state.dart';

class RegisterUserCubit extends BaseCubit<RegisterCubitState, String> {
  final RegisterRepository _apiRepository;

  RegisterUserCubit(this._apiRepository) : super(const RegisterLoading(), " ");

  void registerUser({required String name, required String email, required String password}) async {
    if (isBusy) return;

    try {
      final response = await _apiRepository.registerUser(
        name: name,
        email: email,
        password: password,
      );

      if (response is DataSuccess) {
        log("register Success");
        emit(const RegisterSuccess());
      } else if (response is DataFailure) {
        if (response.exception is DioException) {
          if (response.exception?.response?.statusCode == 400) {
            emit(RegisterException("Email is already taken."));
          }else if(response.exception?.response?.statusCode == 201){
            emit(RegisterSuccess());
          }

        } else {
          emit(RegisterException(response.exception!.message.toString()));
        }
      }
    } catch (e) {
      log("register Error");
      emit(RegisterException("this is exception $e"));
    }
  }




}