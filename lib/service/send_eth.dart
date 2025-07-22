import 'dart:developer';

import 'package:coinswitch/controller/allavailableadress.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

class EthereumService {
  String? rpcUrl;
  Web3Client? client;
  EthPrivateKey? credentials;

  final AllAvailableAddress allAvailableAddress =
      Get.put(AllAvailableAddress());

  Future<void> initialize() async {
    rpcUrl = dotenv.env['RPC_URL'] ?? '';
    if (rpcUrl!.isEmpty) throw Exception('RPC_URL not found in .env');

    final privateKey = allAvailableAddress.userwalletPrivateKey.value;
    if (privateKey.isEmpty) throw Exception('Private key is empty');

    client = Web3Client(rpcUrl!, Client());
    credentials = EthPrivateKey.fromHex(privateKey);
  }

  Future<String> sendEth(String toAddressHex, double amountInEth) async {
    try {
      await initialize();

      if (amountInEth <= 0) {
        throw ArgumentError('amountInEth must be greater than 0');
      }

      final BigInt amountInWei = BigInt.from(amountInEth * 1e18);

      final toAddress = EthereumAddress.fromHex(toAddressHex);
      final sender = await credentials!.extractAddress();

      final feeAddressHex = dotenv.env['ETHEREUM_FEE_ADDRESS'];
      if (feeAddressHex == null || feeAddressHex.isEmpty) {
        throw Exception('ETHEREUM_FEE_ADDRESS not found in .env');
      }

      final feeReceiver = EthereumAddress.fromHex(feeAddressHex);
      final gasPrice = await client!.getGasPrice();

      // 1.85% fee calculation
      final BigInt fee = amountInWei * BigInt.from(185) ~/ BigInt.from(10000);
      final BigInt sendAmount = amountInWei - fee;

      if (sendAmount <= BigInt.zero) {
        throw Exception("Amount too small after fee deduction.");
      }

      // Transaction 1: send to user
      final tx1 = Transaction(
        from: sender,
        to: toAddress,
        value: EtherAmount.fromUnitAndValue(EtherUnit.wei, sendAmount),
        gasPrice: gasPrice,
        maxGas: 21000,
      );

      final txHash1 =
          await client!.sendTransaction(credentials!, tx1, chainId: 1);

      // Transaction 2: send fee to feeReceiver
      final tx2 = Transaction(
        from: sender,
        to: feeReceiver,
        value: EtherAmount.fromUnitAndValue(EtherUnit.wei, fee),
        gasPrice: gasPrice,
        maxGas: 21000,
      );

      await client!.sendTransaction(credentials!, tx2, chainId: 1);

      return txHash1;
    } catch (e, st) {
      print('sendEth error: $e');
      print(st);
      rethrow;
    }
  }
}
