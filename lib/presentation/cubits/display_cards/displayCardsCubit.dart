

import 'dart:developer';

import 'package:card_wallet/domain/models/display_card_data/CardData.dart';
import 'package:card_wallet/domain/models/display_card_data/Result.dart';
import 'package:card_wallet/domain/repository/display_card.dart';
import 'package:card_wallet/presentation/cubits/base/base_cubit.dart';
import 'package:card_wallet/presentation/cubits/display_cards/displayCardsCubitState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants/nums.dart';
import '../../../utils/resources/data_state.dart';

class DisplayCardsCubit extends BaseCubit<DisplayCardsCubitState,List<Result>> {
  final DisplayCardRepository _displayCardsRepository;

  DisplayCardsCubit(this._displayCardsRepository) : super(const DisplayCardsLoading(), []);

  int _page = 1;


  Future<void> getCards() async {
    await run(() async {
      final response = await _displayCardsRepository.getCards();
      if (response is DataSuccess) {
        final cards = response.data;
        final noMoreData = cards!.results.length < defaultPageSize;
        data.addAll(cards.results);
        _page++;

        emit(DisplayCardsSuccess(
          cards: data,
          noMoreData: noMoreData,
        ));
      } else if (response is DataFailure) {
        emit(DisplayCardsException(response.exception.toString()));
      }
    }
    );
  }

}