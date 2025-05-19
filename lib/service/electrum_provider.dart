import 'package:blockchain_utils/blockchain_utils.dart';
import 'dart:async';

import 'blockchain_utils.dart';
import 'blockchain_utils_models_params.dart';
import 'electrum_provider_services.dart';
import 'provider_core_params.dart';

class ElectrumProvider extends BaseProvider<ElectrumRequestDetails> {
  final ElectrumServiceProvider rpc;
  ElectrumProvider(this.rpc);

  /// The unique identifier for each JSON-RPC request.
  int _id = 0;

  /// Sends a request to the Electrum server.
  @override
  Future<RESULT> request<RESULT, SERVICERESPONSE>(
      BaseServiceRequest<RESULT, SERVICERESPONSE, ElectrumRequestDetails>
          request,
      {Duration? timeout}) async {
    final response = await requestDynamic(request, timeout: timeout);
    return request.onResponse(response);
  }

  /// Sends a dynamic request to the Electrum server.
  @override
  Future<SERVICERESPONSE> requestDynamic<RESULT, SERVICERESPONSE>(
      BaseServiceRequest<RESULT, SERVICERESPONSE, ElectrumRequestDetails>
          request,
      {Duration? timeout}) async {
    final params = request.buildRequest(_id++);

    // Call the implemented `doRequest<T>()` method.
    final response =
        await doRequest<Map<String, dynamic>>(params, timeout: timeout);

    return _findResult(params: params, response: response);
  }

  /// Implements `doRequest<T>()` for Electrum requests.
  @override
  Future<BaseServiceResponse<T>> doRequest<T>(ElectrumRequestDetails params,
      {Duration? timeout}) async {
    // Call the actual RPC provider to handle the request.
    return await rpc.doRequest<T>(params, timeout: timeout);
  }

  /// Processes the response from Electrum and handles errors if present.
  SERVICERESPONSE _findResult<SERVICERESPONSE>({
    required ElectrumRequestDetails params,
    required BaseServiceResponse<Map<String, dynamic>> response,
  }) {
    final data = response.getResult(params);

    if (data.containsKey('error') && data['error'] != null) {
      final errorJson = StringUtils.toJson(data['error']);
      final errorCode = IntUtils.tryParse(errorJson?['code']);
      final errorMessage = errorJson?['message']?.toString() ?? 'Unknown error';

      throw RPCError(
        errorCode: errorCode ?? 403,
        message: errorMessage,
        request: params.toJson(),
        data: errorJson,
      );
    }

    return ServiceProviderUtils.parseResponse(
      object: data['result'],
      params: params,
    );
  }
}
