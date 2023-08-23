

import 'package:card_wallet/data/base/base_api_repository.dart';
import 'package:card_wallet/domain/models/display_card_data/Result.dart';
import 'package:card_wallet/utils/resources/data_state.dart';

import '../../domain/repository/getSingleCard.dart';
import '../remote/apiService/interview_api_service.dart';

class GetSingleCardRepositoryImpl extends BaseApiRepository implements GetSingleCardRepository {
  final InterviewApiService _apiService;

  GetSingleCardRepositoryImpl(this._apiService);

  @override
  Future<DataState<Result>> getSingleCard(String cardId) {
    return getStateOf<Result>(
      request: () => _apiService.getCard(cardId),
    );
  }
}