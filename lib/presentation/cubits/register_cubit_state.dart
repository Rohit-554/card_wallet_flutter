import 'package:equatable/equatable.dart';

abstract class RegisterCubitState extends Equatable {

  final String? response;
  final bool? isBusy;
  final Exception? error;

  const RegisterCubitState({
    this.response = "",
    this.isBusy = false,
    this.error,
  });



  @override
  List<Object?> get props => [response, isBusy, error];
}

class RegisterLoading extends RegisterCubitState {
  const RegisterLoading();
}

class RegisterSuccess extends RegisterCubitState {
  const RegisterSuccess({super.response, super.isBusy});
}

class RegisterException extends RegisterCubitState {
  final String errorMessage;
  RegisterException(this.errorMessage);
}

