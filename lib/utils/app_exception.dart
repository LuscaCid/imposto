
abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException(this.message, {this.statusCode});

  @override
  String toString() => '$runtimeType: $message';
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String message = "Usuário não autorizado."])
    : super(message, statusCode: 401);
}

class NotFoundException extends AppException {
  NotFoundException([String message = "Recurso não encontrado"])
    : super(message, statusCode: 404);
}

class BadRequestException extends AppException {
  BadRequestException([String message = "Requisição inválida"])
    : super(message, statusCode: 400);
}

class InternalServerError extends AppException {
  InternalServerError([String message = "Erro interno no servidor"])
    : super(message, statusCode: 500);
}
