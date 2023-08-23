


import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/models/display_card_data/Result.dart';

abstract class SingleCardCubitState extends Equatable {
  final List<Result> cards;
  final bool noMoreData;
  final DioException?  error;

  const SingleCardCubitState({
    this.cards = const [],
    this.noMoreData = true,
    this.error,
  });

  @override
  List<Object?> get props => [cards, noMoreData, error];
}

class SingleCardLoading extends SingleCardCubitState {
  const SingleCardLoading();
}

class SingleCardSuccess extends SingleCardCubitState {
  const SingleCardSuccess({super.cards, super.noMoreData});
}

class SingleCardException extends SingleCardCubitState {
  final String errorMessage;
  SingleCardException(this.errorMessage);
}