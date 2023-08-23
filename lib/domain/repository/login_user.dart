

import '../../utils/resources/data_state.dart';

abstract class LoginUserRepository {
  Future<DataState<void>> loginUser({
    required String email,
    required String password,
  });
}