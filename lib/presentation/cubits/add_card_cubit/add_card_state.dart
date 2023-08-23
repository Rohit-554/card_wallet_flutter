
import 'package:equatable/equatable.dart';

abstract class AddCardCubitState extends Equatable{
  final String? response;
  final bool? isBusy;
  final Exception? error;

  const AddCardCubitState({
    this.response = "",
    this.isBusy = false,
    this.error,
  });

  @override
  List<Object?> get props => [response, isBusy, error];
}

class AddCardLoading extends AddCardCubitState {
  const AddCardLoading();
}

class AddCardSuccess extends AddCardCubitState {
  const AddCardSuccess({super.response, super.isBusy});
}

class AddCardException extends AddCardCubitState {
  final String errorMessage;
  const AddCardException(this.errorMessage);
}