//import 'package:meta/meta.dart';

class AppException implements Exception {
  final String? message;
  final String prefix;

  const AppException(this.message, this.prefix);

  @override
  String toString() => "$prefix$message";
}

class FetchDataException extends AppException {
  const FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  const BadRequestException([String? message])
      : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  const UnauthorisedException([String? message])
      : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  const InvalidInputException([String? message])
      : super(message, "Invalid Input: ");
}

class UnknownResponseException extends AppException {
  const UnknownResponseException([String? message]) : super(message, "Retry: ");
}

class NoQuestionsException extends AppException {
  const NoQuestionsException([String? message])
      : super(message, "NoQuestions: ");
}

class NoPollsException extends AppException {
  const NoPollsException([String? message]) : super(message, "NoPolls: ");
}

class NotFoundException extends AppException {
  const NotFoundException([String? message]) : super(message, "NotFound: ");
}
