import 'dart:convert';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketController extends GetxController {
  final RxMap<String, RxDouble> priceChanges = <String, RxDouble>{}.obs;
  final RxMap<String, RxDouble> percentageChanges = <String, RxDouble>{}.obs;
  final RxMap<String, RxDouble> volumeTraded = <String, RxDouble>{}.obs;

  final Map<String, String> wsUrls = {
    "BTC-USDT": "wss://stream.binance.com:9443/ws/btcusdt@ticker",
    "ETH-USDT": "wss://stream.binance.com:9443/ws/ethusdt@ticker",
    "BNB-USDT": "wss://stream.binance.com:9443/ws/bnbusdt@ticker",
    "SOL-USDT": "wss://stream.binance.com:9443/ws/solusdt@ticker",
    "BCH-USDT": "wss://stream.binance.com:9443/ws/bchusdt@ticker",
    "LTC-USDT": "wss://stream.binance.com:9443/ws/ltcusdt@ticker",
    "TON-USDT": "wss://stream.binance.com:9443/ws/tonusdt@ticker",
    "DOGE-USDT": "wss://stream.binance.com:9443/ws/dogeusdt@ticker",
    "XRP-USDT": "wss://stream.binance.com:9443/ws/xrpusdt@ticker",
    "POL-USDT": "wss://stream.binance.com:9443/ws/polusdt@ticker",
    "USDC-USDT": "wss://stream.binance.com:9443/ws/usdsusdt@ticker",
  };

  final Map<String, WebSocketChannel> _channels = {};

  @override
  void onInit() {
    super.onInit();
    _initializeWebSockets();
  }

  void _initializeWebSockets() {
    for (final entry in wsUrls.entries) {
      final symbol = entry.key;
      final url = entry.value;

      priceChanges[symbol] = 0.0.obs;
      percentageChanges[symbol] = 0.0.obs;
      volumeTraded[symbol] = 0.0.obs;

      final channel = WebSocketChannel.connect(Uri.parse(url));
      _channels[symbol] = channel;

      channel.stream.listen((message) {
        final data = jsonDecode(message);
        priceChanges[symbol]!.value = double.tryParse(data['c'] ?? '0') ?? 0.0;
        percentageChanges[symbol]!.value =
            double.tryParse(data['P'] ?? '0') ?? 0.0;
        volumeTraded[symbol]!.value = double.tryParse(data['q'] ?? '0') ?? 0.0;
      });
    }
  }

  @override
  void onClose() {
    for (final channel in _channels.values) {
      channel.sink.close();
    }
    _channels.clear();
    super.onClose();
  }
}
