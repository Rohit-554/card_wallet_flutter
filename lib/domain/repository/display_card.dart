import 'package:card_wallet/domain/models/display_card_data/CardData.dart';

import '../../utils/resources/data_state.dart';

abstract class DisplayCardRepository {
  Future<DataState<CardDataDisp>> getCards();
}