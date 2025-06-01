// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:coinswitch/controller/allavailableadress.dart';
import 'package:coinswitch/controller/assets.dart';
import 'package:coinswitch/controller/websocketServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final AllAvailableAddress allAvailableAddress = Get.put(AllAvailableAddress());
final AssetController assetController = Get.put(AssetController());
final WebSocketController wsController = Get.put(WebSocketController());

class Availablecrypto {
  dynamic name;
  ImageProvider pictures;
  dynamic address;
  dynamic balance;
  String format;
  RxDouble priceChange;
  String symbol;
  RxDouble percentageChange;

  Availablecrypto({
    required this.pictures,
    this.name,
    required this.symbol,
    required this.priceChange,
    required this.percentageChange,
    this.address,
    this.balance,
    required this.format,
  });

  factory Availablecrypto.fromJson(Map<String, dynamic> json) =>
      Availablecrypto(
          symbol: json["symbol"],
          percentageChange: json["percentageChange"],
          priceChange: json["priceChange"],
          name: json["name"],
          pictures: json["pictures"],
          format: json["format"],
          address: json["address"],
          balance: json["balance"]);

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "priceChange": priceChange,
        "percentageChange": percentageChange,
        "name": name,
        "pictures": pictures,
        "format": format,
        "address": address,
        "balance": balance
      };
}

List<Availablecrypto> available = [
  Availablecrypto(
    symbol: 'BTC',
    percentageChange: wsController.percentageChanges['BTC-USDT'] ?? 0.0.obs,
    priceChange: wsController.priceChanges['BTC-USDT'] ?? 0.0.obs,
    pictures: AssetImage('assets/images/bitcoin-btc-logo.png'),
    name: 'Bitcoin',
    format: 'UTXO',
    address: allAvailableAddress.bitcoinPublicKey,
    balance: assetController.bitcoinBalance,
  ),
  Availablecrypto(
    symbol: 'ETH',
    percentageChange: wsController.percentageChanges['ETH-USDT'] ?? 0.0.obs,
    priceChange: wsController.priceChanges['ETH-USDT'] ?? 0.0.obs,
    pictures: AssetImage('assets/images/ethereum.png'),
    name: 'Ethereum',
    format: 'EVM',
    address: allAvailableAddress.ethereumPublicKey,
    balance: assetController.ethereumBalance,
  ),
  Availablecrypto(
    symbol: 'SOL',
    percentageChange: wsController.percentageChanges['SOL-USDT'] ?? 0.0.obs,
    priceChange: wsController.priceChanges['SOL-USDT'] ?? 0.0.obs,
    pictures: AssetImage('assets/images/Solana-Logo.png'),
    name: 'Solana',
    format: 'SOL',
    address: allAvailableAddress.solanaPublicKey,
    balance: assetController.solanaBalance,
  ),
  Availablecrypto(
    symbol: 'BNB',
    percentageChange: wsController.percentageChanges['BNB-USDT'] ?? 0.0.obs,
    priceChange: wsController.priceChanges['BNB-USDT'] ?? 0.0.obs,
    pictures: AssetImage('assets/images/bnb-bnb-logo.png'),
    name: 'Binance Chain',
    format: 'EVM',
    address: allAvailableAddress.ethereumPublicKey,
    balance: assetController.bnbBalance,
  ),
  Availablecrypto(
    symbol: 'LTC',
    percentageChange: wsController.percentageChanges['LTC-USDT'] ?? 0.0.obs,
    priceChange: wsController.priceChanges['LTC-USDT'] ?? 0.0.obs,
    pictures: AssetImage('assets/images/Litecoin.svg.png'),
    name: 'Litecoin',
    format: 'EVM',
    address: allAvailableAddress.litecoinPublicKey,
    balance: assetController.litecoinBalance,
  ),
  Availablecrypto(
    symbol: 'DOGE',
    percentageChange: wsController.percentageChanges['DOGE-USDT'] ?? 0.0.obs,
    priceChange: wsController.priceChanges['DOGE-USDT'] ?? 0.0.obs,
    pictures: AssetImage(
        'assets/images/dogecoin-doge-logo-6DB3E069BA-seeklogo.com.png'),
    name: 'Dogecoin',
    format: 'UTXO',
    address: allAvailableAddress.dogecoinPublicKey,
    balance: assetController.dogecoinBalance,
  ),
  Availablecrypto(
    symbol: 'BCH',
    percentageChange: wsController.percentageChanges['BCH-USDT'] ?? 0.0.obs,
    priceChange: wsController.priceChanges['BCH-USDT'] ?? 0.0.obs,
    pictures: AssetImage('assets/images/bitcoin-cash-bch-logo.png'),
    name: 'Bitcoin Cash',
    format: 'EVM',
    address: allAvailableAddress.bitcoincashPublicKey,
    balance: assetController.bitcoincashBalance,
  ),
  Availablecrypto(
    symbol: 'XRP',
    percentageChange: wsController.percentageChanges['XRP-USDT'] ?? 0.0.obs,
    priceChange: wsController.priceChanges['XRP-USDT'] ?? 0.0.obs,
    pictures: AssetImage('assets/images/xrp-logo.png'),
    name: 'Ripple',
    format: 'UTXO',
    address: allAvailableAddress.xrpPublicKey,
    balance: assetController.bitcoincashBalance,
  ),
];
