import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({
    required this.message,
    required this.errorCode,
  });

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
}
