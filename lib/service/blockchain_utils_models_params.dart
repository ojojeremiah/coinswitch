import 'package:blockchain_utils/exception/exceptions.dart';
import 'package:coinswitch/service/blockchain_util_constant.dart';

import 'blockchain_utils.dart';

enum RequestServiceType {
  /// Represents an HTTP POST request.
  post,

  /// Represents an HTTP GET request.
  get;

  /// Checks if the current request type is a POST request.
  bool get isPostRequest => this == post;
}

/// Enum representing the types of responses that a service can return.
enum ServiceResponseType {
  /// Indicates that the service response is an error.
  error,

  /// Indicates that the service response is successful.
  success
}

/// Base class for handling service responses.
abstract class BaseServiceResponse<T> {
  final int statusCode;
  final ServiceResponseType type;
  const BaseServiceResponse({required this.statusCode, required this.type});

  /// Casts this instance to a specific subclass.
  E cast<E extends BaseServiceResponse>() {
    if (this is! E) {
      throw ArgumentException("BaseServiceResponse casting failed.");
    }
    return this as E;
  }

  /// Extracts the result from a successful response or throws an error.
  T getResult(BaseServiceRequestParams params) {
    return switch (type) {
      ServiceResponseType.error => throw RPCError(
          message: ServiceConst.httpErrorMessages[statusCode] ??
              "Unknown Error${statusCode == 200 ? '' : ' $statusCode'}: An unexpected error occurred.",
          errorCode: 200,
          request: params.toJson(),
          data: ServiceProviderUtils.findErrorDetails(
              statusCode: statusCode,
              object: cast<ServiceErrorResponse>().error),
        ),
      ServiceResponseType.success => cast<ServiceSuccessResponse<T>>().response
    };
  }
}

/// Represents a successful service response.
class ServiceSuccessResponse<T> extends BaseServiceResponse<T> {
  final T response;
  const ServiceSuccessResponse(
      {required super.statusCode, required this.response})
      : super(type: ServiceResponseType.success);
}

/// Represents an error response from the service.
class ServiceErrorResponse<T> extends BaseServiceResponse<T> {
  final String? error;
  const ServiceErrorResponse({required super.statusCode, required this.error})
      : super(type: ServiceResponseType.error);
}

/// Base parameters for a service request.
abstract class BaseServiceRequestParams {
  final Map<String, String> headers;
  final RequestServiceType type;
  final int requestID;
  final List<int>? successStatusCodes;
  final List<int>? errorStatusCodes;

  const BaseServiceRequestParams({
    required this.headers,
    required this.type,
    required this.requestID,
    this.successStatusCodes,
    this.errorStatusCodes,
  });

  Uri toUri(String uri);
  List<int>? body();
  Map<String, dynamic> toJson();

  /// Converts response data into a [BaseServiceResponse].
  BaseServiceResponse<T> toResponse<T>(Object? body, [int? statusCode]) {
    statusCode ??= 200;

    if (!ServiceProviderUtils.isSuccessStatusCode(statusCode)) {
      return ServiceErrorResponse(
          statusCode: statusCode,
          error: ServiceProviderUtils.findError(
              object: body, statusCode: statusCode));
    }

    try {
      T response;
      if (body is List<int>) {
        response = ServiceProviderUtils.toResult<T>(body);
      } else {
        response =
            ServiceProviderUtils.parseResponse<T>(object: body, params: this);
      }
      return ServiceSuccessResponse<T>(
          statusCode: statusCode, response: response);
    } catch (e) {
      throw RPCError(
          message: "Parsing response failed.",
          request: toJson(),
          data: {"expected": "$T", "error": e.toString()},
          errorCode: 403);
    }
  }

  /// Parses response bytes and converts to a typed response.
  BaseServiceResponse<T> parseResponse<T>(List<int> bodyBytes,
      [int? statusCode]) {
    statusCode ??= 200;

    if (!ServiceProviderUtils.isSuccessStatusCode(statusCode,
        allowSuccessStatusCodes: successStatusCodes)) {
      return ServiceErrorResponse(
          statusCode: statusCode,
          error: ServiceProviderUtils.findError(
              object: bodyBytes,
              statusCode: statusCode,
              allowStatusCode: errorStatusCodes));
    }

    try {
      T response = ServiceProviderUtils.toResult<T>(bodyBytes);
      return ServiceSuccessResponse<T>(
          statusCode: statusCode, response: response);
    } catch (e) {
      throw RPCError(
          message: "Parsing response failed.",
          request: toJson(),
          data: {"expected": "$T", "error": e.toString()},
          errorCode: 403);
    }
  }
}

/// Base class for a service request.
abstract class BaseServiceRequest<RESULT, SERVICERESPONSE,
    PARAMS extends BaseServiceRequestParams> {
  const BaseServiceRequest();
  abstract final RequestServiceType requestType;

  RESULT onResponse(SERVICERESPONSE result) {
    return result as RESULT;
  }

  PARAMS buildRequest(int requestID);
}

/// Base provider for handling service requests.
abstract class BaseProvider<PARAMS extends BaseServiceRequestParams> {
  Future<SERVICERESPONSE> requestDynamic<RESULT, SERVICERESPONSE>(
      BaseServiceRequest<RESULT, SERVICERESPONSE, PARAMS> request,
      {Duration? timeout});

  Future<RESULT> request<RESULT, SERVICERESPONSE>(
      BaseServiceRequest<RESULT, SERVICERESPONSE, PARAMS> request,
      {Duration? timeout});
}

/// Mixin to provide basic service request functionality.
mixin BaseServiceProvider<PARAMS extends BaseServiceRequestParams> {
  Future<BaseServiceResponse<T>> doRequest<T>(PARAMS params,
      {Duration? timeout});
}
