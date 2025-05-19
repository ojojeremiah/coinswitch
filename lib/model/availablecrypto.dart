// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:coinswitch/controller/allavailableadress.dart';
import 'package:coinswitch/controller/assets.dart';
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

  Availablecrypto({
    required this.pictures,
    this.name,
    this.address,
    this.balance,
    required this.format,
  });

  factory Availablecrypto.fromJson(Map<String, dynamic> json) =>
      Availablecrypto(
          name: json["name"],
          pictures: json["pictures"],
          format: json["format"],
          address: json["address"],
          balance: json["balance"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "pictures": pictures,
        "format": format,
        "address": address,
        "balance": balance
      };
}

List<Availablecrypto> available = [
  Availablecrypto(
      pictures: AssetImage('assets/images/bitcoin-btc-logo.png'),
      name: 'BTC',
      format: 'UTXO',
      address: allAvailableAddress.bitcoinPublicKey,
      balance: assetController.bitcoinBalance),
  Availablecrypto(
      pictures: AssetImage('assets/images/ethereum.png'),
      name: 'ETH',
      format: 'EVM',
      address: allAvailableAddress.ethereumPublicKey,
      balance: assetController.ethereumBalance),
  Availablecrypto(
    pictures: AssetImage(
      'assets/images/solana-sol-logo.png',
      // scale: 30,
      // fit: BoxFit.contain,
    ),
    format: 'SOL',
    name: 'SOL',
    address: allAvailableAddress.solanaPublicKey,
    balance: assetController.solanaBalance,
  ),
  Availablecrypto(
      pictures: AssetImage('assets/images/bnb-bnb-logo.png'),
      name: 'BNB',
      format: 'EVM',
      address: allAvailableAddress.ethereumPublicKey,
      balance: assetController.bnbBalance),
  Availablecrypto(
      pictures: AssetImage('assets/images/Litecoin.svg.png'),
      name: 'LTC',
      format: 'EVM',
      address: allAvailableAddress.litecoinPublicKey,
      balance: assetController.litecoinBalance),
  Availablecrypto(
      pictures: AssetImage(
          'assets/images/dogecoin-doge-logo-6DB3E069BA-seeklogo.com.png'),
      name: 'DOGE',
      format: 'UTXO',
      address: allAvailableAddress.dogecoinPublicKey,
      balance: assetController.dogecoinBalance),
  Availablecrypto(
      pictures: AssetImage('assets/images/bitcoin-cash-bch-logo.png'),
      name: 'BCH',
      format: 'EVM',
      address: allAvailableAddress.bitcoincashPublicKey,
      balance: assetController.bitcoincashBalance),
];
