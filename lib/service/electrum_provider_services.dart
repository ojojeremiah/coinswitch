import 'blockchain_utils_models_params.dart';
import 'provider_core_params.dart';

/// A mixin defining the service provider contract for interacting with the bitcoin (elctrum) network.
mixin ElectrumServiceProvider
    implements BaseServiceProvider<ElectrumRequestDetails> {
  @override
  Future<BaseServiceResponse<T>> doRequest<T>(ElectrumRequestDetails params,
      {Duration? timeout});
}
