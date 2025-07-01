// Base class for all exceptions
class AppException implements Exception {
  final int code;
  final String message;

  AppException(this.code, this.message);
  AppException.validation(this.message, {this.code = 0});

  @override
  String toString() => 'AppException(code: $code, message: $message)';
}

// No internet connection
class NoInternetError extends AppException {
  NoInternetError() : super(503, 'No internet connection'); // Service Unavailable
}

// Timeout error
class TimeoutError extends AppException {
  TimeoutError() : super(504, 'The request timed out'); // Gateway Timeout
}

// SSL Handshake error
class HandshakeError extends AppException {
  HandshakeError() : super(526, 'SSL Handshake failed'); // Invalid SSL certificate
}

// Session expired error (custom code)
class SessionExpiry extends AppException {
  SessionExpiry() : super(401, 'Session has expired'); // Unauthorized (session expired)
}

// Unknown error (fallback for undefined errors)
class UnknownError extends AppException {
  UnknownError() : super(520, 'An unknown error occurred'); // Unknown error
}

// Forbidden error (403 - forbidden access)
class ForbiddenError extends AppException {
  ForbiddenError({int? statusCode, String? message}) : super(statusCode ?? 403, message ?? 'Forbidden');
}

// Unauthorized error (401 - invalid credentials or token)
class UnauthorizedError extends AppException {
  UnauthorizedError({int? statusCode, String? message}) : super(statusCode ?? 401, message ?? 'Session Timeout, Please login.');
}

// Not Found error (404 - requested resource not found)
class NotFoundError extends AppException {
  NotFoundError({int? statusCode, String? message}) : super(statusCode ?? 404, message ?? 'Resource not found');
}

// Internal Server Error (500 - generic server error)
class ServerError extends AppException {
  ServerError({int? statusCode, String? message}) : super(statusCode ?? 500, message ?? 'Internal server error');
}

// Bad Request error (400 - malformed request)
class BadRequestError extends AppException {
  BadRequestError({int? statusCode, String? message}) : super(statusCode ?? 400, message ?? 'Bad request');
}

// Unprocessable Entity error (422 - validation errors)
class UnprocessableEntityError extends AppException {
  UnprocessableEntityError({int? statusCode, String? message}) : super(statusCode ?? 422, message ?? 'Unprocessable entity');
}

// Conflict error (409 - conflict, e.g. duplicate resource)
class ConflictError extends AppException {
  ConflictError({int? statusCode, String? message}) : super(statusCode ?? 409, message ?? 'Conflict');
}

// Service Unavailable error (503 - server temporarily unavailable)
class ServiceUnavailableError extends AppException {
  ServiceUnavailableError() : super(503, 'Service temporarily unavailable');
}

// Gateway Timeout error (504 - server did not respond in time)
class GatewayTimeoutError extends AppException {
  GatewayTimeoutError() : super(504, 'Gateway timeout');
}

// Precondition Failed error (412 - precondition not met)
class PreconditionFailedError extends AppException {
  PreconditionFailedError({int? statusCode, String? message}) : super(statusCode ?? 412, message ?? 'Precondition failed');
}

// User Exists error (422 - user already exists, conflict)
class UserExistsError extends AppException {
  UserExistsError({int? statusCode, String? message}) : super(statusCode ?? 422, message ?? 'User already exists');
}

class ValidationError extends AppException {
  ValidationError({int? statusCode, String? message}) : super(statusCode ?? 0, message ?? 'Something went wrong!');
}

class MethodNotAllowedError extends AppException {
  MethodNotAllowedError({int? statusCode, String? message})
      : super(statusCode ?? 405, message ?? 'Method Not Allowed: The HTTP method used is not supported for the requested resource.');
}

class TooManyRequestsError extends AppException {
  TooManyRequestsError({int? statusCode, String? message})
      : super(statusCode ?? 429, message ?? 'Too Many Requests: You have sent too many requests in a given amount of time.');
}

class BadGatewayError extends AppException {
  BadGatewayError({int? statusCode, String? message})
      : super(
            statusCode ?? 502,
            message ??
                'Bad Gateway: The server, while acting as a gateway or proxy, received an invalid response from an upstream server.');
}

class HTTPVersionNotSupportedError extends AppException {
  HTTPVersionNotSupportedError({int? statusCode, String? message})
      : super(statusCode ?? 505,
            message ?? 'HTTP Version Not Supported: The server does not support the HTTP protocol version that was used in the request.');
}
