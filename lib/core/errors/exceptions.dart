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
      : super(message: "Invalid Request: ", errorCode: errorCode);
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException(String message, int errorCode)
      : super(message: "Unauthorized: ", errorCode: errorCode);
}

class ForbiddenException extends ApiException {
  const ForbiddenException(String message, int errorCode)
      : super(message: "Forbidden: ", errorCode: errorCode);
}

class NotFoundException extends ApiException {
  const NotFoundException(String message, int errorCode)
      : super(message: "Not Found: ", errorCode: errorCode);
}

class InternalServerException extends ApiException {
  const InternalServerException(String message, int errorCode)
      : super(message: "Internal Server: ", errorCode: errorCode);
}

class UnprocessableContentException extends ApiException {
  const UnprocessableContentException(String message, int errorCode)
      : super(message: "Unprocessable Content: ", errorCode: errorCode);
}

class InvalidInputException extends ApiException {
  const InvalidInputException(String message, int errorCode)
      : super(message: "Invalid Input: ", errorCode: errorCode);
}
