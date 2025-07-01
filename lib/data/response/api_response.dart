import '/core.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;
  AppException? exception;

  ApiResponse(this.status, this.data, this.exception, this.message);

  ApiResponse.initial() : status = Status.initial;

  ApiResponse.loading() : status = Status.loading;

  ApiResponse.completed(this.data) : status = Status.completed;

  ApiResponse.error(this.exception) : status = Status.error;

  ApiResponse.setResponse(ApiResponse<T> response) {
    status = response.status;
    message = response.message;
    data = response.data;
    exception = response.exception;
  }

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data: $data \n Exception: $exception";
  }
}
