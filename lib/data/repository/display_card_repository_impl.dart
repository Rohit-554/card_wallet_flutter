import 'package:card_wallet/data/base/base_api_repository.dart';
import 'package:card_wallet/domain/models/display_card_data/CardData.dart';

import '../../domain/models/card/card_data.dart';
import '../../domain/repository/display_card.dart';
import '../../utils/resources/data_state.dart';
import '../remote/apiService/interview_api_service.dart';

class DisplayCardRepositoryImpl extends BaseApiRepository implements DisplayCardRepository {
  final InterviewApiService _apiService;
  DisplayCardRepositoryImpl(this._apiService);


  @override
  Future<DataState<CardDataDisp>> getCards() {
    return getStateOf<CardDataDisp>(
      request: () => _apiService.getCards(),
    );
  }
}