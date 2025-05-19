import 'package:bitcoin_base/bitcoin_base.dart';
import 'package:coinswitch/controller/allavailableadress.dart';
import 'package:coinswitch/service/electrum_reqest_broadcast_transaction.dart';
import 'package:coinswitch/service/electrumwebsocket_services.dart';
import 'package:get/get.dart';

import 'electrum_provider.dart';
import 'electrum_request_scripthashlist_unspent.dart';

class Transactions {
  final allAvailableAddress = Get.find<AllAvailableAddress>();

  /// Set your custom fee rate (satoshis per byte)
  final BigInt customFeeRate = BigInt.from(21);

  Future<void> electrumConnection() async {
    final service = await ElectrumWebSocketService.connect(
        "wss://electrum2.bluewallet.io:50004");

    final examplePublicKey = allAvailableAddress.bitcoinPublicKey.value;
    final provider = ElectrumProvider(service);

    await processTransaction(examplePublicKey, provider);
  }

  Future<void> processTransaction(
      String examplePublicKey, ElectrumProvider provider) async {
    final privateKey =
        ECPrivate.fromHex(allAvailableAddress.userwalletPrivateKey.value);

    final spender = ECPublic.fromHex(examplePublicKey).toSegwitAddress();

    final List<UtxoWithAddress> accountsUtxos = [];
    final electrumUtxos = await provider.request(
        ElectrumRequestScriptHashListUnspent(scriptHash: spender.pubKeyHash()));

    accountsUtxos.addAll(electrumUtxos.map((e) => UtxoWithAddress(
          utxo: e.toUtxo(spender.type),
          ownerDetails:
              UtxoAddressDetails(publicKey: examplePublicKey, address: spender),
        )));

    final sumOfUtxo = accountsUtxos.sumOfUtxosValue();
    if (sumOfUtxo == BigInt.zero) {
      print("❌ No UTXOs available. Transaction cannot proceed.");
      return;
    }

    final List<BitcoinOutput> outPuts = [
      BitcoinOutput(address: spender, value: BtcUtils.toSatoshi("0.00001")),
    ];

    const String memo = "https://github.com/mrtnetwork";

    int transactionSize = BitcoinTransactionBuilder.estimateTransactionSize(
      utxos: accountsUtxos,
      outputs: [...outPuts],
      network: BitcoinNetwork.testnet,
      memo: memo,
      enableRBF: true,
    );

    // ✅ Apply custom fee rate
    final BigInt fee = customFeeRate * BigInt.from(transactionSize);

    // ✅ Adjust change value
    final changeValue = sumOfUtxo -
        (outPuts.fold(BigInt.zero, (prev, e) => prev + e.value) + fee);

    if (changeValue.isNegative) {
      print("❌ Insufficient balance for transaction.");
      return;
    }

    // ✅ Add change output if applicable
    if (changeValue > BigInt.zero) {
      outPuts.add(BitcoinOutput(address: spender, value: changeValue));
    }

    // ✅ Create and sign transaction
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

    final transaction =
        builder.buildTransaction((trDigest, utxo, publicKey, sighash) {
      return privateKey.signInput(trDigest, sigHash: sighash);
    });

    // ✅ Broadcast transaction
    final rawTransaction = transaction.serialize();
    await provider.request(
        ElectrumRequestBroadCastTransaction(transactionRaw: rawTransaction));

    print("✅ Transaction broadcasted successfully!");
  }
}
