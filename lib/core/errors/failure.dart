import 'package:equatable/equatable.dart';
import 'package:sahaj_dhan/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  const Failure({
    required this.message,
    required this.errorCode,
  });

  String get errorMessgae => "$errorCode : $message";

  final String message;
  final int errorCode;

  @override
  List<Object?> get props => [errorCode, message];
}

class ApiFailure extends Failure {
  const ApiFailure({
    required super.message,
    required super.errorCode,
  });

  factory ApiFailure.fromExpection(ApiException exception) =>
      ApiFailure(message: exception.message, errorCode: exception.errorCode);
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.errorCode = -1});
}

class UpdateFailure extends Failure {
  const UpdateFailure({required super.message, super.errorCode = -2});
}
