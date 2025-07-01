import '../../core.dart';

class Failure {
  // Handle DioError and map it to custom exceptions
  static AppException handleDioError(DioException dioException) {
    // Handle the different Dio error types
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return TimeoutError(); // Connection timeout error
      case DioExceptionType.sendTimeout:
        return TimeoutError(); // Request send timeout
      case DioExceptionType.receiveTimeout:
        return TimeoutError(); // Response receive timeout
      case DioExceptionType.badCertificate:
        return HandshakeError(); // SSL certificate error
      case DioExceptionType.badResponse:
        return _handleBadResponseError(dioException); // Bad response (non-2xx HTTP codes)
      case DioExceptionType.cancel:
        return UnknownError(); // Request was cancelled
      case DioExceptionType.connectionError:
        return NoInternetError(); // Connection error (no internet, DNS issues)
      case DioExceptionType.unknown:
        // For errors like SSL Handshake failures or non-HTTP error responses
        if (dioException.error is SocketException) {
          return NoInternetError(); // No internet connection
        } else if (dioException.error is HandshakeException) {
          return HandshakeError(); // SSL handshake failed
        }
        return UnknownError();
    }
  }

  // Handle bad responses (non-2xx HTTP status codes)
  static AppException _handleBadResponseError(DioException dioException) {
    if (dioException.response != null) {
      final statusCode = dioException.response!.statusCode ?? 0;
      final statusMessage = dioException.response!.statusMessage;
      String message = "";

      if (dioException.response!.data != null && dioException.response!.data.toString().contains("message")) {
        message = dioException.response!.data?["message"];
      } else {
        message = "$statusMessage [$statusCode]";
      }

      // Handle based on HTTP status code
      switch (statusCode) {
        case 400:
          return BadRequestError(statusCode: statusCode, message: message);
        case 401:
          return UnauthorizedError(statusCode: statusCode, message: message);
        case 403:
          return ForbiddenError(statusCode: statusCode, message: message);
        case 404:
          return NotFoundError(statusCode: statusCode, message: message);
        case 405:
          return MethodNotAllowedError(statusCode: statusCode, message: message);
        case 409:
          return ConflictError(statusCode: statusCode, message: message);
        case 422:
          return UnprocessableEntityError(statusCode: statusCode, message: message);
        case 429:
          return TooManyRequestsError(statusCode: statusCode, message: message);
        case 500:
          return ServerError(statusCode: statusCode, message: message);
        case 502:
          return BadGatewayError(statusCode: statusCode, message: message);
        case 503:
          return ServiceUnavailableError();
        case 504:
          return GatewayTimeoutError();
        case 505:
          return HTTPVersionNotSupportedError(statusCode: statusCode, message: message);
        default:
          return UnknownError();
      }
    }
    return UnknownError(); // Fallback for any response without a valid status code
  }
}
