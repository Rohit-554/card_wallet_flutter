import 'package:card_wallet/data/base/base_api_repository.dart';
import 'package:card_wallet/data/remote/apiService/interview_api_service.dart';
import 'package:card_wallet/domain/repository/register_repository.dart';
import 'package:card_wallet/utils/resources/data_state.dart';

class RegisterRepositoryImpl extends BaseApiRepository implements RegisterRepository{
  final InterviewApiService _apiService;
  RegisterRepositoryImpl(this._apiService);

  @override
  Future<DataState<void>> registerUser({required String name, required String email, required String password}) {
    return getStateOf<void>(
      request: () => _apiService.registerUser(
        RegistrationRequest(
          name: name,
          email: email,
          password: password,
        ),
      ),
    );
  }


}