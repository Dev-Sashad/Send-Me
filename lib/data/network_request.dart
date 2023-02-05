import 'dart:io';
import 'package:path/path.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:send_me/_lib.dart';
import 'package:send_me/core/local_data_request/local_url.dart';
import '../core/local_data_request/local_data_request.dart';

abstract class NetworkProvider {
  Future<dynamic> call({
    required String path,
    required RequestMethod method,
    Map<String, dynamic> body = const {},
    Map<String, dynamic> queryParams = const {},
  });
  Future<dynamic> upload(
      {required String path,
      Map<String, dynamic> body = const {},
      Map<String, File> files = const {}});
}

class NetworkProviderImp extends NetworkProvider {
  final String baseUrl = AppEndpoint.baseUrl;

  Dio _getDioInstance() {
    var dio = Dio(
      BaseOptions(
        connectTimeout: 15000,
        receiveTimeout: 15000,
        // headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        // },
      ),
    );
    // dio.interceptors.add(AppInterceptor());

    //Pretty Dio logger is a Dio interceptor that logs network calls in a pretty, easy to read format.
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

    //Retry after failure
    dio.interceptors.add(RetryInterceptor(
      dio: dio,
      logPrint: print, // specify log function (optional)
      retries: 0, // retry count (optional)
      retryDelays: const [
        // set delays between retries (optional)
        Duration(seconds: 1), // wait 1 sec before first retry
        Duration(seconds: 2), // wait 2 sec before second retry
        Duration(seconds: 3), // wait 3 sec before third retry
      ],
    ));

    dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));

    return dio;
  }

  @override
  Future<dynamic> call({
    required String? path,
    required RequestMethod? method,
    Map<String, dynamic> body = const {},
    Map<String, dynamic> queryParams = const {},
  }) async {
    Response response;
    var url = baseUrl + path!;
    appPrint(url);
    _getDioInstance().options.headers.addAll(
      {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    try {
      switch (method!) {
        case RequestMethod.get:
          response =
              await _getDioInstance().get(url, queryParameters: queryParams);
          break;
        case RequestMethod.post:
          response = await _getDioInstance().post(url,
              data: FormData.fromMap(body),
              queryParameters: queryParams,
              options: Options(contentType: 'application/json'));
          break;
        case RequestMethod.patch:
          response = await _getDioInstance().patch(url,
              data: FormData.fromMap(body), queryParameters: queryParams);
          break;
        case RequestMethod.put:
          response = await _getDioInstance().put(url,
              data: FormData.fromMap(body), queryParameters: queryParams);
          break;
        case RequestMethod.delete:
          response = await _getDioInstance().delete(url,
              data: FormData.fromMap(body), queryParameters: queryParams);
          break;
      }
    } catch (e) {
      return ApiError.fromDioError(e);
    }
    if (response.data == null) {
      return ApiError(errorCode: 'error', errorMessage: 'An error occured');
    }
    if (response.data['status'] == 'error') {
      return ApiError(
          errorCode: "error", errorMessage: response.data['message']);
    }
    return response.data;
  }

  @override
  Future<dynamic> upload(
      {required String path,
      Map<String, dynamic> body = const {},
      Map<String, File> files = const {}}) async {
    Response response;
    var url = baseUrl + path;
    final token =
        await locator<LocalDataRequest>().getString(AppLocalUrl.token) ?? "";
    var need = {'token': token};
    body.addEntries(need.entries);
    try {
      Map<String, MultipartFile> fileMap = {};
      for (MapEntry fileEntry in files.entries) {
        File file = fileEntry.value;
        String fileName = basename(file.path);
        fileMap[fileEntry.key] = MultipartFile(
            file.openRead(), await file.length(),
            filename: fileName);
      }
      body.addAll(fileMap);
      var formData = FormData.fromMap(body);

      response = await _getDioInstance().post(url,
          data: formData, options: Options(contentType: 'multipart/form-data'));
    } catch (e) {
      return ApiError.fromDioError(e);
    }
    if (response.data == null) {
      return ApiError(errorCode: 'error', errorMessage: 'An error occured');
    }
    if (response.data['status'] == 'error') {
      return ApiError(
          errorCode: "error", errorMessage: response.data['message']);
    }
    return response.data;
  }
}

enum RequestMethod { get, post, put, patch, delete }
