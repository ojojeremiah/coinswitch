import 'electrumrequest_methods.dart';
import 'provider_core_params.dart';

/// Broadcast a transaction to the network.
/// https://electrumx-spesmilo.readthedocs.io/en/latest/protocol-methods.html
class ElectrumRequestBroadCastTransaction
    extends ElectrumRequest<String, String> {
  ElectrumRequestBroadCastTransaction({required this.transactionRaw});

  /// The raw transaction as a hexadecimal string.
  final String transactionRaw;

  /// blockchain.transaction.broadcast
  @override
  String get method => ElectrumRequestMethods.broadCast.method;

  @override
  List toJson() {
    return [transactionRaw];
  }

  /// The transaction hash as a hexadecimal string.
  @override
  String onResonse(result) {
    return result;
  }
}
