import 'package:equatable/equatable.dart';

abstract class LoginCubitState extends Equatable{
  final String? response;
  final bool? isBusy;
  final Exception? error;

  const LoginCubitState({
    this.response = "",
    this.isBusy = false,
    this.error,
  });

  @override
  List<Object?> get props => [response, isBusy, error];
}

class LoginLoading extends LoginCubitState {
  const LoginLoading();
}

class LoginSuccess extends LoginCubitState {
  const LoginSuccess({super.response, super.isBusy});
}

class LoginException extends LoginCubitState {
  final String errorMessage;
  LoginException(this.errorMessage);
}