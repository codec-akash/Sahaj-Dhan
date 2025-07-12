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
  NetworkFailure({required String message, int errorCode = -1})
      : super(message: message, errorCode: errorCode);
}

class UpdateFailure extends Failure {
  UpdateFailure({required String message, int errorCode = -2})
      : super(message: message, errorCode: errorCode);
}
