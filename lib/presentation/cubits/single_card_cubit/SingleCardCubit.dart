

import 'package:card_wallet/presentation/cubits/base/base_cubit.dart';
import 'package:card_wallet/presentation/cubits/single_card_cubit/single_card_state.dart';

import '../../../domain/models/display_card_data/Result.dart';
import '../../../domain/repository/getSingleCard.dart';
import '../../../utils/resources/data_state.dart';

class SingleCardCubit extends BaseCubit<SingleCardCubitState, List<Result>> {
  final GetSingleCardRepository _getSingleCardRepository;
  SingleCardCubit(this._getSingleCardRepository) : super(const SingleCardLoading(), []);

  Future<void> getSingleCard(String id) async {
    await run(() async {
      final response = await _getSingleCardRepository.getSingleCard(id);
      if (response is DataSuccess) {
        final card = response.data;
        data.add(card!);
        emit(SingleCardSuccess(cards: data, noMoreData: true));
      } else if (response is DataFailure) {
        emit(SingleCardException(response.exception.toString()));
      }
    });
  }
}