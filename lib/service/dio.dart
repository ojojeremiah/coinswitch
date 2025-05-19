import 'package:coinswitch/service/endpoints.dart';
import 'package:dio/dio.dart';
import '../helper/helper.dart';

class DioClient {
  final Dio _dio = Dio();

  DioClient() {
    _dio
      ..options.connectTimeout =
          const Duration(seconds: Endpoints.connectionTimeout)
      ..options.receiveTimeout =
          const Duration(seconds: Endpoints.receiveTimeout)
      ..options.contentType = 'application/json'
      ..options.headers['Content-Type'] = 'application/json'
      ..options.responseType = ResponseType.json
      ..options.followRedirects = false
      ..options.validateStatus = (status) {
        return status! < 500;
      }
      ..interceptors.add(LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseBody: true));
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(url,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return response;
    } catch (e) {
      if (e is DioException) {
        logger.e(e.response);
      }
      rethrow;
    }
  }

  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(uri,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      return response;
    } catch (e) {
      if (e is DioException) {
        logger.e(e.response);
      }
      rethrow;
    }
  }

  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(uri,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      return response;
    } catch (e) {
      if (e is DioException) {
        logger.e(e.stackTrace);
      }
      rethrow;
    }
  }

  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      if (e is DioException) {
        logger.e(e.response);
      }
      rethrow;
    }
  }
}
