
import 'package:card_wallet/data/base/base_api_repository.dart';
import 'package:card_wallet/domain/repository/login_user.dart';

import '../../utils/resources/data_state.dart';
import '../remote/apiService/interview_api_service.dart';

class LoginRepositoryImpl extends BaseApiRepository implements LoginUserRepository {
  final InterviewApiService _apiService;
  LoginRepositoryImpl(this._apiService);

  @override
  Future<DataState<void>> loginUser(
      {required String email, required String password}) {
    return getStateOf<void>(
      request: () => _apiService.loginUser(
        LoginRequest(
          email: email,
          password: password,
        ),
      ),
    );
  }
}