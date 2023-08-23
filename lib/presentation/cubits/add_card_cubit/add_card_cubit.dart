


import 'dart:developer';

import 'package:card_wallet/domain/repository/create_card_repository.dart';
import 'package:card_wallet/presentation/cubits/base/base_cubit.dart';
import 'package:dio/dio.dart';

import '../../../utils/resources/data_state.dart';
import 'add_card_state.dart';

class AddCardCubit extends BaseCubit<AddCardCubitState, String> {
  final CreateCardRepository _apiRepository;
  AddCardCubit(this._apiRepository) : super(const AddCardLoading(), " ");

  void addCard({required String name, required String cardExpiration, required String cardHolder, required String cardNumber, required String category}) async {
    if (isBusy) return;




    try {
      final response = await _apiRepository.createCard(
        name: name,
        cardExpiration: cardExpiration,
        cardHolder: cardHolder,
        cardNumber: cardNumber,
        category: category,
      );
      log("card_response: ${response}");
      if(response is DataSuccess) {
        emit(const AddCardSuccess());
      }

      else if(response is DataFailure){
        log("card_response_failed: ${response.exception}");
        emit(AddCardException(response.exception!.message.toString()));
        if (response.exception is DioException) {
          if (response.exception?.response?.statusCode == 400) {
            emit(AddCardException(" Email or password is incorrect."));
          }
        } else {
          emit(AddCardException(response.exception!.message.toString()));
        }
      }

    } catch (e) {
      log("card_response_failed: $e");
      emit(AddCardException("Something went wrong. Please try again later."));
    }
  }
}