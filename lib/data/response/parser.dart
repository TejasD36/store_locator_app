import '../../../core.dart';

class Parser {
  static Future<Either<AppException, Q>> parseResponse<Q, R>(Response response, ComputeCallback<Map<String, dynamic>, R> callback) async {
    try {
      switch (response.statusCode) {
        case HttpStatus.ok:
        case HttpStatus.created:
          {
            final R result = await compute(callback, Map<String, dynamic>.from(response.data));
            return Right(result as Q);
          }

        default:
          return Left(UnknownError());
      }
    } catch (e) {
      return Left(UnknownError());
    }
  }

  static Future<T> parseResponseBody<T>(String responseBody, T Function(Map<String, dynamic>) fromJson) async {
    final Map<String, dynamic> jsonMap = json.decode(responseBody);
    return fromJson(jsonMap);
  }
}
