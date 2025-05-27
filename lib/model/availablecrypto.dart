// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:coinswitch/controller/allavailableadress.dart';
import 'package:coinswitch/controller/assets.dart';
import 'package:coinswitch/controller/websocketServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final AllAvailableAddress allAvailableAddress = Get.put(AllAvailableAddress());
final AssetController assetController = Get.put(AssetController());

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
      percentageChange: bitcoinusdtPercentageChange,
      priceChange: bitcoinPriceChange,
      pictures: AssetImage('assets/images/bitcoin-btc-logo.png'),
      name: 'Bitcoin',
      format: 'UTXO',
      address: allAvailableAddress.bitcoinPublicKey,
      balance: assetController.bitcoinBalance),
  Availablecrypto(
      symbol: 'ETH',
      percentageChange: ethereumusdtPercentageChange,
      priceChange: ethereumusdtPriceChange,
      pictures: AssetImage('assets/images/ethereum.png'),
      name: 'Ethereum',
      format: 'EVM',
      address: allAvailableAddress.ethereumPublicKey,
      balance: assetController.ethereumBalance),
  Availablecrypto(
    symbol: 'SOL',
    percentageChange: solanausdtPercentageChange,
    pictures: AssetImage(
      'assets/images/Solana-Logo.png',
    ),
    priceChange: solanaPriceChange,
    format: 'SOL',
    name: 'Solana',
    address: allAvailableAddress.solanaPublicKey,
    balance: assetController.solanaBalance,
  ),
  Availablecrypto(
      symbol: 'BNB',
      percentageChange: bnbusdtPercentageChange,
      priceChange: bnbPriceChange,
      pictures: AssetImage('assets/images/bnb-bnb-logo.png'),
      name: 'Binance Chain',
      format: 'EVM',
      address: allAvailableAddress.ethereumPublicKey,
      balance: assetController.bnbBalance),
  Availablecrypto(
      symbol: 'LTC',
      percentageChange: ltcusdtPercentageChange,
      priceChange: ltcPriceChange,
      pictures: AssetImage('assets/images/Litecoin.svg.png'),
      name: 'Litecoin',
      format: 'EVM',
      address: allAvailableAddress.litecoinPublicKey,
      balance: assetController.litecoinBalance),
  Availablecrypto(
      symbol: 'DOGE',
      percentageChange: dogeusdtPercentageChange,
      priceChange: dogePriceChange,
      pictures: AssetImage(
          'assets/images/dogecoin-doge-logo-6DB3E069BA-seeklogo.com.png'),
      name: 'Dogecoin',
      format: 'UTXO',
      address: allAvailableAddress.dogecoinPublicKey,
      balance: assetController.dogecoinBalance),
  Availablecrypto(
      symbol: 'BCH',
      percentageChange: bchusdtPercentageChange,
      priceChange: bchPriceChange,
      pictures: AssetImage('assets/images/bitcoin-cash-bch-logo.png'),
      name: 'Bitcoin cash',
      format: 'EVM',
      address: allAvailableAddress.bitcoincashPublicKey,
      balance: assetController.bitcoincashBalance),
  Availablecrypto(
      symbol: 'XRP',
      percentageChange: xrpusdtPercentageChange,
      priceChange: xrpPriceChange,
      pictures: AssetImage('assets/images/xrp-logo.png'),
      name: 'Ripple',
      format: 'UTXO',
      address: allAvailableAddress.xrpPublicKey,
      balance: assetController.bitcoincashBalance),
];
