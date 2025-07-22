import 'package:dio/dio.dart';
import 'dart:convert';

class BitcoinRpcChainstack {
  final Dio _dio;

  BitcoinRpcChainstack({
    required String rpcUrl,
    required String username,
    required String password,
  }) : _dio = Dio(BaseOptions(
          baseUrl: rpcUrl,
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Basic ${base64Encode(utf8.encode('$username:$password'))}',
          },
        ));

  Future<dynamic> rpcCall(String method,
      [List<dynamic> params = const []]) async {
    final body = {
      'jsonrpc': '1.0',
      'id': 'flutter',
      'method': method,
      'params': params,
    };

    final response = await _dio.post('', data: jsonEncode(body));
    if (response.statusCode == 200) {
      final data = response.data;
      if (data['error'] != null) throw data['error'];
      return data['result'];
    } else {
      throw Exception(
          "RPC call failed: ${response.statusCode} ${response.statusMessage}");
    }
  }

  Future<List<dynamic>> listUnspent(String? address) async {
    final params = (address != null)
        ? [
            1,
            9999999,
            [address]
          ]
        : [];
    return await rpcCall("listunspent", params);
  }

  Future<String> sendRawTransaction(String hex) async {
    return await rpcCall("sendrawtransaction", [hex]);
  }

  Future<String> createRawTransaction(
      List inputs, Map<String, dynamic> outputs) async {
    return await rpcCall("createrawtransaction", [inputs, outputs]);
  }

  Future<Map<String, dynamic>> signRawTransaction(String hex) async {
    return await rpcCall("signrawtransactionwithwallet", [hex]);
  }
}
