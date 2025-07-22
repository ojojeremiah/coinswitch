import 'dart:developer';
import 'package:coinswitch/controller/allavailableadress.dart';
import 'package:coinswitch/model/bit_coin_rpc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class BitcoinTransaction {
  final AllAvailableAddress allAvailableAddress =
      Get.put(AllAvailableAddress());

  final bitcoin = BitcoinRpcChainstack(
    rpcUrl: dotenv.env['BIT_RPC_URL'] ?? '',
    username: dotenv.env['BIT_RPC_USER'] ?? '',
    password: dotenv.env['BIT_RPC_PASSWORD'] ?? '',
  );

  Future<void> sendBitcoin(
      String recipientAddress, dynamic userAmountBTC) async {
    dynamic senderAddress = allAvailableAddress.bitcoinPublicKey.value;
    try {
      final utxos = await bitcoin.listUnspent(senderAddress);

      if (utxos.isEmpty) {
        log("No UTXOs found.");
        return;
      }

      final feeRateResponse = await bitcoin.rpcCall('estimatesmartfee', [6]);
      int satPerVbyte = 18;

      if (feeRateResponse != null && feeRateResponse['feerate'] != null) {
        final double btcPerKb = feeRateResponse['feerate'];
        satPerVbyte = (btcPerKb * 100000000 / 1000).round();
      }
      log('Estimated fee rate: $satPerVbyte sat/vByte');

      int userAmountSats = (userAmountBTC * 100000000).toInt();

      int personalFeeSats = (userAmountSats * 0.0185).round();
      int estimatedTxSizeBytes = 200;
      int feeSats = estimatedTxSizeBytes * satPerVbyte;

      int amountToSendSats = userAmountSats - personalFeeSats - feeSats;

      if (amountToSendSats <= 0) {
        throw Exception("Amount too small after fees.");
      }

      final utxo = utxos.first;
      int utxoAmountSats = (utxo['amount'] * 100000000).toInt();

      int changeSats = utxoAmountSats - userAmountSats;

      if (changeSats < 0) {
        throw Exception("Insufficient UTXO amount.");
      }

      final inputs = [
        {
          'txid': utxo['txid'],
          'vout': utxo['vout'],
        }
      ];

      // Outputs in BTC
      final outputs = {
        recipientAddress: amountToSendSats / 100000000,
        dotenv.env['BITCOIN_FEE_ADRESS'] ?? '': personalFeeSats / 100000000,
      };

      if (changeSats > 546) {
        outputs[senderAddress] = changeSats / 100000000;
      }

      // Build, sign, and send the transaction
      final rawTx = await bitcoin.createRawTransaction(inputs, outputs);
      final signedTx = await bitcoin.signRawTransaction(rawTx);

      if (signedTx['complete'] != true) {
        throw Exception('Transaction not fully signed.');
      }

      final txid = await bitcoin.sendRawTransaction(signedTx['hex']);
      log("Sent BTC. TXID: $txid");
    } catch (e) {
      log("Error sending BTC: $e");
    }
  }
}
