import 'package:equatable/equatable.dart';

class ApiException extends Equatable implements Exception {
  final String message;
  final int errorCode;

  const ApiException({
    required this.message,
    required this.errorCode,
  });

  @override
  List<Object?> get props => [message, errorCode];
}

class BadRequestException extends ApiException {
  const BadRequestException(String message, int errorCode)
      : super(message: "Invalid Request: $message", errorCode: errorCode);
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException(String message, int errorCode)
      : super(message: "Unauthorized: $message", errorCode: errorCode);
}

class ForbiddenException extends ApiException {
  const ForbiddenException(String message, int errorCode)
      : super(message: "Forbidden: $message", errorCode: errorCode);
}

class NotFoundException extends ApiException {
  const NotFoundException(String message, int errorCode)
      : super(message: "Not Found: $message", errorCode: errorCode);
}

class InternalServerException extends ApiException {
  const InternalServerException(String message, int errorCode)
      : super(message: "Internal Server: $message", errorCode: errorCode);
}

class UnprocessableContentException extends ApiException {
  const UnprocessableContentException(String message, int errorCode)
      : super(message: "Unprocessable Content: $message", errorCode: errorCode);
}

class InvalidInputException extends ApiException {
  const InvalidInputException(String message, int errorCode)
      : super(message: "Invalid Input: $message", errorCode: errorCode);
}
