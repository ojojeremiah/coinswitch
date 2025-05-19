import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:coinswitch/controller/allavailableadress.dart';
import 'package:coinswitch/service/electrumwebsocket_services.dart';
import 'package:coinswitch/service/electrum_reqest_broadcast_transaction.dart';
import 'package:bitcoin_base/bitcoin_base.dart';
import '../service/electrum_provider.dart';
import '../service/electrum_request_scripthashlist_unspent.dart';

class BitcoinTransactionScreen extends StatefulWidget {
  @override
  _BitcoinTransactionScreenState createState() =>
      _BitcoinTransactionScreenState();
}

class _BitcoinTransactionScreenState extends State<BitcoinTransactionScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController recipientAddressController =
      TextEditingController();
  final transactionStatus = "Enter details and send transaction".obs;
  final BigInt customFeeRate = BigInt.from(17); // Fee rate in satoshis per byte

  Future<void> sendBitcoinTransaction() async {
    try {
      transactionStatus.value = "⏳ Connecting to Electrum...";
      final service = await ElectrumWebSocketService.connect(
          "wss://electrum2.bluewallet.io:50004");

      final allAvailableAddress = Get.put(AllAvailableAddress());
      final provider = ElectrumProvider(service);
      final examplePublicKey = allAvailableAddress.bitcoinPublicKey.value;
      final privateKey =
          ECPrivate.fromHex(allAvailableAddress.userwalletPrivateKey.value);
      final sender = ECPublic.fromHex(examplePublicKey).toSegwitAddress();
      final dynamic recipientAddress = recipientAddressController.text.trim();

      if (recipientAddress.isEmpty) {
        transactionStatus.value = "❌ Please enter a recipient address.";
        return;
      }

      final List<UtxoWithAddress> accountsUtxos = [];
      final electrumUtxos = await provider.request(
          ElectrumRequestScriptHashListUnspent(
              scriptHash: sender.pubKeyHash()));

      accountsUtxos.addAll(electrumUtxos.map((e) => UtxoWithAddress(
            utxo: e.toUtxo(sender.type),
            ownerDetails: UtxoAddressDetails(
                publicKey: examplePublicKey, address: sender),
          )));

      final sumOfUtxo = accountsUtxos.sumOfUtxosValue();
      if (sumOfUtxo == BigInt.zero) {
        transactionStatus.value =
            "❌ No UTXOs available. Transaction cannot proceed.";
        return;
      }

      final BigInt sendAmount = BtcUtils.toSatoshi(amountController.text);

      final List<BitcoinOutput> outPuts = [
        BitcoinOutput(
            address: recipientAddress, value: sendAmount), // Send to recipient
      ];

      const String memo = "https://github.com/mrtnetwork";
      int transactionSize = BitcoinTransactionBuilder.estimateTransactionSize(
        utxos: accountsUtxos,
        outputs: [...outPuts],
        network: BitcoinNetwork.testnet,
        memo: memo,
        enableRBF: true,
      );

      final BigInt fee = customFeeRate * BigInt.from(transactionSize);
      final changeValue = sumOfUtxo - (sendAmount + fee);

      if (changeValue.isNegative) {
        transactionStatus.value = "❌ Insufficient balance for transaction.";
        return;
      }

      // Add change output if applicable
      if (changeValue > BigInt.zero) {
        outPuts.add(BitcoinOutput(address: sender, value: changeValue));
      }

      final builder = BitcoinTransactionBuilder(
        outPuts: outPuts,
        fee: fee,
        network: BitcoinNetwork.testnet,
        utxos: accountsUtxos,
        memo: memo,
        inputOrdering: BitcoinOrdering.bip69,
        outputOrdering: BitcoinOrdering.bip69,
        enableRBF: true,
      );

      // ✅ FIXED: Corrected transaction signing and serialization
      final transaction =
          builder.buildTransaction((trDigest, utxo, publicKey, sighash) {
        return privateKey.signInput(trDigest, sigHash: sighash);
      });

      final String rawTransaction =
          transaction.serialize(); // Ensure correct HEX encoding

      final broadcastResponse = await provider.request(
          ElectrumRequestBroadCastTransaction(transactionRaw: rawTransaction));

      if (broadcastResponse == true) {
        transactionStatus.value = "✅ Transaction broadcasted successfully!";
      } else {
        transactionStatus.value = "❌ Transaction failed: ${broadcastResponse}";
      }
    } catch (e) {
      transactionStatus.value = "❌ Transaction failed: $e";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Send Bitcoin")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Recipient Bitcoin Address", style: TextStyle(fontSize: 18)),
            TextField(
              controller: recipientAddressController,
              decoration: InputDecoration(
                labelText: "Recipient Address",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Text("Enter amount to send (BTC)", style: TextStyle(fontSize: 18)),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Amount (BTC)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Obx(() =>
                Text(transactionStatus.value, style: TextStyle(fontSize: 16))),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await sendBitcoinTransaction();
              },
              child: Text("Send Transaction"),
            ),
          ],
        ),
      ),
    );
  }
}
