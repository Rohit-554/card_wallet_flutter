import 'package:card_wallet/domain/models/display_card_data/Result.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/models/display_card_data/CardData.dart';

abstract class DisplayCardsCubitState extends Equatable {
  final List<Result> cards;
  final bool noMoreData;
  final DioException?  error;

  const DisplayCardsCubitState({
    this.cards = const [],
    this.noMoreData = true,
    this.error,
  });

  @override
  List<Object?> get props => [cards, noMoreData, error];
}

class DisplayCardsLoading extends DisplayCardsCubitState {
  const DisplayCardsLoading();
}

class DisplayCardsSuccess extends DisplayCardsCubitState {
  const DisplayCardsSuccess({super.cards, super.noMoreData});
}

class DisplayCardsException extends DisplayCardsCubitState {
  final String errorMessage;
  DisplayCardsException(this.errorMessage);
}
