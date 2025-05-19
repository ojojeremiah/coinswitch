import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

const String wsBitcoinUsdtUrl =
    "wss://stream.binance.com:9443/ws/btcusdt@ticker";
const String wsEthereumUsdtUrl =
    "wss://stream.binance.com:9443/ws/ethusdt@ticker";
const String wsSolanaUsdtUrl =
    "wss://stream.binance.com:9443/ws/solusdt@ticker";
const String wsBnbUsdtUrl = "wss://stream.binance.com:9443/ws/bnbusdt@ticker";
const String wsTonUsdtUrl = "wss://stream.binance.com:9443/ws/tonusdt@ticker";
const String wsLtcUsdtUrl = "wss://stream.binance.com:9443/ws/ltcusdt@ticker";
const String wsBchUsdtUrl = "wss://stream.binance.com:9443/ws/bchusdt@ticker";
const String wsDogeUsdtUrl = "wss://stream.binance.com:9443/ws/dogeusdt@ticker";
const String wsXrpUsdtUrl = "wss://stream.binance.com:9443/ws/xrpusdt@ticker";

late WebSocketChannel? channel;
late WebSocketChannel? ethereumchannel;
late WebSocketChannel? solanachannel;
late WebSocketChannel? bnbchannel;
late WebSocketChannel? tonchannel;
late WebSocketChannel? ltcchannel;
late WebSocketChannel? bchchannel;
late WebSocketChannel? dogechannel;
late WebSocketChannel? xrpchannel;

RxDouble bitcoinusdtPercentageChange = 0.0.obs;
RxDouble bitcoinPriceChange = 0.0.obs;
RxDouble totalBitcoinTraded = 0.0.obs;

RxDouble ethereumusdtPercentageChange = 0.0.obs;
RxDouble ethereumusdtPriceChange = 0.0.obs;
RxDouble totalEthereumTraded = 0.0.obs;

RxDouble solanausdtPercentageChange = 0.0.obs;
RxDouble solanaPriceChange = 0.0.obs;
RxDouble totalSolanaTraded = 0.0.obs;

RxDouble bnbusdtPercentageChange = 0.0.obs;
RxDouble bnbPriceChange = 0.0.obs;
RxDouble totalBnbTraded = 0.0.obs;

RxDouble ltcusdtPercentageChange = 0.0.obs;
RxDouble ltcPriceChange = 0.0.obs;
RxDouble totalLtcTraded = 0.0.obs;

RxDouble tonusdtPercentageChange = 0.0.obs;
RxDouble tonPriceChange = 0.0.obs;
RxDouble totalTonTraded = 0.0.obs;

RxDouble bchusdtPercentageChange = 0.0.obs;
RxDouble bchPriceChange = 0.0.obs;
RxDouble totalBchTraded = 0.0.obs;

RxDouble dogeusdtPercentageChange = 0.0.obs;
RxDouble dogePriceChange = 0.0.obs;
RxDouble totalDogeTraded = 0.0.obs;

RxDouble xrpusdtPercentageChange = 0.0.obs;
RxDouble xrpPriceChange = 0.0.obs;
RxDouble totalXrpTraded = 0.0.obs;

// BTC-USDT
Future connectBitcoinWebSocket() async {
  channel = WebSocketChannel.connect(Uri.parse(wsBitcoinUsdtUrl));

  channel!.stream.listen(
    (message) {
      Map getData = jsonDecode(message);
      log("======================================= web socket");
      bitcoinusdtPercentageChange.value =
          double.tryParse(getData['P'] ?? '0') ?? 0.0;
      bitcoinPriceChange.value = double.tryParse(getData['c'] ?? '0') ?? 0.0;
      totalBitcoinTraded.value = double.tryParse(getData['q'] ?? '0') ?? 0.0;
    },
  );
}

// ETH-USDT
Future connectEthereumWebSocket() async {
  ethereumchannel = WebSocketChannel.connect(Uri.parse(wsEthereumUsdtUrl));

  ethereumchannel!.stream.listen(
    (message) {
      Map getData = jsonDecode(message);
      log("======================================= web socket");
      ethereumusdtPercentageChange.value =
          double.tryParse(getData['P'] ?? '0') ?? 0.0;
      ethereumusdtPriceChange.value =
          double.tryParse(getData['c'] ?? '0') ?? 0.0;
      totalEthereumTraded.value = double.tryParse(getData['q'] ?? '0') ?? 0.0;
    },
  );
}

// SOL-USDT
Future connectSolanaWebSocket() async {
  solanachannel = WebSocketChannel.connect(Uri.parse(wsSolanaUsdtUrl));

  solanachannel!.stream.listen(
    (message) {
      Map getData = jsonDecode(message);
      log("======================================= web socket");
      solanausdtPercentageChange.value =
          double.tryParse(getData['P'] ?? '0') ?? 0.0;
      solanaPriceChange.value = double.tryParse(getData['c'] ?? '0') ?? 0.0;
      totalSolanaTraded.value = double.tryParse(getData['q'] ?? '0') ?? 0.0;
    },
  );
}

// BNB-USDT
Future connectBnbWebSocket() async {
  bnbchannel = WebSocketChannel.connect(Uri.parse(wsBnbUsdtUrl));

  bnbchannel!.stream.listen(
    (message) {
      Map getData = jsonDecode(message);
      log("======================================= web socket");
      bnbusdtPercentageChange.value =
          double.tryParse(getData['P'] ?? '0') ?? 0.0;
      bnbPriceChange.value = double.tryParse(getData['c'] ?? '0') ?? 0.0;
      totalBnbTraded.value = double.tryParse(getData['q'] ?? '0') ?? 0.0;
    },
  );
}

// LTC-USDT
Future connectLtcWebSocket() async {
  ltcchannel = WebSocketChannel.connect(Uri.parse(wsLtcUsdtUrl));

  ltcchannel!.stream.listen(
    (message) {
      Map getData = jsonDecode(message);
      log("======================================= web socket");
      ltcusdtPercentageChange.value =
          double.tryParse(getData['P'] ?? '0') ?? 0.0;
      ltcPriceChange.value = double.tryParse(getData['c'] ?? '0') ?? 0.0;
      totalLtcTraded.value = double.tryParse(getData['q'] ?? '0') ?? 0.0;
    },
  );
}

// TON-USDT
Future connectTonWebSocket() async {
  tonchannel = WebSocketChannel.connect(Uri.parse(wsTonUsdtUrl));

  tonchannel!.stream.listen(
    (message) {
      Map getData = jsonDecode(message);
      log("======================================= web socket");
      tonusdtPercentageChange.value =
          double.tryParse(getData['P'] ?? '0') ?? 0.0;
      tonPriceChange.value = double.tryParse(getData['c'] ?? '0') ?? 0.0;
      totalTonTraded.value = double.tryParse(getData['q'] ?? '0') ?? 0.0;
    },
  );
}

// BCH-USDT
Future connectBchWebSocket() async {
  bchchannel = WebSocketChannel.connect(Uri.parse(wsBchUsdtUrl));

  bchchannel!.stream.listen(
    (message) {
      Map getData = jsonDecode(message);
      log("======================================= web socket");
      bchusdtPercentageChange.value =
          double.tryParse(getData['P'] ?? '0') ?? 0.0;
      bchPriceChange.value = double.tryParse(getData['c'] ?? '0') ?? 0.0;
      totalBchTraded.value = double.tryParse(getData['q'] ?? '0') ?? 0.0;
    },
  );
}

// DOGE-USDT
Future connectDogeWebSocket() async {
  dogechannel = WebSocketChannel.connect(Uri.parse(wsDogeUsdtUrl));

  dogechannel!.stream.listen(
    (message) {
      Map getData = jsonDecode(message);
      log("======================================= web socket");
      dogeusdtPercentageChange.value =
          double.tryParse(getData['P'] ?? '0') ?? 0.0;
      dogePriceChange.value = double.tryParse(getData['c'] ?? '0') ?? 0.0;
      totalDogeTraded.value = double.tryParse(getData['q'] ?? '0') ?? 0.0;
    },
  );
}

// XRP-USDT
Future connectXrpWebSocket() async {
  xrpchannel = WebSocketChannel.connect(Uri.parse(wsXrpUsdtUrl));

  xrpchannel!.stream.listen(
    (message) {
      Map getData = jsonDecode(message);
      log("======================================= web socket");
      xrpusdtPercentageChange.value =
          double.tryParse(getData['P'] ?? '0') ?? 0.0;
      xrpPriceChange.value = double.tryParse(getData['c'] ?? '0') ?? 0.0;
      totalXrpTraded.value = double.tryParse(getData['q'] ?? '0') ?? 0.0;
    },
  );
}

class WebsocketData {
  String name;
  RxDouble priceChange;
  RxDouble volumeTraded;
  RxDouble percentageChange;

  WebsocketData({
    required this.name,
    required this.priceChange,
    required this.volumeTraded,
    required this.percentageChange,
  });
}

List<WebsocketData> data = [
  WebsocketData(
    name: "BTC-USDT",
    priceChange: bitcoinPriceChange,
    volumeTraded: totalBitcoinTraded,
    percentageChange: bitcoinusdtPercentageChange,
  ),
  WebsocketData(
    name: "ETH-USDT",
    priceChange: ethereumusdtPriceChange,
    volumeTraded: totalEthereumTraded,
    percentageChange: ethereumusdtPercentageChange,
  ),
  WebsocketData(
    name: "BNB-USDT",
    priceChange: bnbPriceChange,
    volumeTraded: totalBnbTraded,
    percentageChange: bnbusdtPercentageChange,
  ),
  WebsocketData(
    name: "SOL-USDT",
    priceChange: solanaPriceChange,
    volumeTraded: totalSolanaTraded,
    percentageChange: solanausdtPercentageChange,
  ),
  WebsocketData(
    name: "BCH-USDT",
    priceChange: bchPriceChange,
    volumeTraded: totalBchTraded,
    percentageChange: bchusdtPercentageChange,
  ),
  WebsocketData(
    name: "LTC-USDT",
    priceChange: ltcPriceChange,
    volumeTraded: totalLtcTraded,
    percentageChange: ltcusdtPercentageChange,
  ),
  WebsocketData(
    name: "TON-USDT",
    priceChange: tonPriceChange,
    volumeTraded: totalTonTraded,
    percentageChange: tonusdtPercentageChange,
  ),
  WebsocketData(
    name: "DOGE-USDT",
    priceChange: dogePriceChange,
    volumeTraded: totalDogeTraded,
    percentageChange: dogeusdtPercentageChange,
  ),
  WebsocketData(
    name: "XRP-USDT",
    priceChange: xrpPriceChange,
    volumeTraded: totalXrpTraded,
    percentageChange: xrpusdtPercentageChange,
  ),
];
