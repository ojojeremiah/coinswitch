import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:coinswitch/service/blockchain_utils_models_params.dart';
import 'package:coinswitch/service/electrum_provider_services.dart';
import 'package:coinswitch/service/provider_core_params.dart';
import 'package:coinswitch/service/request_compiler.dart';

class ElectrumWebSocketService with ElectrumServiceProvider {
  ElectrumWebSocketService._(
    this.url,
    this._channel, {
    this.defaultRequestTimeOut = const Duration(seconds: 30),
  }) {
    _subscription = _channel.stream
        .cast<String>()
        .listen(_onMessage, onError: _onClose, onDone: _onDone);
  }

  WebSocketChannel _channel;
  StreamSubscription<String>? _subscription;
  final Duration defaultRequestTimeOut;

  Map<int, AsyncRequestCompleter> requests = {};
  bool _isDisconnected = false;

  bool get isConnected => !_isDisconnected;

  final String url;

  void add(String params) {
    if (_isDisconnected) {
      throw StateError("Socket has been disconnected");
    }
    _channel.sink.add(params);
  }

  void _onClose(Object? error) {
    _isDisconnected = true;
    _subscription?.cancel();
    _subscription = null;
  }

  void _onDone() {
    _onClose(null);
  }

  void disconnect() {
    _channel.sink.close(status.goingAway);
    _onClose(null);
  }

  static Future<ElectrumWebSocketService> connect(
    String url, {
    Iterable<String>? protocols,
    Duration defaultRequestTimeOut = const Duration(seconds: 30),
  }) async {
    final channel = WebSocketChannel.connect(Uri.parse(url));
    return ElectrumWebSocketService._(url, channel,
        defaultRequestTimeOut: defaultRequestTimeOut);
  }

  void _onMessage(String event) {
    final Map<String, dynamic> decoded = json.decode(event);
    if (decoded.containsKey("id")) {
      final int id = int.parse(decoded["id"]!.toString());
      final request = requests.remove(id);
      request?.completer.complete(decoded);
    }
  }

  @override
  Future<BaseServiceResponse<T>> doRequest<T>(ElectrumRequestDetails params,
      {Duration? timeout}) async {
    final AsyncRequestCompleter completer =
        AsyncRequestCompleter(params.params);
    try {
      requests[params.requestID] = completer;
      add(json.encode(params.toWebSocketParams())); // Send JSON string
      final result = await completer.completer.future
          .timeout(timeout ?? defaultRequestTimeOut);
      return params.toResponse(result);
    } finally {
      requests.remove(params.requestID);
    }
  }
}
