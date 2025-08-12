// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:coinswitch/controller/allavailableadress.dart';
import 'package:coinswitch/controller/assets.dart';
import 'package:coinswitch/controller/crypto_price_info.dart';
import 'package:coinswitch/controller/websocketServices.dart';
import 'package:coinswitch/service/bitcoin_transaction.dart';
import 'package:coinswitch/service/send_bnb.dart';
import 'package:coinswitch/service/send_eth.dart';
import 'package:coinswitch/service/solana_transaction.dart';
import 'package:coinswitch/service/usdtErc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

final AllAvailableAddress allAvailableAddress = Get.put(AllAvailableAddress());
final AssetController assetController = Get.find();
final CryptoPriceInfo cryptoPriceInfo = Get.find();
final WebSocketController wsController = Get.put(WebSocketController());
final ethService = EthereumService();
final sendBTC = BitcoinTransaction();
final sendBnbService = BnbTransactionService();
final sendUsdt = EthereumUsdtService();

class Availablecrypto extends GetxController {
  dynamic name;
  ImageProvider? pictures;
  dynamic address;
  dynamic balance;
  dynamic format;
  RxDouble? priceChange;
  dynamic symbol;
  RxDouble? percentageChange;
  dynamic sendFunc;
  dynamic balanceInUsd;

  Availablecrypto(
      {this.pictures,
      this.name,
      this.symbol,
      this.priceChange,
      this.percentageChange,
      this.address,
      this.balance,
      this.format,
      this.sendFunc,
      this.balanceInUsd});

  // var selectedSymbol = 'BTC'.obs;
  // Availablecrypto? get selectedCrypto =>
  //     available.firstWhereOrNull((c) => c.symbol == selectedSymbol.value);

  factory Availablecrypto.fromJson(Map<String, dynamic> json) =>
      Availablecrypto(
          symbol: json["symbol"],
          percentageChange: json["percentageChange"],
          priceChange: json["priceChange"],
          name: json["name"],
          pictures: json["pictures"],
          format: json["format"],
          address: json["address"],
          balance: json["balance"],
          sendFunc: json["sendFunc"],
          balanceInUsd: json["balanceInUsd"]);

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "priceChange": priceChange,
        "percentageChange": percentageChange,
        "name": name,
        "pictures": pictures,
        "format": format,
        "address": address,
        "balance": balance,
        "sendFunc": sendFunc,
        "balanceInUsd": balanceInUsd,
      };
}

List<Availablecrypto> available = [
  Availablecrypto(
      symbol: 'BTC',
      percentageChange: cryptoPriceInfo.bitcoinPriceChangePercentage24H,
      priceChange: cryptoPriceInfo.bitcoinCurrentPrice,
      pictures: AssetImage('assets/images/bitcoin-btc-logo.png'),
      name: 'Bitcoin',
      format: 'UTXO',
      address: allAvailableAddress.bitcoinPublicKey,
      balance: assetController.bitcoinBalance,
      sendFunc: sendBTC.sendBitcoin,
      balanceInUsd: assetController.bitcoinBalance *
          cryptoPriceInfo.bitcoinCurrentPrice.value),
  Availablecrypto(
      symbol: 'ETH',
      percentageChange: cryptoPriceInfo.ethereumPriceChangePercentage24H,
      priceChange: cryptoPriceInfo.ethereumCurrentPrice,
      pictures: AssetImage('assets/images/ethereum.png'),
      name: 'Ethereum',
      format: 'EVM',
      address: allAvailableAddress.ethereumPublicKey,
      balance: assetController.ethereumBalance,
      // balanceInUsd: assetController.ethereumBalance.value *
      //     cryptoPriceInfo.ethereumCurrentPrice.value,
      sendFunc: ethService.sendEth),
  Availablecrypto(
      symbol: 'SOL',
      percentageChange: cryptoPriceInfo.solanaPriceChangePercentage24H,
      priceChange: cryptoPriceInfo.solanaCurrentPrice,
      pictures: AssetImage('assets/images/Solana-Logo.png'),
      name: 'Solana',
      format: 'SOL',
      address: allAvailableAddress.solanaPublicKey,
      balance: assetController.solanaBalance,
      // balanceInUsd: assetController.solanaBalance.value*cryptoPriceInfo.solanaCurrentPrice,
      sendFunc: sendSol),
  Availablecrypto(
      symbol: 'BNB',
      percentageChange: cryptoPriceInfo.bnbPriceChangePercentage24H,
      priceChange: cryptoPriceInfo.bnbCurrentPrice,
      pictures: AssetImage('assets/images/bnb-bnb-logo.png'),
      name: 'Binance Chain',
      format: 'EVM',
      address: allAvailableAddress.ethereumPublicKey,
      balance: assetController.bnbBalance,
      sendFunc: sendBnbService.sendBnb),
  Availablecrypto(
    symbol: 'TRX',
    percentageChange: cryptoPriceInfo.tronPriceChangePercentage24H,
    priceChange: cryptoPriceInfo.tronCurrentPrice,
    pictures: AssetImage('assets/images/tron.png'),
    name: 'Tron',
    format: 'TRX',
    address: allAvailableAddress.tronPublicKey,
    balanceInUsd:
        assetController.tronBalance * cryptoPriceInfo.tronCurrentPrice.value,
    balance: assetController.tronBalance,
  ),
  Availablecrypto(
      symbol: 'USDT',
      percentageChange: cryptoPriceInfo.etherusdtPriceChangePercentage24H,
      priceChange: cryptoPriceInfo.etherusdtCurrentPrice,
      pictures: AssetImage('assets/images/tether-usdt-logo.png'),
      name: 'Tether',
      format: 'EVM',
      address: allAvailableAddress.ethereumPublicKey,
      balance: assetController.usdtercBalance,
      sendFunc: sendUsdt.sendUsdt),
  Availablecrypto(
    symbol: 'POL',
    percentageChange: cryptoPriceInfo.polygonPriceChangePercentage24H,
    priceChange: cryptoPriceInfo.polygonCurrentPrice,
    pictures: AssetImage('assets/images/matic-logo.webp'),
    name: 'Polygon',
    format: 'EVM',
    address: allAvailableAddress.ethereumPublicKey,
    balance: assetController.polygonBalance,
  ),
  Availablecrypto(
    symbol: 'LTC',
    percentageChange: cryptoPriceInfo.bitcoinPriceChangePercentage24H,
    priceChange: cryptoPriceInfo.bitcoinCurrentPrice,
    pictures: AssetImage('assets/images/Litecoin.svg.png'),
    name: 'Litecoin',
    format: 'EVM',
    address: allAvailableAddress.litecoinPublicKey,
    balance: assetController.litecoinBalance,
  ),
  Availablecrypto(
    symbol: 'BCH',
    percentageChange: cryptoPriceInfo.bitcoinPriceChangePercentage24H,
    priceChange: cryptoPriceInfo.bitcoinCurrentPrice,
    pictures: AssetImage('assets/images/bitcoin-cash-bch-logo.png'),
    name: 'Bitcoin Cash',
    format: 'EVM',
    address: allAvailableAddress.bitcoincashPublicKey,
    balance: assetController.bitcoincashBalance,
  ),
  Availablecrypto(
    symbol: 'XRP',
    percentageChange: cryptoPriceInfo.bitcoinPriceChangePercentage24H,
    priceChange: cryptoPriceInfo.bitcoinCurrentPrice,
    pictures: AssetImage('assets/images/xrp-logo.png'),
    name: 'Ripple',
    format: 'UTXO',
    address: allAvailableAddress.xrpPublicKey,
    balance: assetController.bitcoincashBalance,
  ),
];
