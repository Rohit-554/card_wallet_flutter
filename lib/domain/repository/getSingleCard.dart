



import 'package:card_wallet/domain/models/display_card_data/Result.dart';

import '../../utils/resources/data_state.dart';

abstract class GetSingleCardRepository {
  Future<DataState<Result>> getSingleCard(String cardId);
}