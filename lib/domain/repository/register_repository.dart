
import '../../utils/resources/data_state.dart';

abstract class RegisterRepository{
  Future<DataState<void>> registerUser({
    required String name,
    required String email,
    required String password,
  });
}