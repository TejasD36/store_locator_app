import '/core.dart';

class NetworkApiService extends BaseApiServices {
  late final Dio _dio;

  NetworkApiService() {
    final baseOptions = BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      connectTimeout: Duration(seconds: 10),
      sendTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 30),
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      headers: Constants.header,
      validateStatus: (status) {
        // Treat only 2xx as valid responses
        return status != null && status >= 200 && status < 300;
      },
    );

    _dio = Dio(baseOptions);
    _dio.interceptors.addAll([
      NetworkInterceptor(),
      TalkerDioLogger(
        settings: TalkerDioLoggerSettings(
          printRequestData: Constants.debugMode,
          printRequestHeaders: Constants.debugMode,
          printResponseData: Constants.debugMode,
          printResponseTime: Constants.debugMode,
          printResponseMessage: Constants.debugMode,
          enabled: Constants.debugMode,
        ),
      ),
    ]);
  }

  @override
  Future<Either<AppException, Q>> getApi<Q>(
    String apiURL,
    Map<String, String> headers,
    Q Function(Map<String, dynamic>) fromJson, {
    bool disableTokenValidityCheck = false,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      if (queryParams != null && queryParams.isNotEmpty) {
        apiURL = "$apiURL${Uri(queryParameters: queryParams)}";
      }
      Response response = await _dio.get(apiURL);

      R callback<R>(Map<String, dynamic> jsonMap) {
        return fromJson(jsonMap) as R;
      }

      return Parser.parseResponse<Q, Q>(response, callback);
    } on DioException catch (e) {
      return Left(Failure.handleDioError(e));
    }
  }
}
