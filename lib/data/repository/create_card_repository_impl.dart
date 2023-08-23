

import 'package:card_wallet/data/base/base_api_repository.dart';
import 'package:card_wallet/domain/models/card/card_data.dart';

import '../../domain/repository/create_card_repository.dart';
import '../../utils/resources/data_state.dart';
import '../remote/apiService/interview_api_service.dart';

class CreateCardRepositoryImpl extends BaseApiRepository implements CreateCardRepository {
  final InterviewApiService _apiService;

  CreateCardRepositoryImpl(this._apiService);

  @override
  Future<DataState<void>> createCard(
      {required String name, required String cardExpiration, required String cardHolder, required String cardNumber, required String category}) {
    return getStateOf<void>(
      request: () =>
          _apiService.addCard(
            CardData(
              name: name,
              cardExpiration: cardExpiration,
              cardHolder: cardHolder,
              cardNumber: cardNumber,
              category: category,
            ),
          ),
    );
  }
}