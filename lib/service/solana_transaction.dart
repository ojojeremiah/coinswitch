import 'dart:developer';

import 'package:coinswitch/model/availablecrypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:solana/base58.dart';
import 'package:solana/solana.dart';

Future<String> sendSol(
  String toAddress,
  num amountInSol, // accepts user input like 0.015 SOL
) async {
  try {
    final rpcUrl = dotenv.env['SOLANA_RPC_URL'];
    if (rpcUrl == null || rpcUrl.isEmpty) {
      throw Exception('SOLANA_RPC_URL not set in .env');
    }

    final solanaClient = RpcClient(rpcUrl);
    final privateKeyBase58 = allAvailableAddress.userwalletPrivateKey.value;
    final privateKeyMnemonic =
        await Ed25519HDKeyPair.fromMnemonic(privateKeyBase58);
    final prKey = privateKeyMnemonic.address;
    final privateKeyBytes = base58decode(prKey);

    final senderKeyPair = Ed25519HDPublicKey(privateKeyBytes);

    final totalLamports = amountInSol * 1e9;

    // Fee (1.85%)
    final feeLamports = totalLamports * 0.0185;
    final sendLamports = totalLamports - feeLamports;

    if (sendLamports <= 0) {
      throw Exception("Amount too small after fee deduction.");
    }

    final feeAddress = dotenv.env['SOLANA_FEE_ADDRESS'];
    if (feeAddress == null || feeAddress.isEmpty) {
      throw Exception('SOLANA_FEE_ADDRESS not set in .env');
    }

    // Transfer: values must be int
    final instructionToRecipient = SystemInstruction.transfer(
      fundingAccount: senderKeyPair,
      recipientAccount: Ed25519HDPublicKey.fromBase58(toAddress),
      lamports: sendLamports.toInt(),
    );

    final instructionToFee = SystemInstruction.transfer(
      fundingAccount: senderKeyPair,
      recipientAccount: Ed25519HDPublicKey.fromBase58(feeAddress),
      lamports: feeLamports.toInt(),
    );

    final message = Message(instructions: [
      instructionToRecipient,
      instructionToFee,
    ]);

    final signature = await solanaClient
        .signAndSendTransaction(message, [privateKeyMnemonic]);

    return signature;
  } catch (e) {
    throw Exception('Failed to send SOL: $e');
  }
}
