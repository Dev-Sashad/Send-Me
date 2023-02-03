import 'package:dio/dio.dart';
import 'package:send_me/_lib.dart';

class ApiError {
  final String errorCode;
  final String errorMessage;
  ApiError({
    required this.errorCode,
    required this.errorMessage,
  });

  factory ApiError.fromDioError(Object error) {
    String errorMessage = '';
    String errorCode = '';
    if (error is DioError) {
      var dioError = error;
      switch (dioError.type) {
        case DioErrorType.cancel:
          errorMessage = 'Request was cancelled';
          errorCode = 'REQUEST_CANCELLED';
          break;
        case DioErrorType.connectTimeout:
          errorMessage = 'Connection timeout';
          errorCode = 'CONNECTION_TIMEOUT';
          break;
        case DioErrorType.other:
          errorMessage = 'Connection failed. Check internet connection';
          errorCode = 'NETWORK_ERROR';
          break;
        case DioErrorType.receiveTimeout:
          errorMessage = 'Receive timeout in connection';
          errorCode = 'RECEIVE_TIMEOUT';
          break;
        case DioErrorType.response:
          if (dioError.response!.statusCode == 300) {
            errorMessage = 'Session timeout';
            errorCode = 'SESSION_TIMEOUT';
            // SessionTimeoutProvider.logoutUser();
          } else if (dioError.response!.statusCode == 500) {
            errorMessage = 'A Server error occurred';
            errorCode = 'SERVER_FAILURE';
          } else if (dioError.response!.statusCode == 401) {
            errorMessage = 'Unauthorized request';
            errorCode = 'UnAuthorised';
          } else {
            final errorData = extractDataFromResponse(error.response!);

            errorCode = errorData['code'] ?? '';
            errorMessage = errorData['message'] ?? '';
          }
          break;
        case DioErrorType.sendTimeout:
          errorMessage = 'Send timeout in connection';
          errorCode = 'SEND_TIMEOUT';
          break;
      }
    } else {
      errorMessage = _handleException(error);
    }
    appPrint('errorCode: $errorCode, errorMessage: $errorMessage');
    return ApiError(errorCode: errorCode, errorMessage: errorMessage);
  }

  static String _handleException(dynamic exception) {
    if (exception is String) {
      return exception;
    } else {
      return 'An unexpected error occurred, please try again';
    }
  }

  static Map<String, String> extractDataFromResponse(Response response) {
    var message = '';
    String errorCode = '';

    var decodeResponse = response.data;

    if (response.data != null) {
      if (decodeResponse['message'] != null) {
        message = decodeResponse['message'];
      } else if (decodeResponse['status'] != null) {
        message = decodeResponse['status'];
      } else {
        message = 'An unexpected error occurred, please try again';
      }
      errorCode = decodeResponse['code'] ?? 'UNEXPECTED_ERROR';
    } else {
      message = response.statusMessage ?? '';
    }

    return {'message': message, 'code': errorCode};
  }
}
