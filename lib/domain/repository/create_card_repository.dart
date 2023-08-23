
import '../../utils/resources/data_state.dart';

abstract class CreateCardRepository {
  Future<DataState<void>> createCard({
    required String name,
    required String cardExpiration,
    required String cardHolder,
    required String cardNumber,
    required String category,
  });
}